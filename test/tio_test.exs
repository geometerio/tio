defmodule TioTest do
  @moduledoc false
  use Tio.SimpleCase
  require Tio

  describe "action" do
    test "outputs an icon and a message" do
      fn -> Tio.action("Initializing agitator") end
      |> assert_captured("CYAN• Initializing agitatorRESET\n")
    end

    test "runs the block" do
      fn ->
        Tio.action "Initializing agitator" do
          IO.puts("3... 2... 1...")
        end
      end
      |> assert_captured("""
      CYAN• Initializing agitatorRESET
      3... 2... 1...
      """)
    end
  end

  describe "done" do
    test "outputs an icon and a message" do
      fn -> Tio.done() end
      |> assert_captured("BRIGHTCYAN✔︎ DoneRESET\n")
    end
  end

  describe "info" do
    test "outputs a message" do
      fn -> Tio.info("Initializing agitator") end
      |> assert_captured("WHITEInitializing agitatorRESET\n")
    end
  end

  describe "step" do
    test "outputs an icon and a message" do
      fn -> Tio.step("Rethreading flux capacitor") end
      |> assert_captured("BRIGHTCYAN▸ Rethreading flux capacitorRESET\n")
    end

    test "runs the block" do
      fn ->
        Tio.step "Rethreading flux capacitor" do
          IO.puts("88 MPH")
        end
      end
      |> assert_captured("""
      BRIGHTCYAN▸ Rethreading flux capacitorRESET
      88 MPH
      """)
    end

    test "can contain actions" do
      fn ->
        Tio.step "Rethreading flux capacitor" do
          Tio.action "Initializing agitator" do
            IO.puts("3... 2... 1...")
          end

          Tio.action "Regulating coherence" do
            IO.puts("0.5... 0.75... 1.0")
          end
        end
      end
      |> assert_captured("""
      BRIGHTCYAN▸ Rethreading flux capacitorRESET
      CYAN• Initializing agitatorRESET
      3... 2... 1...
      CYAN• Regulating coherenceRESET
      0.5... 0.75... 1.0
      """)
    end
  end
end
