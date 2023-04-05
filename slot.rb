require "date"

class Slot
  def initialize(slotNo, car)
    @slotNo = slotNo
    @carNo = car.registrationNo
    @entryTime = DateTime.now
  end

  def getSlot()
    {
      "slotNo" => @slotNo,
      "carNo" => @carNo,
      "entryTime" => @entryTime,
    }
  end
end
