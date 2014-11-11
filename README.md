# Pfadismn

## Setup

### config/application.yml
```yaml
defaults: &defaults
  event_reminder_forerun_hours: 48
  newsletter_group_leiter: "leiter@pfadismn.ch"
  newsletter_group_members: "members@pfadismn.ch"
  default_take_along: |
                      Pfadihemd
                      Kravatte

production: &production
  <<: *defaults

development: &development
  <<: *defaults
  event_reminder_forerun_hours: 0
  newsletter_group_leiter: "filou@pfadismn.ch"
  newsletter_group_members: "dev@pfadismn.ch"

test:
  <<: *development
```

### config/database.yml

```yaml
development: &development
  adapter: postgres
  encoding: utf8
  database: pfadismn_development
  pool: 5
  username: postgres
  password:

test: *development
production: *development
```
