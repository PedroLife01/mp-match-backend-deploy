class User < ApplicationRecord
    has_secure_password
    has_and_belongs_to_many :movies
    has_and_belongs_to_many :books
    has_and_belongs_to_many :shows
    has_one :preference, dependent: :destroy

    after_create :create_preference

    PASSWORD_LEN = 6

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: PASSWORD_LEN }, if: -> { new_record? || !password.nil? }

    attribute :is_admin, default: false

    private

    def create_preference
        build_preference.save
    end
end
