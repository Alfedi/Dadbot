defmodule Dadbot.Bot do
  @bot :Dadbot

  use ExGram.Bot,
    name: @bot

  alias ExGram.Model.InlineQueryResultArticle
  alias ExGram.Model.InputTextMessageContent

  require Logger

  def bot(), do: @bot

  def handle({:inline_query, %{query: ""}}, _context), do: :ok

  def handle({:command, "start", _}, context) do
    answer(context, "Wellcome to the hell of humour")
  end

  def handle({:command, "joke", _}, context) do
    {:ok, %{body: joke}} = Dadbot.Api.get_joke()
    {:ok, %{"joke" => chiste}} = Jason.decode(joke)
    answer(context, chiste)
  end

  def handle({:inline_query, %{query: text}}, context) do
    articles = text |> Dadbot.Api.search() |> generate_articles
    answer_inline_query(context, articles)
  end

  def generate_articles(text) do
    case text do
      {:ok, %{body: body}} ->
        {:ok, %{"results" => result}} = Jason.decode(body)

        Enum.map(result, fn x ->
          %InlineQueryResultArticle{
            type: "article",
            id: x["id"],
            title: x["joke"],
            input_message_content: %InputTextMessageContent{
              message_text: x["joke"],
              parse_mode: "Markdown"
            }
          }
        end)

      _ ->
        :error
    end
  end

  def handle(_, _) do
    :nothing
  end
end
