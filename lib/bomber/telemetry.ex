defmodule Bomber.Telemetry do
  use Telemetry

  defp metrics(event_name, measurements) do
    Telemetry.emit(__MODULE__, event_name, measurements)
  end

  def my_function_started(pid) do
    metrics(:my_function_started, %{pid: pid})
  end

  def my_function_finished(pid, duration) do
    metrics(:my_function_finished, %{pid: pid, duration: duration})
  end
end
