defmodule WordayReportsTest do
  use ExUnit.Case
  alias WordayReports.Parser

  @setup "reports/workday_test.csv"

  describe " parser_csv/1" do
    test "should return parsed file" do
      result =
        @setup
        |> Parser.parser_csv()
        |> Enum.map(& &1)
        |> Enum.take(3)

      assert result == [
               ["Daniele", 7, 29, 4, 2018],
               ["Mayk", 4, 9, 12, 2019],
               ["Daniele", 5, 27, 12, 2016]
             ]
    end
  end

  describe "call/1" do
    test "return a report" do
      result =
        "workday_test.csv"
        |> WordayReports.call()

      assert %{all_hours: all, hours_per_month: per_month, hours_per_year: per_year} = result
      assert all["Cleiton"] == 12
      assert per_month["Cleiton"]["jun"] == 4
      assert per_year["Cleiton"][2020] == 9
    end
  end
end
