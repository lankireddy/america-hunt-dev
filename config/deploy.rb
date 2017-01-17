require File.expand_path('../environment',  __FILE__)

set :application, 'america-hunt'
set :deploy_user, 'apps'
set :repo_url, 'git@lab.metova.com:metova/america-hunt-web.git'
set :deploy_to, "/apps/#{fetch(:application)}"
set :ssh_options, { forward_agent: true }
set :keep_releases, 3
set :pty, false

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

set :linked_files, %w(config/unicorn.rb config/application.yml)

set :sidekiq_pid, -> { File.join(shared_path, 'pids', 'sidekiq.pid') }
set :unicorn_pid, -> { File.join(shared_path, 'pids', 'unicorn.pid') }
set :unicorn_config_path, -> { File.join(current_path, 'config', 'unicorn.rb') }

set :aws_autoscale_instance_size, 'm3.large'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :restart
end
