# Ground scanner

A horrible attempt to make MySQL work with spatial queries in Rails 4.1. Could probably support Rails 4.2 too, but `rgeo-activerecord` is a little outdated and is currently looking for a new maintainer; an upgrade may be possible in the future.

Requirements:

* Ruby (1.9.3 may suffice, 2.0+ recommended)
* MySQL 5.6+ (5.5 won't do! `st_distance` function was introduced in 5.6)

Notes:

* This is a sloppy proof-of-concept.
* There is a little problem with database schema. When deploying this, do not `rake db:schema:load`, because `schema.rb` doesn't store information about created table's engine (MyISAM is needed). Migrate from scratch.
