module Sentry
  def self.platform(value = nil)
    @platform = value if value
    @platform ||= 'iPhoneOS'
    @platform
  end

  def self.upload_dsym
    api_key = App.config.sentry_auth_key
    org_slug = App.config.sentry_org_slug
    project_slug = App.config.sentry_project_slug

    unless app_id && api_key
      App.warn 'Missing Sentry keys, skipping dSYM upload.'
      return
    end

    if platform =~ /Simulator/ && App.config.sentry_disable_on_simulator_builds
      App.info 'Sentry', 'Skipping dSYM upload on simulator build.'
      return
    end

    zip_dsym!

    app_dsym = App.config.app_bundle_dsym(platform)
    command = "sentry-cli --api-key #{api_key}"\
                 " upload-dsym --org #{org_slug}"\
                 "--project #{project_slug}"
                 "#{app_dsym}.zip'"

    App.info 'Sentry', 'Uploading dSYM to Sentry...'
    output = %x[#{command}]
    if output =~ /^2\d+/
      App.info 'Sentry', 'Successfully uploaded dSYM to Sentry.'
    else
      p output
      App.fail 'Failed to upload dSYM to Sentry.'
    end
  end

  def self.zip_dsym!
    app_dsym = App.config.app_bundle_dsym(platform)
    App.info 'Sentry', 'Zipping dSYM file...'
    App.fail "Could not find dSYM file at #{app_dsym}" unless File.exist?(app_dsym)

    app_dsym_zip = app_dsym + '.zip'
    if !File.exist?(app_dsym_zip) or File.mtime(app_dsym) > File.mtime(app_dsym_zip)
      Dir.chdir(File.dirname(app_dsym)) do
        %x[/usr/bin/zip -q -r '#{File.basename(app_dsym)}.zip' '#{File.basename(app_dsym)}']
      end
    end
  end
end

require "sentry/rubymotion_extensions"
require "sentry/rake_tasks"