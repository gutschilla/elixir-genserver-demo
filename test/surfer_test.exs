defmodule SurferTest do
  use ExUnit.Case
  doctest Surfer

  test "greets the world" do
    assert Surfer.hello() == :world
  end
end
