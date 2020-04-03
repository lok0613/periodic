defmodule Periodic do
  alias Periodic.Transform
  alias Periodic.Seed

  def get_daily(objects, _seed \\ nil) do
    objects
  end

  def get_weekly(objects, seed \\ Seed.build()) do
    Transform.to_weeks(objects, seed)
  end

  def get_monthly(objects, seed \\ Seed.build()) do
    Transform.to_months(objects, seed)
  end

end
