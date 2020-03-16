class Location < ApplicationRecord
    validates :address, presence: true
    validates :city, presence: true
    # This tells where geocoder finds the address
    geocoded_by :my_location
    # This is saying to run the geocode gem only after validation 
    after_validation :geocode

    def my_location
        "#{address}, #{city}, GA"
    end

end
