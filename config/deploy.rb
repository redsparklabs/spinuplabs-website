require "rvm/capistrano"
require "bundler/capistrano" 

set :use_sudo, false
set :user, 'dev'
set :domain, '192.241.211.105'
set :applicationdir, "/home/dev/tiger/workorder/"
set :deploy_to, "/home/dev/tiger/workorder/"
#set :deploy_to, :applicationdir

set :application, "Tiger Work Order"

set :repository,  "git@bitbucket.org:spinuplabs/tiger_workorder.git"
set :scm, :git
set :scm_verbose, true
set :branch, "master"

#set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true
#ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "192.241.211.105", :app, :web, :db, :primary => true

#before "deploy:cold", 
#    "deploy:install_bundler"

#task :install_bundler, :roles => :app do
#    run "type -P bundle &>/dev/null || { gem install bundler --no-rdoc --no-ri; }"
#end
#
after 'deploy:cold', 'deploy:create'

after 'deploy:update_code', 'deploy:migrate'

set :keep_releases, 5
after "deploy:restart", "deploy:cleanup" 

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end