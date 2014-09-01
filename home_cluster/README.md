HomeCluster
===========

For each node in this cluster, a GenServer will be run and handle all the
configuration for audio.  That GenServer will support operations to manage its
audio configuration state.

There will also be a central GenServer that manages a list of nodes that are
running audio genservers.

## Master Server

This will register itself with the atom `:master`.  It supports the following
operations:

### Calls

- `:get_available_clients`
  - Returns a list of available clients  This might look like the following:
    - `[{pid: <some pid>, name: :living_room, capabilities: [:audio]}]
- `{:register_client, self(), :living_room, [:audio]}`
  - Adds a client to the network.  Possible respomses:
    - :ok
    - {:error, "This name already exists"}
