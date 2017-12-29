defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels ["a", "e", "i", "o", "u", "yt", "xr"]
  @consonant_groups ["thr", "th", "str", "squ", "sch", "pl", "qu", "ch"]
  @matching_prefixes @vowels ++ @consonant_groups

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map(&pig_latinize/1)
    |> Enum.join(" ")
  end

  defp pig_latinize(word) do
    find_prefix(word)
    |> remove_prefix(word)
    |> add_suffix
  end

  defp find_prefix(word) do
    Enum.find(@matching_prefixes, split(word), fn(match) -> String.starts_with?(word, match) end)
  end
  defp split(word), do: word |> String.split(~r/[aieou]/) |> Enum.at(0)

  defp remove_prefix(prefix, word) when prefix in @vowels, do: {"", word}
  defp remove_prefix(prefix, word), do: String.split_at(word, String.length(prefix))

  defp add_suffix({prefix, word}), do: word <> prefix <> "ay"
end

