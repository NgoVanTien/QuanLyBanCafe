class Table < ApplicationRecord
  has_many :orders
  belongs_to :position
end
