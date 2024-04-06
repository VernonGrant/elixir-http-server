defmodule Server.BearController do
  alias Server.Conv
  alias Server.Wildthings

  def index(conv) do
    # bears = Wildthings.list_bears()

    # TODO: transform into an HTML list.

    %Conv{conv | status: 200, body: "Poo, Winni"}
  end

  def show(conv, %{"id" => id}) do
    %Conv{conv | status: 200, body: "Here is Bear #{id}"}
  end

  def create(conv, %{"type" => type, "name" => name}) do
    %Conv{
      conv
      | status: 200,
        body: "Bear of type #{type} with the name #{name} has been created!"
    }
  end
end
