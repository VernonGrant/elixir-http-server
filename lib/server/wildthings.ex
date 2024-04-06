defmodule Server.Wildthings do
  alias Server.Bear

  def list_bears do
    [
      %Bear{id: 1, name: "Teddy", type: "Brown", hibernating: true},
      %Bear{id: 1, name: "Smokey", type: "Black"},
      %Bear{id: 1, name: "Scarface", type: "Brown", hibernating: true},
      %Bear{id: 1, name: "Snow", type: "Grizzly"},
      %Bear{id: 1, name: "Rosie", type: "Brown"},
      %Bear{id: 1, name: "Lucy", type: "Brown"}
    ]
  end
end
