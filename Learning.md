# Run code using
iex -S mix

# Run test
mix test

# Installing dependencies
mix deps.get

# Create docs
mix docs

# Updating a map
colors = %{primary: "red", secondary: "blue"}
Map.merge(oldMap, newMapData)
Map.delete(oldMap, :key)

# Keyword lists
iex(7)> colors = [{:primary, "red"}, {:secondary, "blue"}]
[primary: "red", secondary: "blue"]
iex(8)> colors[:primary]
"red"

# Pass reference to a function
Passing the reference to Enum.map of mirror_row that takes just one input
Enum.map(&mirror_row/1)