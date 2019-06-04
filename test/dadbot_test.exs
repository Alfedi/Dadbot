defmodule DadbotTest do
  use ExUnit.Case
  doctest Dadbot

  test "greets the world" do
    assert Dadbot.hello() == :world
  end
end
