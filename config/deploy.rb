set :application, "chroma32"
 
set :domain, 'chroma32.com'
 
role :web, "#{domain}"
role :app, "#{domain}"
role :db,  "#{domain}", :primary => true
 
set :user, "chroma32"
 
set :repository, "git@github.com:digitalpardoe/chroma32.git"
set :scm, "git"
set :branch, "master"
 
set :use_sudo, false
set :deploy_to, "/home/#{user}/rails"

before "deploy:setup", "deploy:remove_current"
after "deploy:update", "deploy:setup_symlinks", "deploy:init_submodules"
 
namespace :deploy do
 
	desc "Remove the default directories so that 'cap setup' can work correctly."
	task :remove_current do
		run "rm -Rf #{deploy_to}/current"
	end
 
	desc "Tasks to perform after the application has been updated on the server."
	task :setup_symlinks do
		run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
		run "ln -s #{shared_path}/assets/documents #{release_path}/tmp/documents"
	end
	
	desc "Initalize the git project's submodules."
	task :init_submodules do
	  run "cd #{release_path} && git submodule init && git submodule update"
  end
 
	desc "Restart application."
	task :restart do
		run "touch #{release_path}/tmp/restart.txt"
	end
 
end