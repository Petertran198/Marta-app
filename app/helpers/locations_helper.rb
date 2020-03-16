module LocationsHelper

    def valid_location(location)
        if location.latitude == nil || location.longitude == nil 
            return false 
        else
            return true
        end

    end


    #This method is going to take our longitude and latitude and its going to take the buses longitude and latitude and see if there are  buses that is within .69 mile radius 
    def nearby(lng1,lat1,lng2,lat2)
        if (lng1-lng2).abs <= 0.01 && (lat1-lat2).abs <= 0.01
            return true 
        else
            return false
        end
    end

end

