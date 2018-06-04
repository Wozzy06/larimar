require "./exception.cr"

module Larimar
  # Hash(String, String) alias
  alias DataSet = Hash(String, String)

  # Properties class instances hold data in a Hash(String, String) and can perform all CRUD operations.
  #
  # since version 0.1.1
  # author : Mead
  class Properties
    getter data

    def initialize
      @data = DataSet.new
    end

    # get a loaded property from specified *key*
    # raise an exception if the key is invalid
    def get(key : String) : String
      raise UnknownPropertyException.new unless (exists?(key))
      @data[key]
    end

    # get a loaded property from specified *key*
    # or if not exist *default*
    def get(key : String, default : String) : String
      return default unless (exists?(key))
      @data[key]
    end

    # delete a *key*
    def delete(key : String) : Void
      @data.delete key
    end

    # determine wether a *key* exists or not
    def exists?(key : String) : Bool
      @data.has_key? key
    end

    # get number of properties
    def size : Int32
      @data.size
    end

    # load properties from a *path* file
    def load(path : String) : Void
      lines = File.read_lines path
      lines.each do |line|
        parse line
      end
    end

    # parse one *line* (String) and register its content in memory
    # does nothing on invalid entry
    def parse(line : String) : Void
      sides = line.split '=', 2
      return if sides.size != 2 || sides[0] == "" || sides[1] == "" || sides[0].char_at(0) == '#'
      key = sides[0]
      @data[key] = sides[1]
    end

    # delete all data
    def flush : Void
      @data.clear
    end
  end
end
