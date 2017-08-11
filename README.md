# Geeny Connect Client for Elixir

## Introduction

A simple Elixir Client on top of HTTPoison that interacts with the Connect API of Geeny

## Installation

Just include the dependency in your `mix.exs` file.

```elixir
def deps do
  [
     {:connect_client_ex,
       git: "https://github.com/diegoeche/geeny_connect_client",
       branch: "master"
     }
  ]
end
```

## Setup & configuration

The library uses environment variable to configure the endpoints.

Environment Variables:
```
     # Connect
     GEENY_REDIRECT_URI = <your app host>/oauth/callback
     GEENY_CLIENT_ID = your app oauth id
     GEENY_CLIENT_SECRET = your client secret
```

## Get Started

Check the `/test` folder for a complete overview of the functionality supported.

## Usage

```elixir
    Geeny.ConnectClient.get_token!(code: "MAT1RaOpfvyuovJW1dCrm5iKh2EdRz")
```

## License

Copyright (C) 2017 Telefónica Germany Next GmbH, Charlottenstrasse 4, 10969 Berlin.

This project is licensed under the terms of the [Mozilla Public License Version 2.0](LICENSE.md).

Inconsolata font is copyright (C) 2006 The Inconsolata Project Authors. This Font Software is licensed under the [SIL Open Font License, Version 1.1](OFL.txt).
