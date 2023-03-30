require "date"

class Slot
    def initialize(slotNo, carNo)
        @slotNo = slotNo
        @carNo = carNo
        @entryTime = DateTime.now
    end

    def getSlot()
        slot = {
            :slotNo => @slotNo,
            :carNo => @carNo,
            :entryTime => @entryTime
        }
        return slot
    end
end
