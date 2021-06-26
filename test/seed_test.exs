defmodule Periodic.SeedTest do
  use ExUnit.Case, async: true

  test "build/2" do
    assert {:ok, weeks, months} = Periodic.Seed.build(~D[2013-01-01], ~D[2020-04-01])

    assert ~D[2020-03-20] = weeks |> Enum.at(-2)
    assert ~D[2020-03-27] = weeks |> Enum.at(-1)

    assert ~D[2020-02-29] = months |> Enum.at(-2)
    assert ~D[2020-03-31] = months |> Enum.at(-1)
  end

  test "weekly" do
    assert {:ok, weeks, _months} = Periodic.Seed.build(~D[2013-01-01], ~D[2021-06-25])

    assert ~D[2021-06-25] = weeks |> Enum.at(-1)
    assert ~D[2021-06-18] = weeks |> Enum.at(-2)
  end
end
