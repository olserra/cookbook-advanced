class Recipe
  attr_accessor :mark, :name, :description, :prep_time

  def initialize(attributes = {})
    @mark = "[ ]"
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
  end
end
