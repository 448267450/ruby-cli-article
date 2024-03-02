require_relative "article"

class User
  attr_accessor :attr_writer, :attr_reader

  def initialize(attr_writer, attr_reader)
    @attr_writer = attr_writer
    @attr_reader = attr_reader
  end 

  def to_s
    "#{@attr_reader} selected #{@attr_writer}"
  end 
end
