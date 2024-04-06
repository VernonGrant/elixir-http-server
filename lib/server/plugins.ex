defmodule Server.Plugins do
  alias Server.Conv

  require Logger

  def log(conv), do: IO.inspect(conv)

  def track(%Conv{status: 404, path: path} = conv) do
    Logger.info("The #{path} went wild!!")
    conv
  end

  def track(%Conv{} = conv), do: conv

  def rewrite_path(%Conv{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%Conv{} = conv), do: conv
end
