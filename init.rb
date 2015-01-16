require 'espeo_clients_companies/models/user_patch'

Redmine::Plugin.register :espeo_clients_companies do
  name 'Clients & Companies plugin'
  author 'espeo@jtom.me'
  description "Adds Client & Company models and its' CRUD controllers."
  version '1.0.0'
  url 'http://espeo.pl'
  author_url 'http://jtom.me'
end
