# Based on the oauth2 library README
# https://github.com/scrogson/oauth2
defmodule Geeny.ConnectClient do
  use OAuth2.Strategy

  # Public API
  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: System.get_env("GEENY_CLIENT_ID"),
      client_secret: System.get_env("GEENY_CLIENT_SECRET"),
      redirect_uri: System.get_env("GEENY_REDIRECT_URI"),
      site: System.get_env("GEENY_SITE_URI"),
      authorize_url: System.get_env("GEENY_AUTHORIZE_URI"),
      token_url: System.get_env("GEENY_TOKEN_URI")
    ])
  end

  def authorize_url! do
    OAuth2.Client.authorize_url!(client())
  end

  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  # Callbacks ####################

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
