defmodule Module.AliasStringToAtom do
  @doc """
  Converts from an alias string to an atom.

  If the valid alias string is the valid string representation of an
  alias, the atom returned in an alias.

  ## Examples

      iex> Module.AliasStringToAtom.alias_string_to_atom("Foo")
      Foo

      iex> Module.AliasStringToAtom.alias_string_to_atom("Foo.invalid_alias")
      :"Foo.invalid_alias"

  """
  def alias_string_to_atom(string) when is_binary(string) do
    if validate_alias_string(string, true) do
      valid_alias_string_to_atom(string)
    else
      String.to_atom(string)
    end
  end

  defp valid_alias_string_to_atom("Elixir" = string),
    do: String.to_atom(string)

  defp valid_alias_string_to_atom("Elixir." <> _ = string),
    do: String.to_atom(string)

  defp valid_alias_string_to_atom(string),
    do: String.to_atom("Elixir." <> string)

  def valid_alias_string_to_atom("", true) do
    false
  end

  def validate_alias_string(<<first_char, rest::binary>>, true = _first_char?)
      when first_char >= ?A and first_char <= ?Z do
    validate_alias_string(rest, false)
  end

  def validate_alias_string(_, true) do
    false
  end

  def validate_alias_string("", false) do
    true
  end

  def validate_alias_string(".", false) do
    false
  end

  def validate_alias_string(<<".", rest::binary>>, false) do
    validate_alias_string(rest, true)
  end

  def validate_alias_string(<<char, rest::binary>>, false)
      when (char >= ?A and char <= ?Z) or (char >= ?a and char <= ?z) or
             (char >= ?0 and char <= ?9) or char == ?_ do
    validate_alias_string(rest, false)
  end

  def validate_alias_string(_, false) do
    false
  end
end
