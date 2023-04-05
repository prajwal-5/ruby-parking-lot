require "spec_helper"
require_relative "../car"
require_relative "../slot"
require_relative "../invoice"

describe "Checking Inovice's" do
  before(:each) do
    @invoice = Invoice.new(Slot.new(1, Car.new("KA10101010")).getSlot, 1)
  end

  it("duration time") do
    expect(@invoice.calcDuration(DateTime.now)).to eql 0
  end

  it("chargeable amount") do
    expect(@invoice.calcAmount(DateTime.now - DateTime.now + 11)).to eql 200
  end
end
