# Connection.new takes host and port.

host = '45.63.48.54'
port = 27017

database_name = case Padrino.env
  when :development then 'Myblog_development'
  when :production  then 'Myblog_production'
  when :test        then 'Myblog_test'
end

# Use MONGO_URI if it's set as an environmental variable.
database_settings = if ENV['MONGO_URI']
  {default: {uri: ENV['MONGO_URI'] }}
else
  {default: {hosts: ["#{host}:#{port}"], database: database_name}}
end

case Mongoid::VERSION
when /^(3|4)/
  Mongoid::Config.sessions = database_settings
else
  Mongoid::Config.load_configuration :clients => database_settings
end

# If you want to use a YML file for config, use this instead:
#
#   Mongoid.load!(File.join(Padrino.root, 'config', 'database.yml'), Padrino.env)
#
# And add a config/database.yml file like this:
#   development:
#     clients: #Replace clients with sessions to work with Mongoid version 3.x or 4.x
#       default:
#         database: Myblog_development
#         hosts:
#           - localhost:27017
#
#   production:
#     clients: #Replace clients with sessions to work with Mongoid version 3.x or 4.x
#       default:
#         database: Myblog_production
#         hosts:
#           - localhost:27017
#
#   test:
#     clients: #Replace clients with sessions to work with Mongoid version 3.x or 4.x
#       default:
#         database: Myblog_test
#         hosts:
#           - localhost:27017
#
#
# More installation and setup notes are on https://docs.mongodb.org/ecosystem/tutorial/mongoid-installation/
