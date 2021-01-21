defmodule ShoppingsTest do
  use ExUnit.Case
  doctest Shoppings

  describe "buy/0" do
    test "taking values ​​from the macros defined in the Shopping module" do
      result = Shoppings.buy()

      assert result == [
               %{email: "teste1@gmail.com", value: "R$ 0.33"},
               %{email: "teste2@gmail.com", value: "R$ 0.33"},
               %{email: "teste3@gmail.com", value: "R$ 0.34"}
             ]
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

      assert result == [
               %{email: "teste1@gmail.com", value: "R$ 17.0"},
               %{email: "teste2@gmail.com", value: "R$ 17.0"},
               %{email: "teste3@gmail.com", value: "R$ 17.0"}
             ]
    end
  end
end
