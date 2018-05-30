module Larimar

  # describe an error due to inexisting property in a dataset
  #
  # since version 0.1.0
  # author : Mead
  class UnknownPropertyException < Exception
    def initialize
      super("no property registered")
    end
  end
end
