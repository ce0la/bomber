defmodule Bomber.TelemetryHandler do
  require Logger

  def handle_event([:http_request_started], measurements, metadata, _config) do
    # Format message to include telemetry data
    log_message = "[#{metadata[:url]}] Status: #{metadata[:status_code]} Duration: #{measurements[:duration]}ms Success: #{metadata[:success]}"
    Logger.info(log_message)
  end

  def handle_event([:http_request_finished], measurements, metadata, _config) do
    Logger.info("""
      Request to #{metadata.url} finished with status: #{metadata.status_code}
      Duration: #{measurements.duration}ms
      Success: #{metadata.success}
    """)

    if metadata.success == :error do
      Logger.error("Request failed for #{metadata.url}: #{inspect(metadata.error)}")
    end
  end
end
