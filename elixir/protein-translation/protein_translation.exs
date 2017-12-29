defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    {segment, strand} = String.split_at(rna, 3)
    {status, codon} = of_codon(segment)
    _of_rna(status, codon, strand, []) |> _format_result
  end

  defp _of_rna( status, _codon, _strand, _acc) when status == :error,   do: "invalid RNA"
  defp _of_rna(_status,  codon,  strand,  acc) when codon == "STOP",    do: Enum.reverse acc
  defp _of_rna(_status,  codon,  strand,  acc) when strand == "",       do: Enum.reverse [codon|acc]
  defp _of_rna(_status,  codon,  strand, _acc) when length(strand) < 3, do: "invalid RNA"
  defp _of_rna(_status,  codon,  strand,  acc) do
    {segment, next_strand} = String.split_at(strand, 3)
    {next_status, next_codon} = of_codon(segment)
    _of_rna(next_status, next_codon, next_strand, [codon|acc])
  end

  defp _format_result(result) when result == "invalid RNA", do: {:error, result}
  defp _format_result(result),                              do: {:ok, result}

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    protein = @proteins[codon]
    case protein do
      nil -> {:error, "invalid codon"}
      _   -> {:ok, protein}
    end
  end
end

