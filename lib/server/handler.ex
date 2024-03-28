defmodule Server.Handler do
  @doc """
  """
  def handle(request) do
    request 
    |> parse 
    |> route 
    |> format_response
  end

  @doc """
  Takes the request and parses it into a map.
  """
  def parse(request) do
  end

  @doc """
  Creates a new map that also has the response body.
  """
  def route(conv) do
  end

  @doc """
  Uses the map to create a response.
  """
  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Server.Handler.handle(request)
