# GORproject

## What is this project ?

This project aims to provide a REST API for a RPG-oriented chat. The API will be exposed through an elixir backend writen using the Phoenix framework, and will be open-source and self-hostable. We want to offer an alternative to people that would like to get in the P&P RPG world but who do not feel confident about speaking with strangers or putting themselves forward.

The game master will have features to easely handle the means of a P&P RPG (features yet to be fully defined). We also want to provide a global hub in which you can join a session whenever the game master is able to introduce you to the game. The list of features is still fluctuating, expect new things here!

For the first version, we do not want to force users to create accounts, but we're not sure if we want to enable user registration at all.

## Contributing

Feel free to create issues and/or pull requests, we would love your contribution ! There's no small help :)
We still didn't write any CONTRIBUTING guide, but writing some clean elixir code, formated with the default formatter (`mix format`), is a rather good start.

## Setup

### Requirements 

You'll need to install [`erlang`], [`elixir`], the [`phoenix framework`][`phoenix`], and [`postgresql`].

For [`elixir`] and [`erlang`] follow the instructions on the [elixir install page](https://elixir-lang.org/install.html). We use a minimal version of v1.7 for [`elixir`], which in turn requires a minimal version of v19.0 for [`erlang`]. You can check for the versions by running the following command:
```bash
$ elixir --version
Erlang/OTP 19 [erts-8.0] [64-bit] [smp:4:4] [async-threads:10]

Elixir 1.7.1 (compiled with Erlang/OTP 19)
```
For [`phoenix`], run the following commands in your shell (or powershell for windows users):
```bash
# only once, will install the package manager of elixir
# might ask for confirmation, if it does, do not say yes, it means you've already did it
$ mix local.hex

# install phoenix
$ mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
```
If it fails, please have a look at <https://hexdocs.pm/phoenix/installation.html>

For [`postgresql`], install using your prefered way, and setup the DB to match the config in [`config/dev.exs`](./config/dev.exs).

> :warning: This parts needs some serious changes, because right now, the config for postgresql is right in the repository, checked in, absolutly not flexible. We're still looking for a standard solution, matching what's being done in the real world (`env` variables, for exemple), but which still looks fine in regard to the best practices in the `erlang/OTP` world.

### Running

This is a standard `phoenix` app, so just do the following:
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Start Phoenix endpoint with `mix phx.server`

To see which routes are currently available, run `mix phx.routes`

You can now have fun with the API located at [`localhost:4000`](http://localhost:4000)!

## What about a frontend?

A frontend will certainly be written using [`react`](https://reactjs.org), but if you want to build one, feel free to do so! Be careful though, because we cannot give any guarantee on the stability of the API. Feel free to reach us on the issues to discuss on anything!

[`erlang`]: https://www.erlang.org/
[`elixir`]: https://elixir-lang.org/
[`phoenix`]: https://www.phoenixframework.org/
[`postgresql`]: https://www.postgresql.org
