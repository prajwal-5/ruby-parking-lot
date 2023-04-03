require "date"

class Slot
  def initialize(slotNo, carNo)
    @slotNo = slotNo
    @carNo = carNo
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
