defmodule ListFilter do
  def call(list) do
    tratar_string_integer(list)
    |> Enum.filter(fn x -> rem(x, 2) == 1 end)
    |> Enum.count()
  end

  defp tratar_string_integer([head | tail] = list) do
    Enum.flat_map(list, fn l ->
      case Integer.parse(l) do
        {int, _rest} -> [int]
        :error -> []
      end
    end)
  end
end
