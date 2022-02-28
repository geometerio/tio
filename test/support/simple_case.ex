defmodule Tio.SimpleCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      import Tio.Assertions
    end
  end
end
