defmodule Dadbot.Bot do
  @bot :Dadbot

  use ExGram.Bot,
    name: @bot

  def bot(), do: @bot

  def handle({:command, "start", _}, context) do
    answer(context, "Wellcome to the hell of humour")
  end

  def handle({:command, "joke",_}, context) do
    {:ok, %{body: joke}} = Dadbot.Api.get_joke
    answer(context, joke)
  end

  def handle({:inline_query, %{query: text}}, context) do
    Dadbot.Api.search(text)
  end
end
