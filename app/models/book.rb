class Book < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :tags

    validates :name, presence: true, uniqueness: true
    validates :author, presence: true
    validates :year, presence: true
end
