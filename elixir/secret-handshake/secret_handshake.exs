defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Integer.digits(code, 2)
    |> Enum.reverse
    |> issue_commands
  end

  def issue_commands(list), do: _issue_commands(list, [], 0)
  defp _issue_commands([], acc, _pos),    do: acc
  defp _issue_commands([1|t], acc, 0),    do: _issue_commands(t, acc++["wink"], 1)
  defp _issue_commands([1|t], acc, 1),    do: _issue_commands(t, acc++["double blink"], 2)
  defp _issue_commands([1|t], acc, 2),    do: _issue_commands(t, acc++["close your eyes"], 3)
  defp _issue_commands([1|t], acc, 3),    do: _issue_commands(t, acc++["jump"], 4)
  defp _issue_commands([1|t], acc, 4),    do: _issue_commands(t, Enum.reverse(acc), 5)
  defp _issue_commands([_h|t], acc, pos), do: _issue_commands(t, acc, pos+1)

  def byte_code(str) when is_binary(str) do
    :erlang.list_to_binary(str)
    # str <> <<0>>
  end
end

