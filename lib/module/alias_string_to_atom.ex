defmodule Module.AliasStringToAtom do
  @doc """
  Converts from an alias string to an atom.

  If the alias string is a valid string representation of an
  alias, the atom returned in an alias.

  ## Examples

      iex> Module.AliasStringToAtom.alias_string_to_atom("Foo")
      Foo

      iex> Module.AliasStringToAtom.alias_string_to_atom("Foo.invalid_alias")
      :"Foo.invalid_alias"

  """
  @spec alias_string_to_atom(String.t()) :: module | atom
  def alias_string_to_atom(string) when is_binary(string) do
    if validate_alias_string(string, true) do
      valid_alias_string_to_atom(string)
    else
      String.to_atom(string)
    end
  end

  defp valid_alias_string_to_atom("Elixir." <> _ = string),
    do: String.to_atom(string)

  defp valid_alias_string_to_atom("Elixir"),
    do: :"Elixir"

  defp valid_alias_string_to_atom(string),
    do: String.to_atom("Elixir." <> string)

  @spec validate_alias_string(String.t()) :: boolean
  def validate_alias_string(alias_string) do
    validate_alias_string(alias_string, true)
  end

  defp validate_alias_string(<<first_char, rest::binary>>, _first_char? = true)
       when first_char >= ?A and first_char <= ?Z do
    validate_alias_string(rest, false)
  end

  defp validate_alias_string(_, true) do
    false
  end

  defp validate_alias_string("", false) do
    true
  end

  defp validate_alias_string(".", false) do
    false
  end

  defp validate_alias_string(<<".", rest::binary>>, false) do
    validate_alias_string(rest, true)
  end

  defp validate_alias_string(<<char, rest::binary>>, false)
       when (char >= ?A and char <= ?Z) or (char >= ?a and char <= ?z) or
              (char >= ?0 and char <= ?9) or char == ?_ do
    validate_alias_string(rest, false)
  end

  defp validate_alias_string(_, false) do
    false
  end
end
