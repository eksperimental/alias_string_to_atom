defmodule Module.AliasStringToAtomTest do
  use ExUnit.Case
  import Module.AliasStringToAtom
  doctest Module.AliasStringToAtom

  describe "alias_string_to_atom/1" do
    test "valid ones" do
      assert alias_string_to_atom("Foo") == Foo
      assert alias_string_to_atom("Foo.Bar") == Foo.Bar
    end

    test "starting with Elixir" do
      assert alias_string_to_atom("Elixir") == Elixir
      assert alias_string_to_atom("Elixir.Foo") == Foo
      assert alias_string_to_atom("Elixir.Foo.Bar") == Foo.Bar
    end

    test "invalid ones " do
      assert alias_string_to_atom("Elixir.") == :"Elixir."
      assert alias_string_to_atom("Elixir.Foo.") == :"Elixir.Foo."
      assert alias_string_to_atom("Elixir.Foo.Bar.") == :"Elixir.Foo.Bar."
      assert alias_string_to_atom("Elixir.Foo.bar.") == :"Elixir.Foo.bar."
    end

    test "erlang modules " do
      assert alias_string_to_atom("lists") == :lists
      assert alias_string_to_atom(":lists") == :":lists"
      assert alias_string_to_atom("") == :""
      assert alias_string_to_atom("nil") == nil
      assert alias_string_to_atom("Nil") == Nil
    end
  end

  test "validate_alias_string/1" do
    valid = ~W"
      Elixir Module ModuleName ModuleISO ISO Module_Name Module_name Foo123 A
    "

    invalid = ~W"
       module
       Module-name
       Module?
       Module!
       123Module
    "

    for string <- valid do
      assert validate_alias_string(string)
    end

    refute validate_alias_string("")

    for string <- invalid do
      refute validate_alias_string(string)
    end
  end
end
