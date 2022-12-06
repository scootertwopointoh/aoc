defmodule AOC.Two do
  def prompt(n), do: do_prompt(n, "lib/inputs/two")
  def test_prompt(n), do: do_prompt(n, "lib/inputs/two_test")

  defp do_prompt(1, file) do
    prepare_data(file)
    |> Enum.map(&score_round/1)
    |> Enum.sum()
  end

  defp do_prompt(2, file) do
    prepare_data(file)
    |> Enum.map(&score_ideal_round/1)
    |> Enum.sum()
  end

  defp prepare_data(file) do
    {:ok, input} = File.read(file)

    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
  end

  # Scissors
  defp get_ideal_play_value("A", 0), do: 3
  # Rock
  defp get_ideal_play_value("A", 3), do: 1
  # Paper
  defp get_ideal_play_value("A", 6), do: 2

  # Rock
  defp get_ideal_play_value("B", 0), do: 1
  # Paper
  defp get_ideal_play_value("B", 3), do: 2
  # Scissors
  defp get_ideal_play_value("B", 6), do: 3

  # Paper
  defp get_ideal_play_value("C", 0), do: 2
  # Scissors
  defp get_ideal_play_value("C", 3), do: 3
  # Rock
  defp get_ideal_play_value("C", 6), do: 1

  defp get_ideal_score("X"), do: 0
  defp get_ideal_score("Y"), do: 3
  defp get_ideal_score("Z"), do: 6

  # Rock
  defp get_play_value("X"), do: 1
  # Paper
  defp get_play_value("Y"), do: 2
  # Scissors
  defp get_play_value("Z"), do: 3

  # Opponent Plays Rock
  # You play Rock {Rock, Rock} - TIE
  defp get_score("A", "X"), do: 3
  # You play Paper {Rock, Paper} - WIN
  defp get_score("A", "Y"), do: 6
  # You play Scissors {Rock, Scissors} - LOSE
  defp get_score("A", "Z"), do: 0

  # Opponent Plays Paper
  # You play Rock {Paper, Rock} - LOSE
  defp get_score("B", "X"), do: 0
  # You play Paper {Paper, Paper} - TIE
  defp get_score("B", "Y"), do: 3
  # You play Scissors {Paper, Scissors} - WIN
  defp get_score("B", "Z"), do: 6

  # Opponent Plays Scissors
  # You play Rock {Scissors, Rock} - WIN
  defp get_score("C", "X"), do: 6
  # You play Rock {Scissors, Paper} - LOSE
  defp get_score("C", "Y"), do: 0
  # You play Rock {Scissors, Scissors} - TIE
  defp get_score("C", "Z"), do: 3

  defp score_ideal_round([opponent_play, desired_result]) do
    ideal_score = get_ideal_score(desired_result)

    get_ideal_play_value(opponent_play, ideal_score) + ideal_score
  end

  defp score_round([left, right]) do
    get_score(left, right) + get_play_value(right)
  end
end
