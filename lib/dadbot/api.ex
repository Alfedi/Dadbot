defmodule Dadbot.Api do
  use Tesla

  def get_joke() do
    Tesla.get("https://icanhazdadjoke.com/", headers: [{"Accept", "text/plain"}])
  end
end
