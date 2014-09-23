defmodule HomeCluster.Master do
  use GenServer
  alias HomeCluster.Client
  @mountpoint "audio.ogg"
  @port "8000"

  defmodule State do
    defstruct clients: [], net_basic: nil
  end

  # client functions
  def start_link do
    {:ok, pid} = NetBasic.start_link
    GenServer.start_link(__MODULE__, %State{net_basic: pid}, name: :master)
  end

  def get_available_clients do
    GenServer.call(:master, :get_available_clients)
  end

  def register_client(client = %Client{}) do
    GenServer.call(:master, {:register_client, client})
  end

  def get_ip do
    GenServer.call(:master, :get_ip)
  end

  def get_icecast_url do
    GenServer.call(:master, :get_icecast_url)
  end

  # server functions
  def handle_call(:get_available_clients, from, state) do
    {:reply, state.clients, state}
  end

  def handle_call({:register_client, client=%Client{}}, from, state) do
    new_clients = [client|state.clients]
    {:reply, :ok, %State{state|clients: new_clients}}
  end

  def handle_call(:get_ip, _from, state) do
    ip = get_ip(state.net_basic)
    {:reply, ip, state}
  end

  def handle_call(:get_icecast_url, _from, state) do
    ip = get_ip(state.net_basic)
    {:reply, "http://#{ip}:#{@port}/#{@mountpoint}", state}
  end

  def get_ip(net_basic_pid) do
    %{ipv4_address: ip} = NetBasic.get_config(net_basic_pid, "wlan0")
    ip
  end
end
