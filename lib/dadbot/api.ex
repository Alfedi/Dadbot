defmodule Dadbot.Api do
  use Tesla

  def client() do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "https://icanhazdadjoke.com"},
      {Tesla.Middleware.Headers, [{"Accept", "application/json"}]}
    ]

    Tesla.client(middlewares)
  end

  def get_joke() do
    Tesla.get(client, "/")
  end

  def search(query) do
    Tesla.get(client, "/search", query: [page: 1, limit: 5, term: query])
  end
end
