defmodule AOC.Four do
  def prompt(n), do: do_prompt(n, "lib/inputs/four")
  def test_prompt(n), do: do_prompt(n, "lib/inputs/four_test")

  defp do_prompt(1, file) do
    prepare_data(file)
    |> Enum.map(&fully_contained/1)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count()
  end

  defp do_prompt(2, file) do
    prepare_data(file)
    |> Enum.map(&overlap/1)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count()
  end

  defp build_range(entry) do
    entry
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> range_to_list()
  end

  defp build_ranges(entries) do
    entries
    |> Enum.map(&build_range/1)
  end

  defp fully_contained([left, right]) do
    left_set = MapSet.new(left)
    right_set = MapSet.new(right)

    MapSet.subset?(left_set, right_set) || MapSet.subset?(right_set, left_set)
  end

  def overlap([left, right]) do
    count =
      MapSet.new(left)
      |> MapSet.intersection(MapSet.new(right))
      |> MapSet.to_list()
      |> Enum.count()

    count > 0
  end

  defp prepare_data(file) do
    {:ok, input} = File.read(file)

    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&split_assignments/1)
    |> Enum.map(&build_ranges/1)
  end

  defp range_to_list([start, finish]), do: Enum.to_list(start..finish)

  defp split_assignments(s), do: String.split(s, ",")
end
