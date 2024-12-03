defmodule Bomber.Runner do
  import Task
  import Bomber.Telemetry

  def run(url, count) do
    tasks = Enum.map(1..count, fn _ ->
      Task.async(fn -> Bomber.Http.get(url) end)
    end)

    results = Task.await_many(tasks)
    #{:ok, results}
    {:ok =
      :telemetry.attach(
      # unique handler id
      "log-response-handler",
      [:url, :request, :done],
      &LogResponseHandler.handle_event/4,
      nil
    )

    #Enum.each(1..count, fn _ ->
    #  Bomber.Http.get(url)
    #end)
  end

  def my_function(url, count) do
    pid = self()
    my_function_started(pid)

    start_time = System.monotonic_time()

    run(url, count)

    duration = System.monotonic_time() - start_time
    my_function_finished(pid, duration)
  end
end
