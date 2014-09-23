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

  test "Master knows its IP address" do
    expected_ip = "192.168.0.7"
    assert Master.get_ip == expected_ip
  end

  test "Master knows its icecast url" do
    expected_url = "http://192.168.0.7:8000/audio.ogg"
    assert Master.get_icecast_url == expected_url
  end
end
