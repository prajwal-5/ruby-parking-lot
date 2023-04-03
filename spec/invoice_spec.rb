require "spec_helper"
require_relative "../parking_lot"
require_relative "../invoice"

describe "Checking Inovice's" do
  before(:each) do
    @parkingLot = ParkingLot.new
    @parkingLot.park("KA10101010")
    find = @parkingLot.findCar("KA10101010")
    @invoice = Invoice.new(find, 1)
    @parkingLot.unpark(find)
  end

  it("duration time") do
    expect(@invoice.calcDuration(DateTime.now)).to eql 0
  end

  it("chargeable amount") do
    expect(@invoice.calcAmount(DateTime.now - DateTime.now + 11)).to eql 200
  end
end
