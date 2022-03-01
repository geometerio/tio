defmodule Tio.Format do
  @moduledoc "Formatting functions used by the functions in the Tio module."

  @message_types %{
    action: :cyan,
    error: :red,
    info: :white,
    quoted: :yellow,
    step: [:bright, :cyan]
  }

  @type message_type() :: :action | :error | :info | :quoted | :step

  @spec format(message_type :: message_type(), iodata :: iodata()) :: iodata()
  @doc "Formats `iodata` as a `message_type`"
  def format(message_type, iodata) do
    IO.ANSI.format([
      message_type_to_color(message_type),
      replace_quoted(message_type, List.wrap(iodata))
    ])
  end

  @spec puts(message_type :: message_type(), iodata :: iodata()) :: :ok
  @doc "Formats `iodata` as a `message_type` via `format/2` and prints it to stdout"
  def puts(message_type, iodata) do
    if Euclid.Term.present?(iodata) do
      format(message_type, iodata) |> IO.puts()
    end
  end

  # # #

  @spec replace_quoted(container_message_type :: message_type(), iodata :: iodata()) :: iodata()
  defp replace_quoted(container_message_type, iodata) do
    Enum.map(iodata, fn
      {:quoted, quoted} ->
        [message_type_to_color(:quoted), quoted, message_type_to_color(container_message_type)]

      tuple when is_tuple(tuple) ->
        raise "Unexpected tuple; only {:quoted, _} tuples are allowed: #{inspect(tuple)}"

      list when is_list(list) ->
        replace_quoted(container_message_type, list)

      other ->
        other
    end)
  end

  @spec message_type_to_color(message_type :: message_type()) :: atom()
  defp message_type_to_color(message_type) do
    Map.get(@message_types, message_type) || raise "Unknown type: #{message_type}"
  end
end
