defmodule Geeny.ConnectClientTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    System.put_env("GEENY_AUTHORIZE_URI","https://megazord.geeny.io/oauth2-provider/authorize")
    System.put_env("GEENY_TOKEN_URI","https://megazord.geeny.io/connect/oauth2-provider/token/")
    System.put_env("GEENY_SITE_URI","https://megazord.geeny.io")
    System.put_env(
      "GEENY_CLIENT_ID",
      "TLdgmA3FVAoTJYu7Ue45Dw6HzPQvQ8qzoC0zC2TR"
    )
    System.put_env(
      "GEENY_REDIRECT_URI",
      "http://localhost:4000/oauth/callback"
    )
  end

  test "#authorize_url!" do
    expected_url = "https://megazord.geeny.io/oauth2-provider/authorize?client_id=TLdgmA3FVAoTJYu7Ue45Dw6HzPQvQ8qzoC0zC2TR&redirect_uri=http%3A%2F%2Flocalhost%3A4000%2Foauth%2Fcallback&response_type=code"
    assert Geeny.ConnectClient.authorize_url! == expected_url
  end

  test "#get_token! returns a token when succesful" do
    use_cassette "get_connect_token" do
      client = Geeny.ConnectClient.get_token!(code: "MAT1RaOpfvyuovJW1dCrm5iKh2EdRz")
      assert (client.token.access_token) == "TKRETKg0s6hgORy5YVE9d8zfea5QcO"
    end
  end

  test "#get_token! returns nil when code has expired or incorrect" do
    use_cassette "get_connect_token_failure" do
      assert_raise ArgumentError, fn ->
        Geeny.ConnectClient.get_token!(code: "bad-token")
      end
    end
  end

  test "authenticating a user" do
    use_cassette "authenticate_new_user" do
      client = Geeny.ConnectClient.get_token!(code: "pZ83S7ohe6XS79XLPGAYjsQgCp9xpN")
      user = OAuth2.Client.get!(client, "/auth/me").body
      assert user["email"] == "diego@geeny.io"
      assert user["id"] == "9e0667e7-280f-466c-9fe3-b250453446b2"
    end
  end
end
