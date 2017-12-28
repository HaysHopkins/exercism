defmodule RotationalCipher do
  import Enum, only: [map: 2]

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> map(fn(el) -> encode(el, shift) end)
    |> map(fn(el) -> correct(el, shift) end)
    |> to_string
  end

  defp encode(el, shift) when el >= ?a and el <= ?z do
    el + shift
  end

  defp encode(el, shift) when el >= ?A and el <= ?Z do
    el + shift
  end

  defp encode(el, shift) do
    el
  end

  defp correct(el, shift) when el > ?z and ?z + shift >= el do
    el - 26
  end

  defp correct(el, shift) when el > ?Z and ?Z + shift >= el do
    el - 26
  end

  defp correct(el, shift) do
    el
  end
end

