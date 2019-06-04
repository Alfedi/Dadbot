defmodule Dadbot do
  use Application

  import Supervisor.Spec

  require Logger

  def start(_, _) do
    token = ExGram.Config.get(:dadbot, :token)

    children = [
      supervisor(ExGram, []),
      supervisor(Dadbot.Bot, [:polling, token])
    ]

    opts = [strategy: :one_for_one, name: Dadbot]

    case Supervisor.start_link(children, opts) do
      {:ok, _} = ok ->
        Logger.info("Starting bot")
        ok

      error ->
        Logger.error("Error with bot")
        error
    end
  end
end
