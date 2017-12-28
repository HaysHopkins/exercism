defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    {segment, strand} = String.split_at(rna, 3)
    {status, codon} = of_codon(segment)
    _format_result(_of_rna(status, codon, strand, []))
  end

  defp _of_rna(status, _codon, _strand, _acc) when status == :error,   do: "invalid RNA"
  defp _of_rna(_status, codon, strand, acc)   when codon == "STOP",    do: Enum.reverse acc
  defp _of_rna(_status, codon, strand, acc)   when strand == "",       do: Enum.reverse [codon|acc]
  defp _of_rna(_status, codon, strand, _acc)  when length(strand) < 3, do: "invalid RNA"
  defp _of_rna(_status, codon, strand, acc) do
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
  def of_codon(codon) when codon in ["UGU", "UGC", "UUA", "UUG", "AUG", "UUU", "UUC", "UCU", "UCC", "UCA", "UCG", "UGG", "UAU", "UAC", "UAA", "UAG", "UGA"], do: {:ok, _of_codon(codon)}
  def of_codon(_codon),                                              do: {:error, "invalid codon"}
  defp _of_codon(codon) when codon in ["UGU", "UGC"],               do: "Cysteine"
  defp _of_codon(codon) when codon in ["UUA", "UUG"],               do: "Leucine"
  defp _of_codon(codon) when codon in ["AUG"],                      do: "Methionine"
  defp _of_codon(codon) when codon in ["UUU", "UUC"],               do: "Phenylalanine"
  defp _of_codon(codon) when codon in ["UCU", "UCC", "UCA", "UCG"], do: "Serine"
  defp _of_codon(codon) when codon in ["UGG"],                      do: "Tryptophan"
  defp _of_codon(codon) when codon in ["UAU", "UAC"],               do: "Tyrosine"
  defp _of_codon(codon) when codon in ["UAA", "UAG", "UGA"],        do: "STOP"
end

