defmodule Bomber.Runner do
  require Logger
  require System
  require Task
  import Bomber.Http

  def run(url, count) do
    tasks = Enum.map(1..count, fn _ ->
      Task.async(fn ->
        start_time = System.monotonic_time(:second)
        response = get(url)
        duration = System.monotonic_time(:second) - start_time
        Logger.info(%{url: response.request_url, status_code: response.status_code, duration: duration})
      end)
    end)

    results = Task.await_many(tasks)

    File.open!("/home/ce0la/Documents/work/projects/bomber/logs/telemetry.log", [:write], fn file ->
      IO.inspect(file, results, [])
    end)

  end
end
