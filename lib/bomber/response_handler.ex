defmodule LogResponseHandler do
  require Logger

  def handle_event([:url, :request, :done], measurements, metadata, _config) do
    Logger.info(
      "[#{metadata.request_path}] #{metadata.status_code} sent in #{measurements.latency}"
    )
  end
end
