defmodule Bomber.Runner do
  import Task
  import Bomber.Telemetry

  def run(url, count) do
    tasks = Enum.map(1..count, fn _ ->
      Task.async(fn -> execute_request(url) end)
    end)

    Task.await_many(tasks)
  end

  defp execute_request(url) do
    pid = self()

    # Log the start of the HTTP request
    http_request_started(pid, url)

    # Track the start time for latency
    start_time = System.monotonic_time()

    try do
      response = Bomber.Http.get(url)

      duration = Sysem.monotonic_time() - start_time
      http_request_finished(pid, url, duration, response.status_code, :ok)
    rescue
      e in HTTPoison.Error ->
        duration = System.monotonic_time() - start_time
        http_request_finished(pid, url, duration, nil, {:error, e})
        Logger.error("Request failed: #{inspect(e)}")
    end
  end
end
