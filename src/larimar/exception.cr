module Larimar
  class UnknownPropertyException < Exception
    def initialize
      super("no property registered")
    end
  end
end
