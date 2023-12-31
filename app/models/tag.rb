class Tag < ApplicationRecord
    has_and_belongs_to_many :movies
    has_and_belongs_to_many :books
    has_and_belongs_to_many :shows

    validates :name, presence: true, uniqueness: true
end
