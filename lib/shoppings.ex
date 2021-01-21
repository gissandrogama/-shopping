defmodule Shoppings do
  @moduledoc """
  Documentation for `Shoppings`.
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
