# TODO: Change IP
server "146.185.153.61", :web, :app, :db, primary: true
set :server_ip, '146.185.153.61'
set :rails_env, 'production'
set :whenever_environment, 'production'
