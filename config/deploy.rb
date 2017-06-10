require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :domain, '104.236.165.197'
set :rails_env, 'production'
set :branch, 'master'
set :application, "mattandjjowedding"
set :deploy_to, "/home/deployer/apps/#{application}"
set :app_path,   "#{deploy_to}/#{current_path}"
set :repository, "git@github.com:mattsears/mattandjjowedding.git"
set :user, 'deployer'
set :shared_paths, ['config/database.yml', 'log', 'config/puma.rb', 'public/uploads', '.env']

task :environment do
  queue %{export PATH=/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH}
end

desc "Setup the shared directories"
task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/uploads"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/uploads"]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :"rake['assets:sync']"

    to :launch do
      invoke :'restart'
    end
  end
end

task restart: :environment do
  queue "sudo service puma-manager restart"
end

task start: :environment do
  queue "sudo service puma-manager start"
end

task stop: :environment do
  queue "sudo service puma-manager stop"
end

task bootstrap: :environment do
  invoke :'setup'
  invoke :'deploy'
  invoke :"rake['reset']"
  invoke :'restart'
end
