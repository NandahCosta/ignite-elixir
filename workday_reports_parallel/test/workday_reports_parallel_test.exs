defmodule WorkdayReportsParallelTest do
  use ExUnit.Case
  alias WorkdayReportsParallel.Parser

  @setup ["reports/workday_test.csv"]

  describe "call/1" do
    test "formted report" do
      assert %{all_hours: all, hours_per_month: per_month, hours_per_year: per_year} =
               WorkdayReportsParallel.call(@setup)
    end
  end
end
