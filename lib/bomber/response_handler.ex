defmodule LogResponseHandler do
  require Logger

  def handle_event([:url, :request, :done], measurements, metadata, _config) do
    # Format message to include telemetry data
    log_message = "[#{metadata[:url]}] Status: #{metadata[:status_code]} Duration: #{measurements[:duration]}ms Success: #{metadata[:success]}"
    Logger.info(log_message)
  end
end
