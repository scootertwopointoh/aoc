defmodule AOC.One do
  def prompt(n), do: do_prompt(n, "lib/inputs/one")
  def test_prompt(n), do: do_prompt(n, "lib/inputs/one_test")

  defp do_prompt(1, file) do
    prepare_data(file)
    |> get_max()
  end

  defp do_prompt(2, file) do
    prepare_data(file)
    |> take_top(3)
    |> Enum.sum()
  end

  defp get_max(data) do
    sum_data(data)
    |> Enum.max()
  end

  defp prepare_data(file) do
    {:ok, input} = File.read(file)

    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&process_data_block/1)
  end

  defp process_data_block(data_block) do
    data_block
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  defp sum_data(data), do: Enum.map(data, &sum_data_block/1)

  defp sum_data_block(data_block), do: Enum.sum(data_block)

  defp take_top(data, n) do
    sum_data(data)
    |> Enum.sort(:desc)
    |> Enum.take(n)
  end
end
