# list string
movies = ["Back to the Future", "Star Trek", "Terminator", "The Matrix"]



# list string, (string -> string) -> list string
IO.inspect Enum.map(movies, &String.upcase/1)



# list string, (string -> int) -> list int
IO.inspect Enum.map(movies, &String.length/1)



# list string, (string -> list string) -> list string
IO.inspect Enum.flat_map(movies, &String.split/1)



# string -> list string
starting_with_t = fn(string) ->
  if String.starts_with?(string, "T") do
    [string]
  else
    []
  end
end

# list string, (string -> list string) -> list string
IO.inspect Enum.flat_map(movies, starting_with_t)



# string -> list map
to_events = fn(string) ->
  [%{name: "save_movie", title: string}, %{name: "send_email"}]
end

# list string, (string -> list map) -> list map
IO.inspect Enum.flat_map(movies, to_events)



IO.inspect movies
|> Enum.flat_map(starting_with_t)
|> Enum.flat_map(to_events)
