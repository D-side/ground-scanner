# Ground scanner

A horrible attempt to make MySQL work with spatial queries in Rails 4.1. Could probably support Rails 4.2 too, but `rgeo-activerecord` is a little outdated and is currently looking for a new maintainer; an upgrade may be possible in the future.

### Available queries:

* `/geo/search/coords/:name`
  * Fetches all cities with `name` starting with a given prefix in `:name`
  * Example: `/geo/search/coords/Saint`  
* `/geo/search/cities/:distance/:x/:y`
  * Fetches all cities, located at `:distance` (euclidean) or closer from the point, given by `:x` and `:y`
  * Example: `/geo/search/coords/30.0/0.0/100.0`

Both queries also accept an extra parameter: `?page=X`. The system is designed to potentially handle large amounts of data, so data is paginated. For the purposes of demonstration, each page contains 5 cities.

Distances are measured in abstract units, for no context was given in the problem itself.

### JSON format:

* `results`: an array of cities:
  * `name`: name of the city
  * `x`: X-coordinate
  * `y`: Y-coordinate
* `page`: `1` by default, otherwise the value given in parameters
* `total_pages`: the number of data pages avaiable for the given query: the maximum possible value of `page` that will yield any data

### Requirements:

* Ruby (1.9.3 may suffice, 2.0+ recommended)
* MySQL 5.6+ (5.5 won't do! `st_distance` function was introduced in 5.6)

### Notes:

* This is a sloppy proof-of-concept.
* I've had a hard time finding a way to construct an RGeo point. Therefore, I've built a shortcut class method `City.point`.
* Data is assumed present from another source, such as Rails console: upon launching, seed the database.
* There is a little problem with database schema. When deploying this, do not `rake db:schema:load`, because `schema.rb` doesn't store information about created table's engine (MyISAM is needed). Migrate from scratch.
* Using MySQL is not my decision. I would've rather used [PostGIS](http://postgis.net/), but this is what we have. Actually, launching the same code with PostGIS adapter may work (nothing's tied to MySQL but `Gemfile` and database configuration)
