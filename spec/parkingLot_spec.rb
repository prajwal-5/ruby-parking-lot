require "spec_helper"
require_relative "../parkingLot"

describe("Checking ParkingLot's") do
    before(:each) do 
        @parkingLot = ParkingLot.new()
        @parkingLot.park("KA10101010")
        @allCars = @parkingLot.allCars
    end
    
    it("Parking Service") do
        find = @parkingLot.findCar("KA10101010")
        searchResult = @allCars[find][:carNo]
        @parkingLot.unpark(find)
        expect(searchResult).to eql("KA10101010")
    end

    it("Unpark Services") do
        @parkingLot.unpark(@parkingLot.findCar("KA10101010"))
        @parkingLot.findCar("KA10101010").should eql false
    end 

    it("Find Car Services") do
        find = @parkingLot.findCar("KA10101010")
        @parkingLot.unpark(find)
        find.should_not eql false
    end
end