# app/models/random_selection.rb
class RandomSelection < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: true
end
