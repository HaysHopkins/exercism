defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
  end

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
  def of_codon(codon), do: _of_codon(codon)
  defp _of_codon(codon) when codon in ["UGU", "UGC"], do: {:ok, "Cysteine"}
  defp _of_codon(codon) when codon in ["UUA", "UUG"], do: {:ok, "Leucine"}
  defp _of_codon(codon) when codon in ["AUG"], do: {:ok, "Methionine"}
  defp _of_codon(codon) when codon in ["UUU", "UUC"], do: {:ok, "Phenylalanine"}
  defp _of_codon(codon) when codon in ["UCU", "UCC", "UCA", "UCG"], do: {:ok, "Serine"}
  defp _of_codon(codon) when codon in ["UGG"], do: {:ok, "Tryptophan"}
  defp _of_codon(codon) when codon in ["UAU", "UAC"], do: {:ok, "Tyrosine"}
  defp _of_codon(codon) when codon in ["UAA", "UAG", "UGA"], do: {:ok, "STOP"}
  defp _of_codon(codon), do: {:error, "invalid codon"}
end

