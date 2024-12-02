defmodule Bomber.Http do
  def get(url) do
    HTTPoison.get!(url)
  end
end
