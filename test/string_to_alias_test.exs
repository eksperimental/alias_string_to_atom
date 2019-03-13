defmodule Module.AliasStringToAtomTest do
  use ExUnit.Case
  import Module.AliasStringToAtom
  doctest Module.AliasStringToAtom

  describe "alias_string_to_atom" do
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
end
