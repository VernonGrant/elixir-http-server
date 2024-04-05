defmodule Server.Parser do
  alias Server.Conv, as: Conv

  @doc " Takes the request and parses it into a map."
  def parse(request) do
    [top | params_string] = String.split(request, "\n\n")
    [request_line | headers_lines] = String.split(top, "\n")
    [mathod, path, _] = String.split(request_line, " ")

    IO.inspect(params_string)

    headers = parse_headers(headers_lines, %{})

    # NOTE: Why did the demo no use list first here?
    # params = parse_params(List.first(params_string))
    IO.inspect(headers["Content-Type"])
    params = parse_params(headers["Content-Type"], List.first(params_string))

    %Conv{
      method: mathod,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers) do
    headers
  end
end
