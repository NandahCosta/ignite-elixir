defmodule ListFilterTest do
  alias ListFilter
  use ExUnit.Case

  describe "call/1" do
    test "return total 3 elements" do
      list = ["1", "3", "6", "43", "banana", "6", "abc"]

      assert ListFilter.call(list) == 3
    end
  end
end
