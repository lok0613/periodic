defmodule PeriodicTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, content} = File.read("./test/fixtures/0005.json")
    objects_5 = Jason.decode!(content, %{keys: :atoms})

    {:ok, content} = File.read("./test/fixtures/1972.json")
    objects_1972 = Jason.decode!(content, %{keys: :atoms})

    {:ok, content} = File.read("./test/fixtures/1003.json")
    objects_1003 = Jason.decode!(content, %{keys: :atoms})

    {:ok, objects_5: objects_5, objects_1972: objects_1972, objects_1003: objects_1003}
  end

  describe "obejcts_5" do

    test "get_daily/2", %{objects_5: objects} do
      daily_objects = Periodic.get_daily(objects)

      assert %{
        date: "2020-03-16",
        high: 44.75,
        low: 43.6,
        open: 44,
        close: 43.8,
        volume: 91411.722,
        turnover: 4020102910
      } = daily_objects |> Enum.at(-3)

      assert %{
        date: "2020-03-17",
        high: 45.5,
        low: 43.85,
        open: 45,
        close: 44.95,
        volume: 61904.936,
        turnover: 2754086597
      } = daily_objects |> Enum.at(-2)

      assert %{
        date: "2020-03-18",
        high: 46.5,
        low: 44.15,
        open: 45.2,
        close: 44.55,
        volume: 63302.201,
        turnover: 2859069909
      } = daily_objects |> Enum.at(-1)
    end

    test "get_weekly/2", %{objects_5: objects} do
      weekly_objects = Periodic.get_weekly(objects)

      assert %{
        date: "2020-03-06",
        high: 53.1,
        low: 50.55,
        open: 52.5,
        close: 50.65,
        volume: 329534.97900000005
      } = weekly_objects |> Enum.at(-3)

      assert %{
        date: "2020-03-13",
        high: 49.55,
        low: 42,
        open: 49,
        close: 45.7,
        volume: 451820.404
      } = weekly_objects |> Enum.at(-2)

      assert %{
        date: "2020-03-18",
        high: 46.5,
        low: 43.6,
        open: 44,
        close: 44.55,
        volume: 216618.859
      } = weekly_objects |> Enum.at(-1)
    end

    test "get_monthly/2", %{objects_5: objects} do
      monthly_objects = Periodic.get_monthly(objects)

      assert %{
        date: "2020-01-31",
        high: 61.2,
        low: 56.7,
        open: 60.85,
        close: 56.85,
        volume: 370224.17199999996
      } = monthly_objects |> Enum.at(-3)

      assert %{
        date: "2020-02-28",
        high: 59.9,
        low: 53,
        open: 56.35,
        close: 53.15,
        volume: 736133.0200000001
      } = monthly_objects |> Enum.at(-2)

      assert %{
        date: "2020-03-18",
        high: 53.1,
        low: 42,
        open: 52.5,
        close: 44.55,
        volume: 997974.2420000001
      } = monthly_objects |> Enum.at(-1)
    end

  end

  describe "objects_1972" do

    test "get_monthly/2", %{objects_1972: objects} do
      monthly_objects = Periodic.get_monthly(objects)

      assert %{
        date: "2020-04-01",
        high: 21.3,
        low: 20.15,
        open: 20.8,
        close: 20.3,
        volume: 3787.352
      } = monthly_objects |> Enum.at(-1)
    end

  end

  describe "objects_1003" do

    test "get_weekly/2", %{objects_1003: objects} do
      weekly_objects = Periodic.get_weekly(objects)

      assert %{
        date: "2020-04-03",
        high: 1.430,
        low: 1.350,
        open: 1.380,
        close: 1.390,
        volume: 3340.0
      } = weekly_objects |> Enum.at(-2)

    end

  end

end
