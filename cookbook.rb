require_relative 'recipe'
require_relative 'controller'
require 'csv'
require 'byebug'


class Cookbook
  attr_accessor :recipes, :mark_recipe

  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file

    CSV.foreach(csv_file) do |row|
      name = row[0]
      description = row[1]
      prep_time = row[2]
      @recipes << Recipe.new(name: name, description: description, prep_time: prep_time)
    end
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    @recipes.push(new_recipe)
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  private

  def update_csv
    CSV.open(@csv_file, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time]
      end
    end
  end

  def save_recipes
    CSV.foreach(csv_file) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2])
    end
  end

  def mark_recipe(mark_index)
    @recipes[mark_index + 1][mark => "[x]"]
    update_csv
  end
end





