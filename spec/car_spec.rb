require "spec_helper"
require_relative "../car"

describe "Checking Car's" do
    before(:each) do
        @car = Car.new("")
    end

    it("invalid registration number") do
        expect(@car.isValid("KA101010")).to eql false
    end

    it("valid registration number") do
        expect(@car.isValid("KA10101010")).to eql true
    end
end