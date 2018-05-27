require "./larimar/version.cr"

# Larimar is a property file reader
# version : 0.1.0
# author : Mead
module Larimar
  extend self

  private class CustomHash < Hash(String, CustomHash | String)
  end

  alias HashOrString = CustomHash | String

  DATA = Hash(String, HashOrString).new

  # get a loaded property 
  # raise an exception if the key is invalid
  def get(key : String)
    keys = key.split('.')
    data : String | HashOrString = data
    i = 1
    raise Exception.new("no property registered") if (keys.empty?)
    data = key.fetch(keys[0])
    while (key != keys.length)
      temp = keys[i]
      raise Exception.new("invalid key \"#{key}\"") unless (data.has_key?(temp))
      data = data.fetch(temp)
      if (keys.size != i)
        raise Exception.new("invalid key \"#{key}\" : it should be the last") if (data.is_a?(String))
      else
        raise Exception.new("missing next key(s)") unless (data.is_a?(String))    
      end
      i += 1
    end
    return data.to_s
  end

  # load properties from a file
  def load(path : String)
    lines = File.read_lines(path)
    lines.each do |line|
      parse(line)
    end
  end

  # parse one line (String) and register its content in memory
  # does nothing on invalid entry
  def parse(line : String)
    sides = line.split('=')
    return if sides.size < 2 || sides[0] == "" || sides[1] == "" 
    keys = sides[0].split('.')
    if (DATA.has_key?(keys[0]))
      data = DATA[keys[0]]
    else
      data = CustomHash.new  
      DATA[keys[0]] = data
    end
    i = 1
    while (i != keys.size)
      if (data.has_key?(keys[i]))
        data = data[keys[i]]
      else
        temp = CustomHash.new
        data[key[i]] = temp
        data = temp
      end
      i += 1
    end
    res = ""
    i = 0
    while (i != sides.size)
      res = res.concat(sides[i])
      i + =1
    end
    data[key[i]] = res
  end

  # delete all data
  def flush
    data.clear
  end
end
