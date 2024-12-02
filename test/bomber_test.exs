defmodule BomberTest do
  use ExUnit.Case
  doctest Bomber

  test "greets the world" do
    assert Bomber.hello() == :world
  end
end
