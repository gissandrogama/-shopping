defmodule Handle do
  @moduledoc """
  Handle module for list entries such as `items` and `emails`.
  The most used function and the `calculate/2` function.
  """

  def calculate([], []), do: []

  @spec calculate(list(), list()) :: [map()]
  def calculate(itens, emails) do
    amount = itens |> Enum.map(fn item -> item.amount * item.price end) |> Enum.sum()
    people = emails |> Enum.count()

    split(amount, people, emails)
  end

  @spec split(number, number, list()) :: [map()]
  def split(value, quantity, emails) do
    cloven = value / quantity

    case rem(value, quantity) do
      0 ->
        value = cloven

        Enum.map(emails, fn email -> %{email: email, value: value} end) |> print()

      _ ->
        value = process(cloven) |> String.to_integer()

        list = Enum.map(emails, fn email -> %{email: email, value: value} end)

        key = Enum.count(list) - 1

        list
        |> List.update_at(key, fn pessoas ->
          %{email: pessoas.email, value: pessoas.value + 1}
        end)
        |> print()
    end
  end

  @spec process(float) :: String.t
  def process(cloven) when is_float(cloven) do
    cloven = cloven / 100

    cloven
    |> Float.floor(2)
    |> Float.to_string()
    |> String.split(".")
    |> Enum.join()
  end

  def print(list) do
    Enum.map(list, fn list -> %{email: list.email, value: "R$ #{list.value / 100}"} end)
  end
end
