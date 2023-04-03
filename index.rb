require_relative "console"

console = Console.new
choices = 6
while console.menu != choices
  console.controller(console.choice)
end
