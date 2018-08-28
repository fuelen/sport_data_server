Bureaucrat.start(
  writer: Bureaucrat.MarkdownWriter,
  default_path: "docs/endpoints.md"
)

ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
