defmodule Tio.FormatTest do
  @moduledoc false
  use Tio.SimpleCase
  alias Tio.Format

  describe "format" do
    test "accepts strings" do
      assert_format(Format.format(:action, "Starting"), "CYANStartingRESET")
    end

    test "accepts lists" do
      assert_format(
        Format.format(:action, ["Starting", " ", "something"]),
        "CYANStarting somethingRESET"
      )
    end

    test "accepts iolists" do
      assert_format(
        Format.format(:action, ["Starting", [" ", ["something"], " "], "great"]),
        "CYANStarting something greatRESET"
      )
    end

    test "sets color based on the type" do
      assert_format(Format.format(:action, ["Hello", " ", "friend"]), "CYANHello friendRESET")
      assert_format(Format.format(:error, ["Hello", " ", "friend"]), "REDHello friendRESET")
      assert_format(Format.format(:info, ["Hello", " ", "friend"]), "WHITEHello friendRESET")
      assert_format(Format.format(:quoted, ["Hello", " ", "friend"]), "YELLOWHello friendRESET")
      assert_format(Format.format(:step, ["Hello", " ", "friend"]), "BRIGHTCYANHello friendRESET")
    end

    test "a quoted tuple in the top level of the message gets quoted" do
      assert_format(
        Format.format(:error, ["Config file ", {:quoted, "config.txt"}, " not found"]),
        "REDConfig file YELLOWconfig.txtRED not foundRESET"
      )
    end

    test "a quoted tuple deeper in the message gets quoted" do
      assert_format(
        Format.format(:action, ["•", " ", ["Creating file ", {:quoted, "config.txt"}, " now"]]),
        "CYAN• Creating file YELLOWconfig.txtCYAN nowRESET"
      )
    end
  end

  describe "puts" do
    test "writes the formatted message to stdout" do
      assert_captured(fn -> Format.puts(:action, "Hello") end, "CYANHelloRESET\n")
    end

    test "does nothing when message is blank or nil" do
      assert_captured(fn -> Format.puts(:action, nil) end, "")
      assert_captured(fn -> Format.puts(:action, "  ") end, "")
    end
  end
end
