defmodule ProcsTest do
  use ExUnit.Case
  doctest Procs

  test "greets the world" do
    assert Procs.hello() == :world
  end
end
