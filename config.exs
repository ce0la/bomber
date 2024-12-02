config :telemetry,
  metrics: [
    bomber: [
      docs: %{"my_function_started" => "Function started", "my_function_finished" => "Function finished"},
      measurement: [:duration]
    ]
  ]
