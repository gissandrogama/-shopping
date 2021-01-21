defmodule Handle do

  def calculate([], []), do: []

  @spec calculate(list(), list()) :: [map()]
  def calculate(itens, emails) do
    amount = itens |> Enum.map(fn item -> item.amount * item.price end) |> Enum.sum()
    people = emails |> Enum.count()
  end
end
