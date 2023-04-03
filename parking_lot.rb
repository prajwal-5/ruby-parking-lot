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
    File.delete(@file)
    @file = File.open(fileName, "a+")
    @file.write(data.to_json)
    @file.close
  end

  def getSlots(parkedCars)
    hash = {}
    if parkedCars.length > 0
      count = 0
      while count < @parkedCars.length
        hash[parkedCars[count]["slotNo"]] = false
        count += 1
      end
    end
    hash
  end

  def park(carNo)
    car = Car.new(carNo)
    availableSlot = 0
    while availableSlot < @size
      if (!@slotHash[availableSlot] && @slotHash[availableSlot] != nil)
        availableSlot += 1
      else
        break
      end
    end
    emptySlot = Slot.new(availableSlot, carNo)
    @parkedCars.push(emptySlot.getSlot)
    @slotHash[availableSlot] = false
    updateFile("parking.json", @parkedCars)
    availableSlot
  end

  def unpark(car)
    invoice = InvoiceManager.new
    invoice.generateInvoice(car)
    @slotHash[car["slotNo"]] = nil
    @parkedCars = @parkedCars.find_all { |parkCar| parkCar != car }
    updateFile("parking.json", @parkedCars)
    true
  end

  def findCar(carNo)
    @parkedCars.find { |car| car["carNo"] == carNo } || false
  end

  def allCars
    @parkedCars
  end
end
