require_relative "car"
require_relative "parkingLot"
require_relative "console"

console = Console.new

while console.menu != 6
    console.controller(console.choice)
end