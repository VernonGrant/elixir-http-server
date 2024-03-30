defmodule Server.Handler do
  @doc """
  """
  def handle(request) do
    request
    |> parse
    |> log
    |> route
    |> track
    |> format_response
  end

  def log(conv), do: IO.inspect(conv)

  @doc """
  Takes the request and parses it into a map.
  """
  def parse(request) do
    # Pattern matching wow.
    [mathod, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: mathod, path: path, status: 200, body: ""}
  end

  @doc """
  Creates a new map that also has the response body.
  """
  def route(%{path: "/wildthings"} = conv) do
    %{conv | status: 200, body: "Bears, Lions, Tigers"}
  end

  def route(%{path: "/bears"} = conv) do
    %{conv | status: 200, body: "Poo, Winni"}
  end

  def route(%{path: "/bears/" <> id} = conv) do
    %{conv | status: 200, body: "Here is Bear #{id}"}
  end

  def route(conv) do
    %{conv | status: 404, body: "Page was found"}
  end

  def track(%{status: 404} = conv) do
    IO.puts("The #{conv[:path]} went wild!!")
    conv
  end

  def track(conv), do: conv

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end

  @doc """
  Uses the map to create a response.
  """
  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.body)}

    #{conv.body}
    """
  end
end

# Just some random tests.

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Server.Handler.handle(request)
IO.puts(response)

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Server.Handler.handle(request)
IO.puts(response)

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Server.Handler.handle(request)
IO.puts(response)

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Server.Handler.handle(request)
IO.puts(response)
