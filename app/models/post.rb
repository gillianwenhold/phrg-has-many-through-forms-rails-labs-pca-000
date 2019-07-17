# frozen_string_literal: true

class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |attr|
      cat = Category.find_or_create_by(attr)
      post_categories.build(category: cat) unless categories.include?(cat)
      categories << cat
    end
  end
end
