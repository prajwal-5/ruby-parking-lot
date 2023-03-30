class Car
    def initialize(registrationNo)
        @registrationNo = registrationNo
    end

    def isValid(carNo)
        if carNo.length == 10
            return carNo.match?(/[a-zA-Z]{2}[\d]{8}/)
        else 
            return false
        end
    end

    def registrationNo
        return registrationNo
    end
end