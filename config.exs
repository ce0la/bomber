config :telemetry,
  metrics: [
    bomber: [
      docs: %{"my_function_started" => "Function started", "my_function_finished" => "Function finished"},
      measurement: [:duration]
    ]
  ]

config :logger,
  backends: [:console, {LoggerFileBackend, :file}],
  level: :info

config :logger, :file,
  path: "logs/telemetry.log",
  level: :info
