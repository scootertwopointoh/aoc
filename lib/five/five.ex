defmodule AOC.Five do
  def prompt(n), do: do_prompt(n, "lib/inputs/five")
  def test_prompt(n), do: do_prompt(n, "lib/inputs/five_test")

  defp do_prompt(1, file) do
    {stacks, moves} = prepare_data(file)

    moves
    |> Enum.reduce(stacks, fn move, acc ->
      make_move(acc, move)
    end)
    |> Enum.map(&hd/1)
    |> Enum.join("")
  end

  defp do_prompt(2, file) do
    {stacks, moves} = prepare_data(file)

    moves
    |> Enum.reduce(stacks, fn move, acc ->
      make_move_9K1(acc, move)
    end)
    |> Enum.map(&hd/1)
    |> Enum.join("")
  end

  defp make_move(stacks, {take, [from, to]}) do
    to_move =
      Enum.fetch!(stacks, from)
      |> Enum.take(take)
      |> Enum.reverse()

    to_replace = Enum.drop(Enum.fetch!(stacks, from), take)

    stacks
    |> List.replace_at(from, to_replace)
    |> List.replace_at(to, to_move ++ Enum.fetch!(stacks, to))
  end

  defp make_move_9K1(stacks, {take, [from, to]}) do
    to_move =
      Enum.fetch!(stacks, from)
      |> Enum.take(take)

    to_replace = Enum.drop(Enum.fetch!(stacks, from), take)

    stacks
    |> List.replace_at(from, to_replace)
    |> List.replace_at(to, to_move ++ Enum.fetch!(stacks, to))
  end

  defp prepare_data(file) do
    {:ok, input} = File.read(file)

    [stacks | moves] = String.split(input, "\n\n")

    {process_stacks(stacks), process_moves(moves)}
  end

  defp process_boxes(boxes) do
    boxes
    |> Enum.map(fn row ->
      row
      |> String.replace("    [", "[*] [")
      |> String.replace("    ", " [*]")
      |> String.replace("[", "")
      |> String.replace("]", "")
      |> String.split(" ")
    end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.filter(&1, fn x -> x != "*" end))
    |> Enum.map(&Enum.reverse/1)
  end

  # defp process_columns(columns) do
  #   columns
  #   |> String.trim()
  #   |> String.split("   ")
  # end

  defp position_to_index(position), do: position - 1

  defp process_move(move) do
    [count | indices] =
      move
      |> String.replace("move ", "")
      |> String.replace("from ", "")
      |> String.replace("to ", "")
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    {count, Enum.map(indices, &position_to_index/1)}
  end

  defp process_moves(moves) do
    hd(moves)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&process_move/1)
  end

  defp process_stacks(stacks) do
    [_columns | boxes] =
      stacks
      |> String.split("\n")
      |> Enum.reverse()

    # {process_columns(columns), process_boxes(boxes)}
    process_boxes(boxes)
  end
end
