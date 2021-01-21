defmodule Handle do
  @moduledoc """
  Handle module for list entries such as `items` and `emails`.
  The most used function and the `calculate/2` function.
  """

  @doc """
  Function calculates the total value of a list of items,
  divides the total amount according to the amount and past emails.

  ## Function parameters

    - items: list of maps contains information about the list item
    - emails: list of people who will be divided the total amount

  ## Additional Information

    - if the parameters passed are empty lists, the function returns an empty list

  ## Example empty lists

       iex> Handle.calculate([], [])
       []

  ## Example non-empty lists

      iex> Handle.calculate([%{name: "arroz", amount: 4, price: 598, type: "kg"}, %{name: "feijão", amount: 4, price: 799, type: "kg"}, %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"}], ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com", "teste4@gmail.com"])
      [
         %{email: "teste1@gmail.com", value: "R$ 56.86"},
         %{email: "teste2@gmail.com", value: "R$ 56.86"},
         %{email: "teste3@gmail.com", value: "R$ 56.86"},
         %{email: "teste4@gmail.com", value: "R$ 56.86"}
      ]
  """
  def calculate([], []), do: []

  @spec calculate(list(), list()) :: [map()]
  def calculate(items, emails) do
    amount = items |> Enum.map(fn item -> item.amount * item.price end) |> Enum.sum()
    people = emails |> Enum.count()

    split(amount, people, emails)
  end

  @doc """
  Function calculates apportionment of how much each person must pay.
  And it displays in a `map` with the email of each person and the amount of must be paid.

  ## Function parameters

    - value: total value of the list of items, the result of the sum of the quantity
            and the unique value of each item.
    - quantity: number of people / emails from the email list
    - emails: the email list

  ## Additional Information

    - function returns a `list` of` map`:
    ```Elixir
      [%{email: teste@email.com, value: "R$ 50.00"}]
    ```

  ## Example

       iex> Handle.split(100, 3, ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com"])
       [
        %{email: "teste1@gmail.com", value: "R$ 0.33"},
        %{email: "teste2@gmail.com", value: "R$ 0.33"},
        %{email: "teste3@gmail.com", value: "R$ 0.34"}
       ]
  """
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

  @doc """
  the function receives an infinite decimal decimal or a fractional decimal. Put it to two decimal places
  and return an instring in integer format.

  ## Function parameters

    - clove: value obtained by dividing the sum of items by number of people / email

  ## Additional Information

    - this function only reaches numbers with infinite decimals or fractions with more than 3 decimal places

  ## Example

       iex> Handle.process(33.33333333333)
       "033"

       iex> Handle.process(2986.333333333336)
       "2986"
  """
  @spec process(float) :: String.t()
  def process(cloven) when is_float(cloven) do
    cloven = cloven / 100

    cloven
    |> Float.floor(2)
    |> Float.to_string()
    |> String.split(".")
    |> Enum.join()
  end

  defp print(list) do
    Enum.map(list, fn list -> %{email: list.email, value: "R$ #{list.value / 100}"} end)
  end
end
