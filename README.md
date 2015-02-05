# Offers - Clients & Companies

### A redmine plugin by Espeo Software.

## Description

Adds `Client` and `Company` models (similar to `User` and `Group`) and its CRUD controllers.

## Requirements

### Installation

1. Make sure your redmine installation already meets the above *requirements*.

2. Copy this plugin's contents or check out this repository into `/redmine/plugins/espeo_clients_companies` directory.

3. Run `bundle exec rake redmine:plugins:migrate`.

## Notes

This plugin replaces following redmine files (because to make this plugin work, we need to change some hardcoded templates):

- `app/views/users/index.html.erb`

This may cause some inconsistensy when Redmine gets updated or another plugin would want to replace this template.
