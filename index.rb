require_relative "console"

console = Console.new
while console.menu != Console::QUIT
  console.controller(console.choice)
end
