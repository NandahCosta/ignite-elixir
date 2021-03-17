defmodule WordayReports do
  alias WordayReports.Parser

  def call(file_name) do
    "reports/#{file_name}"
    |> Parser.parser_csv()
    |> Enum.reduce(report_default_map(), fn el, report -> sum_values(el, report) end)
  end

  defp sum_values([name, hour, _day, month, year], %{
         all_hours: all_hours,
         hours_per_month: hours_per_month,
         hours_per_year: hours_per_year
       }) do
    all_hours = map_values(all_hours, name, hour)

    hours_per_month =
      hours_per_month
      |> Map.put(name, map_values(hours_per_month[name], get_month_name(month), hour))

    hours_per_year =
      hours_per_year
      |> Map.put(name, map_values(hours_per_year[name], year, hour))

    %{all_hours: all_hours, hours_per_month: hours_per_month, hours_per_year: hours_per_year}
  end

  defp report_default_map do
    %{all_hours: %{}, hours_per_month: %{}, hours_per_year: %{}}
  end

  defp map_values(map, key, hour) when not is_map(map) do
    Map.put(%{}, key, hour)
  end

  defp map_values(map, key, hour) when is_map(map) do
    Map.put(map, key, nil_to_number(map[key]) + hour)
  end

  def nil_to_number(value) when is_nil(value), do: 0
  def nil_to_number(value), do: value

  defp get_month_name(month_number) do
    months = %{
      1 => "jan",
      2 => "fev",
      3 => "mar",
      4 => "abr",
      5 => "mai",
      6 => "jun",
      7 => "jul",
      8 => "ago",
      9 => "set",
      10 => "out",
      11 => "nov",
      12 => "dez"
    }

    months[month_number]
  end
end
