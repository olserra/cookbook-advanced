require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'csv'

class Parsing
  attr_accessor :parsed_recipes

  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    html = open("http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@ingredient}").read
    doc = Nokogiri::HTML(html, nil, "utf-8")

    parsed_recipes = []

    doc.search('.recette_classique').first(5).each do |element|
      name = element.search('.m_titre_resultat').text.strip
      description = element.search('.m_texte_resultat').text.strip
      prep_time = element.search('.m_detail_time div').first.text.strip
      parsed_recipes << Recipe.new(name: name, description: description, prep_time: prep_time)

    end

    return parsed_recipes

  end
end
