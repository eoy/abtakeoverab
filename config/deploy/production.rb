# TODO: Change IP
server "146.185.142.108", :web, :app, :db, primary: true
set :server_ip, '146.185.142.108'
set :rails_env, 'production'
set :whenever_environment, 'production'
