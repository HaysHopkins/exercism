defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun), do: _keep(list, fun, [])
  defp _keep([], fun, acc), do: Enum.reverse acc
  defp _keep([h|t], fun, acc) do
    cond do
      fun.(h) -> _keep(t, fun, [h|acc])
      true -> _keep(t, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun), do: _discard(list, fun, [])
  defp _discard([], fun, acc), do: Enum.reverse acc
  defp _discard([h|t], fun, acc) do
    cond do
      fun.(h) -> _discard(t, fun, acc)
      true -> _discard(t, fun, [h|acc])
    end
  end
end
