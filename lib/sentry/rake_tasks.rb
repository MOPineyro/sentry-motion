namespace :sentry do
  desc 'Upload dSYM file to Sentry'
  task :upload_dsym do
    Sentry.upload_dsym
  end
end