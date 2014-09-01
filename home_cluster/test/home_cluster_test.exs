defmodule HomeClusterTest do
  use ExUnit.Case
  alias HomeCluster.Master
  alias HomeCluster.Client

  setup do
    Master.start_link
    :ok
  end

  test "Master can be started" do
    assert Master.get_available_clients == []
  end

  test "Nodes may be added to the system" do
    client = %Client{pid: self, name: :living_room, capabilities: [:audio]}
    assert :ok = Master.register_client(client)
    assert [%Client{pid: self}] = Master.get_available_clients
  end
end
