defmodule Bomber.Http do
  def get(url) do
    :telemetry.execute(
      [:http_request_started],
      %{duration: 0},
      %{url: url}
    )

    start_time = System.monotonic_time()

    response = HTTPoison.get!(url)

    duration = System.monotonic_time() - start_time

    :telemetry.execute(
      [:http_request_finished],
      %{duration: duration},
      %{url: url, status_code: response.status_code, success: :ok}
    )

    response
  end
end
