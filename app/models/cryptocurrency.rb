class Cryptocurrency < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: true
end
