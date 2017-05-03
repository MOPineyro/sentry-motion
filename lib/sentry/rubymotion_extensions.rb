module Sentry
  module BuilderExtensions
    def build(config, platform, opts)
      super
      puts platform
      Sentry.platform(platform)
      Sentry.upload_dsym
    end
  end
end

module Motion
  module Project
    class Builder
      prepend Sentry::BuilderExtensions
    end
  end
end

module Motion
  module Project
    class Config
      variable :sentry_auth_key, :sentry_org_slug, :sentry_project_slug, :sentry_disable_on_simulator_builds
    end
  end
end

Motion::Project::App.setup do |app|
  app.pods do
    pod 'Sentry', :git => 'git@github.com:getsentry/sentry-objc.git'
  end
end