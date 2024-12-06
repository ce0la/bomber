defmodule Bomber.Runner do
  require Logger
  require System
  require Task
  import Bomber.Http

  def run(url, count) do
    tasks = Enum.map(1..count, fn _ ->
      Task.async(fn -> get(url) end)
    end)

    results = Task.await_many(tasks)

    File.open!("/home/ce0la/Documents/work/projects/bomber/logs/telemetry.log", [:write], fn file ->
      IO.inspect(file, results, [])
    end)

    {:ok, results}
  end
end
