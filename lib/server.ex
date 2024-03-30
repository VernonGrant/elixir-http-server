defmodule Server do
  @moduledoc """
  Documentation for `Server`.
  """

  @doc """
  Hello world.

  ## Examples
      iex> Server.hello()
      :world
  """
  def hello(name) do
    "Hello,  #{name}"
  end
end

IO.puts(Server.hello("Jhon"))
