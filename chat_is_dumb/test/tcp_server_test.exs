defmodule ChatWrites.TCPServerTest do
  use ExUnit.Case

  alias ChatWrites.TCPServer

  @port 42069

  test "accepts connections and sends messages" do
    {:ok, client} = ChatWrites.TestTCPClient.start(port: @port)
    :erlang.trace(client, true, [:receive])

    :ok = TCPServer.send("foo")

    assert_receive {:trace, ^client, :receive, {:tcp, _port, "foo"}}
  end
end
