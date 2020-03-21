class Product < ApplicationRecord
    self.primary_key = 'asin'
    validates :asin, presence: true
    validates :category, presence: true
    validates :title, presence: true
    validates :rank, presence: true
    validates :dimensions, presence: true
end

  