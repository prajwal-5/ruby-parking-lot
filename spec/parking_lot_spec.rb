require "spec_helper"
require_relative "../car"
require_relative "../slot"
require_relative "../parking_lot"

describe("Checking ParkingLot's") do
  before(:all) do
    @parkingLot = ParkingLot.new()
    @initialParkedCars = @parkingLot.allCars.length
    @initialInvoices = InvoiceManager.new.allInvoices.length
    @car = Car.new("KA10101010")
    @slot = Slot.new(1, @car)
  end

  before(:each) do
    @parkingLot.park(@car)
    @allCars = @parkingLot.allCars
  end

  it("Parking Service") do
    expect(@parkingLot.findCar(@car)["carNo"]).to eql(@car.registrationNo)
  end

  it("Unpark Services") do
    @parkingLot.unpark(@parkingLot.findCar(@car))
    @allCars = @parkingLot.allCars
    expect(@parkingLot.findCar(@car)).to eql false
  end

  it("Find Car Services") do
    expect(@parkingLot.findCar(@car)).not_to eql false
  end

  after(:each) do
    while (@allCars.length != @initialParkedCars)
      @parkingLot.unpark(@parkingLot.findCar(@car))
      @allCars = @parkingLot.allCars
    end
    invoiceManager = InvoiceManager.new
    allInvoices = invoiceManager.allInvoices
    while (allInvoices.length > @initialInvoices)
      invoiceManager.deleteInvoice(invoiceManager.findInvoice(invoiceManager.allInvoices.length - 1))
      allInvoices = invoiceManager.allInvoices
    end
  end

  after(:all) do
    if @initialInvoices == 0
      File.delete("invoice.json")
    end
    if @initialParkedCars == 0
      File.delete("parking.json")
    end
  end
end
