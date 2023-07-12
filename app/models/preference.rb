class Preference < ApplicationRecord
    belongs_to :user
    after_initialize :initialize_attributes

    private
    
    def initialize_attributes
        # Set the attribute to an empty string if it is nil
        self.book ||= "" 
        self.movie ||= "" 
        self.show ||= "" 
    end
end
