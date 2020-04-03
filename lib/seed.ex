defmodule Periodic.Seed do

  def build(start_date \\ ~D[2013-01-01], end_date \\ Date.utc_today) do

    list = map_date_flags(start_date, end_date)

    weeks = list
      |> Enum.filter(fn object ->
        object.is_end_of_week
      end)
      |> Enum.map(fn object ->
        object.date
      end)

    months = list
      |> Enum.filter(fn object ->
        object.is_end_of_month
      end)
      |> Enum.map(fn object ->
        object.date
      end)

    {:ok, weeks, months}
  end

  defp map_date_flags(date, end_date) when date == end_date, do: []
  defp map_date_flags(date, end_date) do
    value = %{
      date: date,
      is_end_of_week: is_end_of_week?(date),
      is_end_of_month: is_end_of_month?(date)
    }
    [value | map_date_flags(next_day(date), end_date)]
  end

  defp is_end_of_month?(date) do
    date.month !== next_day(date).month
  end

  defp is_end_of_week?(date) do
    !(date
      |> is_holiday?)
    &&
    (date
      |> next_day
      |> is_holiday?)
  end

  defp is_holiday?(date) do
    doe = Date.day_of_week(date)
    doe == 6 || doe == 7
  end

  defp next_day(date) do
    Date.add(date, 1)
  end

end
