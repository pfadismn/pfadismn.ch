require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'lvps87-230-19-26.dedicated.hosteurope.de'
set :deploy_to, '/home/rails/pfadismn.ch'
set :repository, 'ssh://git@git.unimatrix041.ch:11022/pfadi/pfadismn.git'
#set :repository, 'file:///home/rails/pfadismn.ch.git'
set :branch, 'production'
set :user, 'rails'
set :rails_env, 'production'

set :puma_pid_file, lambda { "#{deploy_to}/run/#{rails_env}.pid" }
set :delayed_pid_dir, lambda { "#{deploy_to}/run/delayed.pid.d" }
set :socket, lambda { "unix:///#{deploy_to}/run/#{rails_env}.sock" }
set :app_path, lambda { "#{deploy_to}/#{current_path}" }

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/email.yml', 'config/application.yml', 'log', 'public/photos', 'var']


# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
end

namespace :rails do
  task :'tmp_create' do
    queue %{
      echo "-----> Creating tmp/"
      #{echo_cmd %[#{rake} tmp:create]}
    }
  end
end

namespace :filesystem do
  task :'cleanup' do
    queue %{
      echo "-----> Resetting Permissions tmp/"
      chown -R rails:rails .
    }
  end
end

task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    queue   "export RAILS_ENV=#{rails_env}"
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    queue   'bundle exec rake assets:precompile'
    invoke :'rails:tmp_create'
    invoke :'filesystem:cleanup'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :restart
    end
  end
end

desc 'Starts the application'
task :start => :environment do
  queue "cd #{app_path}"
  queue "bundle exec puma -e #{rails_env} -d -b #{socket} --pidfile #{puma_pid_file}"
  queue "RAILS_ENV=#{rails_env} script/delayed_job --pid-dir #{delayed_pid_dir} start"
end

desc 'Stops the application'
task :stop => :environment do
  queue %[kill -9 `cat #{puma_pid_file}`]
  queue %[RAILS_ENV=#{rails_env} script/delayed_job --pid-dir #{delayed_pid_dir} stop]
end

desc 'Restarts the application'
task :restart => :environment do
  queue %[kill -9 `cat #{puma_pid_file}` || true]
  queue %[RAILS_ENV=#{rails_env} script/delayed_job --pid-dir #{delayed_pid_dir} stop || true]
  invoke :start
end
