require "./larimar/version.cr"

# Larimar is a property file reader
# version : 0.1.0
# author : Mead
module Larimar
  extend self

  DATA = Hash(String, String).new

  # get a loaded property
  # raise an exception if the key is invalid
  def get(key : String) : String
    keys = key.split('.')
    raise Exception.new("no property registered") unless (DATA.has_key?(key))
    DATA[key]
  end

  # load properties from a file
  def load(path : String) : Void
    lines = File.read_lines(path)
    lines.each do |line|
      parse(line)
    end
  end

  # parse one line (String) and register its content in memory
  # does nothing on invalid entry
  def parse(line : String) : Void
    sides = line.split('=', 2)
    return if (sides.size != 2 || sides[0] == "" || sides[1] == "" || sides[0].char_at(0) == '#')
    key = sides[0]
    DATA[key] = sides[1]
  end

  # delete all data
  def flush : Void
    DATA.clear
  end
end
