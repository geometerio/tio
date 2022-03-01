defmodule Tio do
  @moduledoc """
  A few helpful functions for terminal I/O. Read more in the [readme](https://hexdocs.pm/tio/readme.html).

  * `step` should be used to show a group of actions is about to start
  * `action` should be used to show an action is starting
  * `info` should be used to show any important information from an action
  * `done` should be used to show a group of steps is done

  Steps and actions can take blocks:

  ```
  Tio.step "Rethreading flux capacitor" do
    Tio.action "Initializing agitator" do
      Tio.info("3... 2... 1...")
    end

    Tio.action "Regulating coherence" do
      Tio.info("0.5... 0.75... 1.0")
    end
  end
  Tio.done()
  ```

  Messages can be iodata (strings, lists, or improper lists) and are ultimately
  formatted with `IO.ANSI.format/2`. One addition is that if a message is a list,
  then a `{:quoted, message}` tuple will be formatted in the quote color:

  ```
  Tio.info(["File ", {:quoted, "foo.txt"}, " has ", {:quoted, "20"}, " lines"])
  ```
  """

  alias Tio.Format

  @spec action(message :: iodata()) :: :ok
  @doc "Prints `message` describing an action that's about to start"
  def action(message) do
    Format.puts(:action, ["•", " ", message])
  end

  defmacro action(message, do: block) do
    quote do
      Tio.action(unquote(message))
      unquote(block)
    end
  end

  @spec done :: :ok
  @doc "Prints a message indicating that all steps and actions are done"
  def done do
    Format.puts(:step, ["✔︎", " ", "Done"])
  end

  @spec info(message :: iodata()) :: :ok
  @doc "Prints informational message `message`"
  def info(message) do
    Format.puts(:info, message)
  end

  @spec step(message :: iodata()) :: :ok
  @doc "Prints `message` describing a step that's about to start"
  def step(message) do
    Format.puts(:step, ["▸", " ", message])
  end

  defmacro step(message, do: block) do
    quote do
      Tio.step(unquote(message))
      unquote(block)
    end
  end
end
