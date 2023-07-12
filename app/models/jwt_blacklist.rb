class JwtBlacklist < ApplicationRecord
    validates :jwt, presence: true, uniqueness: true
end
