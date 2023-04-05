class Car
  def initialize(registrationNo)
    @registrationNo = registrationNo
  end

  def isValid()
    size = 10
    if @registrationNo.length == size
      return (@registrationNo.match?(/[a-zA-Z]{2}[\d]{8}/))
    end
  end

  def registrationNo
    @registrationNo
  end
end
