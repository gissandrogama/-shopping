defmodule Handle do

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

    value = process(cloven)

    case value do
      {:float, cloven} ->
        list = Enum.map(emails, fn email -> %{email: email, value: cloven} end)

        key = Enum.count(list) - 1

        list
        |> List.update_at(key, fn pessoas ->
          %{email: pessoas.email, value: pessoas.value + 0.01}
        end)

      {:interge, cloven} ->
        Enum.map(emails, fn email -> %{email: email, value: cloven} end)
    end
  end

  @spec process(float) :: {:float, float} | {:interge, float}
  def process(cloven) when is_float(cloven) do
    digits =
      cloven
      |> Float.to_string()
      |> String.split(".")
      |> List.last()
      |> String.length()

    if digits > 2 do
      cloven = cloven / 100

      cloven =
        cloven
        |> Float.round(2)

      {:float, cloven}
    else
      cloven = cloven / 100

      {:interge, cloven}
    end
  end
end
