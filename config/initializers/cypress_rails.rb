return unless Rails.env.test?

Rails.application.load_tasks unless defined?(Rake::Task)

CypressRails.hooks.before_server_start do
  # (Re-)seed the database
  Rake::Task["db:seed:replant"].invoke
end

CypressRails.hooks.before_server_stop do
  # Purge and reload the test database so we don't leave our seeds in there
  Rake::Task["db:test:prepare"].invoke
end
