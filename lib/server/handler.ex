defmodule Server.Handler do
  alias Server.Conv, as: Conv

  # Module attributes are defined at compile time.
  # @pages_path Path.expand("pages", File.cwd!())
  @pages_path Path.expand("../../pages", __DIR__)

  # Imports all the modules functions into the current module.
  # import Server.Plugins

  # Imports only a subset of modules into the current module.
  import Server.Parser, only: [parse: 1]
  import Server.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Server.FileHandler

  def handle(request) do
    request
    |> parse
    |> rewrite_path()
    |> log()
    |> route
    |> track()
    |> format_response
  end

  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    %Conv{
      conv
      | status: 200,
        body:
          "Bear of type #{conv.params["type"]} with the name #{conv.params["name"]} has been created!"
    }
  end

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %Conv{conv | status: 200, body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    %Conv{conv | status: 200, body: "Poo, Winni"}
  end

  def route(%Conv{method: "GET", path: "/bears/new"} = conv) do
    @pages_path
    |> Path.join("form.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    %Conv{conv | status: 200, body: "Here is Bear #{id}"}
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{} = conv) do
    %{conv | status: 404, body: "Page was found"}
  end

  @doc """
  Uses the map to create a response.
  """
  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.body)}

    #{conv.body}
    """
  end

  def triple(nums) do
    triple(nums, [])
  end

  defp triple([head | tail], current_list) do
    triple(tail, [head * 3 | current_list])
  end

  defp triple([], current_list), do: Enum.reverse(current_list)
end

# def route(%{method: "GET", path: "/about"} = conv) do
#   file =
#     Path.expand("../../pages", __DIR__)
#     |> Path.join("about.html")

#   # Note we can also split this out into functions that uses pattern matching.
#   case File.read(file) do
#     {:ok, content} -> %{conv | status: 200, body: content}
#     {:error, :enoent} -> %{conv | status: 500, body: "File not found"}
#     {:error, reason} -> %{conv | status: 500, body: "File error: #{reason}"}
#   end
# end

# Just some random tests.

# request = """
# GET /wildthings HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Server.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /bears HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Server.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /bigfoot HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Server.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /bears/1 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Server.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /bears/new HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Server.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Server.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /about HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Server.Handler.handle(request)
# IO.puts(response)

# Post request example

request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

response = Server.Handler.handle(request)
IO.puts(response)
