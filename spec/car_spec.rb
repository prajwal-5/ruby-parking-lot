require "spec_helper"
require_relative "../car"

describe "Checking Car's" do
  it("invalid registration number") do
    car = Car.new("KA101010")
    expect(car.isValid).to eql nil
  end

  it("valid registration number") do
    car = Car.new("KA10101010")
    expect(car.isValid).to eql true
  end
end
