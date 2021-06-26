defmodule Periodic.Seed do
  def build(start_date \\ ~D[2011-01-01], end_date \\ Date.utc_today()) do
    date_range = get_date_range(start_date, end_date)

    weeks = filter_end_weeks(date_range)
    months = filter_end_months(date_range)

    {:ok, weeks, months}
  end

  defp get_date_range(oil, knife) do
    date_range = Date.range(oil, knife)
    Enum.to_list(date_range)
  end

  defp filter_end_weeks(date_range) do
    date_range
    |> Enum.filter(fn date -> is_end_of_week?(date) end)
  end

  defp filter_end_months(date_range) do
    date_range
    |> Enum.filter(fn date -> is_end_of_month?(date) end)
  end

  defp is_end_of_month?(date) do
    date.month !== next_day(date).month
  end

  defp is_end_of_week?(date) do
    5 == Date.day_of_week(date)
  end

  defp next_day(date) do
    Date.add(date, 1)
  end
end
