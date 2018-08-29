# SportDataServer

## Prerequisite

### Elixir and Erlang
  Install [`asdf version manager`](https://github.com/asdf-vm/asdf) with `elixir` and `erlang` plugins
  and run `asdf install`. Or install them manually in any other way using versions specified in `.tool-versions`.

### Other
  Optionally install [`direnv`](https://direnv.net/) for supporting variables from `.envrc`.
  Also you can use that file manally with `source .envrc` command without extra dependency.

## Development
  To start your Phoenix server:
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`
  * Run dialyzer with `mix dialyzer`

## Test
  * Run test suite with `mix test`
  * To generate documentation from tests use `DOC=1 mix test`. Generated file you can find in `docs/endpoints.md`

## Run in Docker
  Copy `.docker.env.example` to `.docker.env`.
  Build with `docker-compose build --build-arg APP_NAME=$APP_NAME --build-arg APP_VSN=$APP_VSN`
  and run `docker-compose up --scale app=3`. `$APP_NAME` and `$APP_VSN` variables you can find in `.envrc`.
  The result can be checked in a browser, navigating to [http://localhost:4000](http://localhost:4000).
  Open [http://localhost:1936](http://localhost:1936) (admin/admin) to check health of the cluster.

# About project
  This is just a server of data located in `priv/data.csv` using JSON and Proto Buffers.
  It doesn't use 3-rd party databases, only mechanisms built-in to Erlang/OTP.
  All data keep in [ETS](http://erlang.org/doc/man/ets.html) table with concurrent reads.
  There is a simple wrapper around ETS table `SportDataServer.DB`. Table is populated on app start using [`Task`](https://hexdocs.pm/elixir/Task.html).
  Even though typical phoenix app has contexts, this app is too small so it contains only 1 main context `SportDataServer`.
  Auto-generated documentation from tests can be found [here](docs/endpoints.md).
  proto files are located in `lib/sport_data_server_web/protobufs` directory.
