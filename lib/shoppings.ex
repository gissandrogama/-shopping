defmodule Shoppings do
  @moduledoc """
  Documentation for `Shoppings`.
  """

  @doc """
  function to receive a shopping list and an email list. She passes on these lists to the `calculate / 2` function of the` Handle` module, to perform the due processing.

  ## Function parameters

    - buy: list of maps contains information items of a purchase
    - emails: list of emails that represent people who will share the total purchase price

  ## Additional Information

    - if the parameters passed are empty lists, the function returns an empty list

  ## Example buy/0

       iex> Shoppings.buy()
       [
         %{email: "teste1@gmail.com", value: "R$ 0.33"},
         %{email: "teste2@gmail.com", value: "R$ 0.33"},
         %{email: "teste3@gmail.com", value: "R$ 0.34"}
       ]

  ## Example buy/2

      iex> Shoppings.buy([%{name: "arroz", amount: 4, price: 598, type: "kg"}, %{name: "feijão", amount: 4, price: 799, type: "kg"}, %{name: "queijo mussarela", amount: 4, price: 4289, type: "kg"}], ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com", "teste4@gmail.com"])
      [
         %{email: "teste1@gmail.com", value: "R$ 56.86"},
         %{email: "teste2@gmail.com", value: "R$ 56.86"},
         %{email: "teste3@gmail.com", value: "R$ 56.86"},
         %{email: "teste4@gmail.com", value: "R$ 56.86"}
      ]
  """
  @buys [%{name: "baton garoto", amount: 1, price: 100, type: "unity"}]
  @emails ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com"]
  def buy do
    Handle.calculate(@buys, @emails)
  end

  def buy(buys, emails) do
    Handle.calculate(buys, emails)
  end
end
