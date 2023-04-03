class Car
  def initialize(registrationNo)
    @registrationNo = registrationNo
  end

  def isValid(carNo)
    size = 10
    if carNo.length == size
      return carNo.match?(/[a-zA-Z]{2}[\d]{8}/)
    else
      return false
    end
  end

  def registrationNo
    registrationNo
  end
end
