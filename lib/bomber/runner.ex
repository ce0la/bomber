defmodule Bomber.Runner do
  require Logger
  require System
  require Task
  import Bomber.Telemetry

  def run(url, count) do
    :telemetry.attach(
      "log-request-handler",
      [:http_request_started, :http_request_finished],
      &Bomber.TelemetryHandler.handle_event/4,
      nil
    )

    tasks = Enum.map(1..count, fn _ ->
      Task.async(fn -> execute_request(url) end)
    end)

    results = Task.await_many(tasks)

    :telemetry.detach("log-request-handler")

    {:ok, results}
  end

  defp execute_request(url) do
    pid = self()

    :telemetry.execute(
      [:http_request_started],
      %{duration: 0},
      %{url: url}
    )

    # Log the start of the HTTP request
    # http_request_started(pid, url)

    # Track the start time for latency
    start_time = System.monotonic_time()

    try do
      response = Bomber.Http.get(url)
      duration = System.monotonic_time() - start_time
      :telemetry.execute(
        [:http_request_finished],
        %{duration: duration},
        %{url: url, status_code: response.status_code, success: :ok}
      )

      {:ok, url, response.status_code, duration}
    rescue
      e in HTTPoison.Error ->
        duration = System.monotonic_time() - start_time
        :telemetry.execute(
          [:http_request_finished],
          %{duration: duration},
          %{url: url, status_code: nil, success: :error, error: e}
        )
        Logger.error("Request failed: #{inspect(e)}")

        {:error, e, duration}
    end
  end
end
