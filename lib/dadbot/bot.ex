defmodule Dadbot.Bot do
  @bot :Dadbot

  use ExGram.Bot,
    name: @bot

  alias ExGram.Model.InlineQueryResultArticle
  alias ExGram.Model.InputTextMessageContent

  require Logger

  def bot(), do: @bot

  def handle({:command, "start", _}, context) do
    answer(context, "Wellcome to the hell of humour")
  end

  def handle({:command, "joke", _}, context) do
    {:ok, %{body: joke}} = Dadbot.Api.get_joke()
    {:ok, %{"joke" => chiste}} = Jason.decode(joke)
    answer(context, chiste)
  end

  def handle({:inline_query, %{query: text}}, context) do
    case text |> Dadbot.Api.search() |> generate_articles do
      {:ok, articles} -> answer_inline_query(context, articles)
      _ -> Logger.error("Upsie woopsie")
    end
  end

  def generate_articles(text) do
    {:ok,
     [
       %InlineQueryResultArticle{
         type: "article",
         id: text,
         title: text,
         input_message_content: %InputTextMessageContent{
           message_text: text,
           parse_mode: "Markdown"
         }
       }
     ]}
  end
end
