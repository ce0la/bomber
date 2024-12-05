defmodule Bomber.Telemetry do

  defp metrics(event_name, measurements, metadata \\ %{}) do
    :telemetry.execute(event_name, measurements, metadata)
  end

  def my_function_started(pid) do
    metrics([:my_function_started], %{pid: pid})
  end

  def my_function_finished(pid, duration) do
    metrics([:my_function_finished], %{pid: pid, duration: duration})
  end

  def http_request_started(pid, url) do
    metrics([:http_request_started], %{pid: pid, url: url})
  end

  def http_request_finished(pid, url, duration, status_code, success) do
    metrics([:http_request_finished], %{
      pid: pid,
      url: url,
      duration: duration,
      status_code: status_code,
      success: success
    })
  end
end
