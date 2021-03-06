# larimar

Larimar is a property file reader

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  larimar:
    github: Wozzy06/larimar
```

## Usage

```crystal
require "larimar"

# create property file
properties = Larimar::Properties.new

# load properties from a file
properties.load("path/to/your/property-file")

# parse one line (String) and register its content in memory
# does nothing on invalid entry
properties.parse("your.property=value")

# get number of properties loaded
size = properties.size


# assert existence of a key
if properties.exists?("your.property")
  # get a loaded property
  # raise an exception if the key is invalid
  properties.get("your.property")
end

# get a loaded property
# return default value if requested does not exist
properties.get("your.fake.property", "your default value")

# delete a key
properties.delete("your.property")

# delete all properties
properties.flush


```

## Contributing

1. Fork it ( https://github.com/Wozzy06/larimar/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Wozzy06](https://github.com/Wozzy06) Mead - creator, maintainer
