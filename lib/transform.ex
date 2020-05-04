defmodule Periodic.Transform do

  def to_weeks(objects, {:ok, end_of_weeks, _end_of_months}) do
    first_date = first_date(objects)

    end_of_weeks = sharpen_the_dividers(first_date, end_of_weeks)
    groups = group_by_dividers(objects, end_of_weeks)
    calculate(groups)
  end

  def to_months(objects, {:ok, _end_of_weeks, end_of_months}) do
    first_date = first_date(objects)

    end_of_months = sharpen_the_dividers(first_date, end_of_months)
    groups = group_by_dividers(objects, end_of_months)
    calculate(groups)
  end

  defp calculate([]), do: []
  defp calculate([[] | groups]), do: calculate(groups)
  defp calculate([group | groups]) do
    {first_day, last_day} = {Enum.at(group, 0), Enum.at(group, -1)}
    date = Map.get(last_day, :date)
    close = Map.get(last_day, :close)
    open = Map.get(first_day, :open)
    high = group
      |> Enum.map(fn object -> object.high end)
      |> Enum.max
    low = group
      |> Enum.map(fn object -> object.low end)
      |> Enum.min
    volume = group
      |> Enum.map(fn object -> object.volume end)
      |> Enum.sum

    [%{
      date: date,
      close: close,
      open: open,
      high: high,
      low: low,
      volume: volume
    } | calculate(groups)]
  end

  defp group_by_dividers(objects, []), do: [objects]
  defp group_by_dividers(objects, [divider | dividers]) do
    {objects_this_period, objects} = match_by_divider(objects, divider)
    [objects_this_period | group_by_dividers(objects, dividers)]
  end

  defp match_by_divider(objects, divider) do
    Enum.split_while(objects, fn object ->
      compare = Date.compare(divider, object.date)
      compare == :eq || compare == :gt
    end)
  end

  defp sharpen_the_dividers(first_date, [limit | limits]) do
    if Date.compare(limit, first_date) == :gt do
      [limit | limits]
    else
      sharpen_the_dividers(first_date, limits)
    end
  end

  defp first_date(object) do
    object
      |> Enum.at(0)
      |> Map.get(:date)
  end

end
