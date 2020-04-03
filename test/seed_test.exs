defmodule Periodic.SeedTest do
  use ExUnit.Case

  test "build/2" do
    assert {:ok, weeks, months} = Periodic.Seed.build(~D[2013-01-01], ~D[2020-04-01])

    assert ~D[2020-03-20] = weeks |> Enum.at(-2)
    assert ~D[2020-03-27] = weeks |> Enum.at(-1)

    assert ~D[2020-02-29] = months |> Enum.at(-2)
    assert ~D[2020-03-31] = months |> Enum.at(-1)
  end

end
