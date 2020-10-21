defmodule Surfer.Server do

  defmodule State do
    defstruct [count: 0]
  end

  use GenServer
  require Logger

  def start_link(_) do
    start(SilverSurfer)
  end

  def init(_args) do
    state = %State{}
    {:ok, state}
  end

  def handle_cast(:inc, state = %State{count: count}) do
    {:noreply, %{state | count: count + 1}}
  end

  def handle_call(:get, _from, state) do
    {:reply, state.count, state}
  end

  def handle_info(:hello, state) do
    log(:hello, state.count)
    {:noreply, state}
  end

  # --- public API

  def start(name) do
    result = GenServer.start_link(__MODULE__, [], name: name)
    log(result, :start, name)
    result
  end

  def log({:ok, pid}, :start, name) do
    Logger.debug("starting up Surfer.Server, '#{name}', #{inspect(pid)}")
  end

  def log(:hello, count) do
    Logger.debug("received hello. count is #{count}")
  end

  def log(_) do
    :noop
  end

  def inc(pid) do
    GenServer.cast(pid, :inc)
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

end
