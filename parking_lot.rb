require_relative "car"
require "json"
require "io/console"
require_relative "slot"
require_relative "invoice_manager"

class ParkingLot
  def initialize
    @file = File.open("parking.json", "a+")
    @parkedCars = JSON.load(@file) || []
    @size = 10
    @slotHash = getSlots(@parkedCars)
  end

  def isFull?
    @parkedCars.length >= @size
  end

  def isEmpty?
    @parkedCars.empty?
  end

  def updateFile(fileName, data)
    @file.close
    @file = File.open(fileName, "w+")
    @file.write(data.to_json)
    @file.close
  end

  def getSlots(parkedCars)
    hash = {}
    if parkedCars.length > 0
      @parkedCars.each { |car| hash[car["slotNo"]] = false }
    end
    hash
  end

  def getAvailableSlot
    (0...@size).find { |slot| @slotHash[slot] == nil }
  end

  def park(car)
    availableSlot = getAvailableSlot
    emptySlot = Slot.new(availableSlot, car)
    @parkedCars.push(emptySlot.getSlot)
    @slotHash[availableSlot] = false
    updateFile("parking.json", @parkedCars)
    availableSlot
  end

  def unpark(slot)
    invoice = InvoiceManager.new
    invoice.generateInvoice(slot)
    @slotHash[slot["slotNo"]] = nil
    @parkedCars = @parkedCars.find_all { |parkCar| parkCar != slot }
    updateFile("parking.json", @parkedCars)
    true
  end

  def findCar(car)
    @parkedCars.find { |slot| slot["carNo"] == car.registrationNo } || false
  end

  def allCars
    @parkedCars
  end
end
