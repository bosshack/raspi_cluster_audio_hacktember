defmodule HomeCluster.Master do
  use GenServer
  alias HomeCluster.Client

  defmodule State do
    defstruct clients: []
  end

  # client functions
  def start_link do
    GenServer.start_link(__MODULE__, %State{}, name: :master)
  end

  def get_available_clients do
    GenServer.call(:master, :get_available_clients)
  end

  def register_client(client = %Client{}) do
    GenServer.call(:master, {:register_client, client})
  end

  # server functions
  def handle_call(:get_available_clients, from, state) do
    {:reply, state.clients, state}
  end

  def handle_call({:register_client, client=%Client{}}, from, state) do
    new_clients = [client|state.clients]
    {:reply, :ok, %State{state|clients: new_clients}}
  end
end
