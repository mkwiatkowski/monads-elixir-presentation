defmodule Eff do
  def return(val) do
    {val, :return, []}
  end

  def gets(msg) do
    {msg, :gets, []}
  end

  def puts(msg) do
    {msg, :puts, []}
  end

  def and_then({val, effect_name, fs}, f) do
    {val, effect_name, fs ++ [f]}
  end

  ###

  def run({val, effect_name, fs}) do
    result = case effect_name do
               :return -> val
               :gets -> IO.gets(val)
               :puts -> IO.puts(val)
             end
    case fs do
      [f | rest] ->
        {new_val, new_effect_name, new_fs} = f.(result)
        run({new_val, new_effect_name, new_fs ++ rest})
      [] -> nil
    end
  end
end

defmodule App do
  def trim_string(s) do
    Eff.return(String.trim(s))
  end

  def string_to_int(s) do
    Eff.return(String.to_integer(s))
  end

  def subtract_from_100(x) do
    Eff.return(100 - x)
  end

  def print_number(n) do
    Eff.puts("#{n} do setki!")
  end

  def main() do
    Eff.gets("Ile masz lat? ")
    |> Eff.and_then(&trim_string/1)
    |> Eff.and_then(&string_to_int/1)
    |> Eff.and_then(&subtract_from_100/1)
    |> Eff.and_then(&print_number/1)
  end
end

Eff.run(App.main())
