require "./larimar/version.cr"

# Larimar is a property file reader
# version : 0.1.0
# author : Mead
module Larimar
  extend self

  private DATA = Hash(String, String).new

  # get a loaded property
  # raise an exception if the key is invalid
  def get(key : String) : String
    keys = key.split('.')
    raise Exception.new("no property registered") unless (exists?(key))
    DATA[key]
  end

  # delete a key
  def delete(key : String)
    DATA.delete(key)
  end

  # determine wether a key exists or not
  def exists?(key : String) : Bool
    DATA.has_key?(key)
  end

  def size
    DATA.size
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
