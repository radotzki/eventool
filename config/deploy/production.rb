set :stage, :production
set :password, ask('Server password', nil)

server 'amitay.cloudapp.net', user: 'eventool', roles: %w{web app}, password: fetch(:password)
