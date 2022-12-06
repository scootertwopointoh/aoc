defmodule AOC.Six do
  @message_window_size 14
  @packet_window_size 4

  def prompt(n), do: do_prompt(n, "lib/inputs/six")
  def test_prompt(n), do: do_prompt(n, "lib/inputs/six_test")

  defp do_prompt(1, file) do
    prepare_data(file)
    |> Enum.map(fn data ->
      scan_for_marker(data, @packet_window_size)
    end)
  end

  defp do_prompt(2, file) do
    prepare_data(file)
    |> Enum.map(fn data ->
      scan_for_marker(data, @message_window_size)
    end)
  end

  defp scan_for_marker(data, window_size) do
    window =
      data
      |> String.codepoints()
      |> Enum.chunk_every(window_size, 1)
      |> Enum.find_index(fn x -> Enum.uniq(x) |> Enum.count() == window_size end)

    window + window_size
  end

  defp prepare_data("lib/inputs/six_test" = file) do
    {:ok, input} = File.read(file)

    input
    |> String.trim()
    |> String.split("\n")
  end

  defp prepare_data(file) do
    {:ok, input} = File.read(file)

    [String.trim(input)]
  end
end
