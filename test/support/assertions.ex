defmodule Tio.Assertions do
  @moduledoc false

  import ExUnit.CaptureIO
  import ExUnit.Assertions

  def assert_format(formatted, expected) do
    assert formatted |> to_string() |> replace_colors() == expected
  end

  def assert_captured(fun, expected) do
    assert fun |> capture_io() |> replace_colors() == expected
  end

  defp replace_colors(s) do
    String.replace(s, ~r|\e\[\d+m|, fn
      "\e[0m" -> "RESET"
      "\e[1m" -> "BRIGHT"
      "\e[31m" -> "RED"
      "\e[33m" -> "YELLOW"
      "\e[36m" -> "CYAN"
      "\e[37m" -> "WHITE"
    end)
  end
end
