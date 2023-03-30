require_relative "car"
require "json"
require "io/console"
require_relative "slot"
require_relative "invoiceManager"

class ParkingLot
    def initialize
        @file = File.open("parking.json", "a+")
        @parkedCars = JSON.load(@file) || []
        @size = 10
        @slotHash = getSlots(@parkedCars)
    end

    def isFull
        return (@parkedCars.length >= @size)
    end

    def isEmpty
        return (@parkedCars.length == 0)
    end

    def getSlots(parkedCars)
        hash = {}
        if parkedCars.length > 0
            count = 0
            while count < @parkedCars.length
                hash[parkedCars[count][:slotNo]] = false
                count += 1
            end
        end
        return hash
    end

    def park(carNo)
        car = Car.new(carNo)
        availableSlot = 0
        while availableSlot < @size
            if(!@slotHash[availableSlot] && @slotHash[availableSlot]!=nil) 
                availableSlot += 1
            else
                break
            end
        end
        emptySlot = Slot.new(availableSlot, carNo)
        File.delete(@file)
        @file = File.open("parking.json", "a+")
        @parkedCars.push(emptySlot.getSlot)
        @file.write(@parkedCars.to_json)
        @slotHash[availableSlot] = false
        @file.close
        return availableSlot
    end

    def unpark(car)
        invoice = InvoiceManager.new
        invoice.generateInvoice(@parkedCars, car)
        @slotHash[@parkedCars[car][:slotNo]] = nil
        @parkedCars.delete_at(car)
        File.delete(@file)
        @file = File.open("parking.json", "a+")
        @file.write(@parkedCars.to_json)
        @file.close
        return true
    end

    def findCar(carNo)
        car = 0
        while car < @parkedCars.length
            if(@parkedCars[car][:carNo] == carNo)
                return car
            end
            car += 1
        end
        return false
    end

    def allCars
        return @parkedCars
    end
end