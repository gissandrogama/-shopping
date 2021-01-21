defmodule ShoppingsTest do
  use ExUnit.Case
  doctest Shoppings

  describe "buy/0" do
    test "taking values ​​from the macros defined in the Shopping module" do
      result = Shoppings.buy()

      assert 1.0 == Enum.map(result, & &1.value) |> Enum.sum()
    end
  end

  describe "buy/2" do
    test "passing shopping list and emails" do
      buys = [
        %{name: "baton garoto", amount: 1, price: 1_00, type: "unity"},
        %{name: "contra file", amount: 1, price: 50_00, type: "kg"}
      ]

      emails = ["teste1@gmail.com", "teste2@gmail.com", "teste3@gmail.com"]

      result = Shoppings.buy(buys, emails)

      assert Enum.map(result, & &1.value) |> Enum.sum() == 51.0
    end
  end
end
