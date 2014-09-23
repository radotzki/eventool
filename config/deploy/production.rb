set :stage, :production
set :password, ask('Server password', nil)

server 'amitay.cloudapp.net', user: 'root', roles: %w{web app}, password: fetch(:password)
