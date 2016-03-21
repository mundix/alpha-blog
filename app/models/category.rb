class Category < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name #esto garantiza que este campo sea unico.
end