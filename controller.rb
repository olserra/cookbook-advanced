require_relative 'recipe'
require_relative 'view'
require_relative 'parsing'
require_relative 'cookbook'
require 'byebug'

class Controller
  attr_accessor :new_recipe, :destroyed_recipe, :imported_recipe, :chosen_recipe, :mark_recipe, :recipe_to_mark

  def initialize(cookbook)
    @view = View.new
    @cookbook = cookbook
  end

  def list
    recipes = @cookbook.recipes
    @view.list_recipes(recipes)
  end

  def create
    recipe_name = @view.ask_for_recipe_name
    description = @view.ask_for_description
    new_recipe = Recipe.new(recipe_name, description)
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    destroyed_recipe = @view.remove_recipe
    @cookbook.remove_recipe(destroyed_recipe)
  end

  def import
    recipe_for_parsing = @view.ask_for_ingredient
    @parsing = Parsing.new(recipe_for_parsing)
    parsed_recipes = @parsing.call

    @view.list_recipes(parsed_recipes)

    index = @view.choose_recipe

    @cookbook.add_recipe(parsed_recipes[index])
  end

  def mark
    list
    recipe_to_mark = @view.choose_recipe
    @cookbook.mark_recipe(recipe_to_mark)
  end
end
