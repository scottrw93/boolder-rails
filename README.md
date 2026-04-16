# Boolder Rails

Boolder is the best way to discover bouldering in Wicklow. 

This is the code powering the [Boolder website](https://www.boolder.com) and all the backend & data processing.

NB: if you just want a quick access to the data, check out [boolder-data](https://github.com/boolder-org/boolder-data)

## Stack

- Ruby On Rails
- PostgreSQL
- Tailwind CSS
- [Stimulus](https://stimulus.hotwired.dev) / [Turbo](https://turbo.hotwired.dev)


## How to run the app (on a Mac)

### Basics

- install homebrew: https://brew.sh/
- install rvm: https://rvm.io


### Install Postgre
- cd to the app directory
- `brew install postgresql`
- `brew install postgis`
- `brew services start postgresql`
- `createdb dump-prod`

### Set up the app
- cd to the app directory
- install rails: `sudo gem install rails`
- `bundle install`
- `rake db:setup`

export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

### Import prod data
- `dropdb dump-prod && createdb dump-prod`
- `psql -d dump-prod < db/dump-prod.sql`
- `rake db:migrate`

### Run the app

- `bin/dev`

### Mapbox credentials

- Create an account on https://www.mapbox.com. 
- Go to the [Tokens]([url](https://account.mapbox.com/access-tokens/)) page and create a public token with all the public `scopes` (or just use the default token).
- Back in the Rails app, copy the `.env.example` to `.env` and fill out `MAPBOX_DEV_ACCESS_KEY` with your token
- Restart the server

### Optional: JOSM

Josm is an open source tool used by the OpenStreetMap community.
We use it to edit GeoJSON files.

- Follow the instructions here: `https://josm.openstreetmap.de/wiki/Download#macOS`
- Go to File > Preferences > Plugins
- Click on the checkbox next to `Fastdraw` and `PicLayer`, and then click on OK
- Restart Josm
- In the menu bar (on the left), click on `Fast Drawing mode` and then type `Q` to enter the options dialog. Click on `Draw closed polygons only`, choose `3` for `Starting Epsilon` and `Simplify with initial epsilon` for `Enter key mode`

## Running with Docker

```bash
docker compose up --build
```

The app will be available at `http://localhost:8080`.

### Set up the database (first time)

```bash
docker compose exec web bin/rails db:create db:migrate
```

### Admin

Go to `http://localhost:8080/en/admin` and log in with username `scott` and the value of `ADMIN_PASSWORD` from your docker-compose.yml.

## Common actions

### Open a Rails console

```bash
docker compose exec web bin/rails console
```

### Create an area

Areas must be created via the Rails console (there is no UI for this):

```ruby
Area.create!(name: "My Area", slug: "my-area", published: false)
```

Once created, edit it at `/en/admin/areas/my-area/edit`.

### Create a problem

Problems are created via the admin UI. Go to `/en/admin/problems/new`.

### Run migrations

```bash
docker compose exec web bin/rails db:migrate
```

## Contribute

Want to help us improve the app for thousands of climbers? Great!

Here are a few ways you can contribute:
- Open an issue if you find a bug
- Open an issue if you want to suggest an improvement
- Open a Pull Request (please get in touch with us beforehand, though)

We already have a lot of features waiting to be built, and lots of new ideas to try out!
We'd be happy to share the fun with you :)

As the project is still young, the best way to get started is to drop us a line at hello@boolder.com

You can also contribute to our mapping efforts at https://www.boolder.com/en/contribute
