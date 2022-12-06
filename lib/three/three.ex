defmodule AOC.Three do
  @priorities ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z
                 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

  def prompt(n), do: do_prompt(n, "lib/inputs/three")
  def test_prompt(n), do: do_prompt(n, "lib/inputs/three_test")

  defp do_prompt(1, file) do
    prepare_data(file)
    |> Enum.map(&split_contents/1)
    |> Enum.map(&intersection/1)
    |> Enum.map(fn x ->
      hd(x)
      |> set_priority()
    end)
    |> Enum.sum()
  end

  defp do_prompt(2, file) do
    prepare_data(file)
    |> Enum.chunk_every(3)
    |> Enum.map(&intersection/1)
    |> Enum.map(fn x ->
      hd(x)
      |> set_priority()
    end)
    |> Enum.sum()
  end

  defp half(v), do: (v / 2) |> round()

  defp intersection([one, two, three]) do
    first = intersection([one, two])
    second = intersection([two, three])

    intersection([first, second])
  end

  defp intersection([left, right]) do
    MapSet.new(left)
    |> MapSet.intersection(MapSet.new(right))
    |> MapSet.to_list()
  end

  defp prepare_data(file) do
    {:ok, input} = File.read(file)

    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
  end

  defp set_priority(item) do
    index =
      @priorities
      |> Enum.find_index(fn p ->
        p == item
      end)

    index + 1
  end

  defp split_contents(contents) do
    size =
      contents
      |> Enum.count()
      |> half()

    contents
    |> Enum.chunk_every(size)
  end
end
