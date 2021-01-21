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
        value = cloven / 100

        Enum.map(emails, fn email -> %{email: email, value: value} end)

      _ ->
        value = process(cloven)

        list = Enum.map(emails, fn email -> %{email: email, value: value} end)

        key = Enum.count(list) - 1

        list
        |> List.update_at(key, fn pessoas ->
          %{email: pessoas.email, value: pessoas.value + 0.01}
        end)
    end
  end

  @spec process(float) :: float()
  def process(cloven) when is_float(cloven) do
    cloven = cloven / 100

    cloven
    |> Float.floor(2)
  end
end
