require_relative "car"
require_relative "parking_lot"
require_relative "invoice_manager"

class Console
  PARK_CAR = 1
  UNPARK_CAR = 1
  FIND_CAR = 2
  GET_ALL_INVOICES = 3
  FIND_INVOICE = 4
  GET_ALL_PARKED_CARS = 5
  QUIT = 6

  def initialize
    @choice = nil
  end

  def menu
    puts("\n\n-----------------------------------------------------------------------")
    puts("PARKING LOT")
    puts("-----------------------------------------------------------------------\n\n")
    puts("\t1. Park")
    puts("\t2. Find")
    puts("\t3. All Invoices")
    puts("\t4. Invoice")
    puts("\t5. Cars parked")
    puts("\t6. Quit")
    puts("-----------------------------------------------------------------------\n\n")
    @choice = isValid(gets.chomp.to_i)
  end

  def isValid(choice)
    minChoice = 1
    maxChoice = 6
    if choice < minChoice || choice > maxChoice
      puts("Please choose a valid Option!!")
      return nil
    end
    choice
  end

  def choice
    @choice
  end

  def getDetails
    loop do
      puts("\n------------------------------------------------------------------------------------------------------------")
      puts("NOTE: Registration Number is of format AANNNNNNNN containing 2 alphabets and 8 numbers where \nN-> Number and A-> Alphabet \nEg. KA12345678, HR87654321 are valid registration Number.")
      puts("------------------------------------------------------------------------------------------------------------\n\n")
      puts("Enter the Car's Registration Number: ")
      carNo = gets.chomp
      car = Car.new(carNo)
      if car.isValid()
        return car
      else
        puts("\n------------------------------")
        puts("Invalid Car Number!!!")
        puts("Press 1 to exit")
        puts("Press enter to retry")
        puts("------------------------------\n")
        choice = gets.chomp.to_i
        if choice == 1
          return false
        end
      end
    end
  end

  def controller(choice)
    parkingLot = ParkingLot.new
    invoiceManager = InvoiceManager.new

    if (choice == PARK_CAR)
      if (parkingLot.isFull?)
        puts("Parking lot is full !!!")
      else
        car = getDetails
        if car
          puts("\nCAR PARKED at Slot No #{parkingLot.park(car)} !!!")
        end
      end
    elsif (choice == FIND_CAR)
      if (parkingLot.isEmpty?)
        puts("Parking lot is Empty !!!")
        return
      end
      car = getDetails
      if car
        searchCar = parkingLot.findCar(car)
        if searchCar
          puts("\n\nCAR FOUND !!!")
          puts("\nYour Car {#{searchCar["carNo"]}} is Parked at Parking Slot - #{searchCar["slotNo"]}\n\n")
          puts("Press 1 to unpark the car")
          puts("Press enter to return\n")
          choice = gets.chomp.to_i
          if (choice == UNPARK_CAR)
            parkingLot.unpark(searchCar)
            puts("\nUnparked your car !!!\n")
          end
        else
          puts("\nCar Not Found !!!\n")
        end
      end
    elsif (choice == GET_ALL_INVOICES)
      if invoiceManager.isEmpty?
        puts("No invoices to show")
      else
        invoices = invoiceManager.allInvoices
        puts("\n\n-----------------------------------------------------------------------")
        puts("ALL INOVICES")
        puts("-----------------------------------------------------------------------\n\n")
        puts("\tInvoice ID \t Amount \t Duration\n\n")
        invoices.each { |invoice| puts("\t #{invoice["invoiceId"]}  \t\t \u20B9 #{invoice["invoiceAmount"]} \t\t #{invoice["duration"]} seconds") }
        puts("\n-----------------------------------------------------------------------\n\n")
        puts("Press enter to continue!")
        STDIN.getch
      end
    elsif (choice == FIND_INVOICE)
      if (invoiceManager.isEmpty?)
        puts("No Invoices Generated !!!")
      else
        puts("Enter Invoice ID: ")
        invoiceID = gets.chomp
        invoice = invoiceManager.findInvoice(invoiceID)
        if (invoice == false)
          puts("No invoice Found")
        else
          puts("\n\n-----------------------------------------------------------------------")
          puts("INVOICE DETAILS")
          puts("-----------------------------------------------------------------------\n\n")
          puts("\tInvoiceID:   #{invoice["invoiceId"]}")
          puts("\tCar No.:     #{invoice["carNo"]}")
          puts("\tEntry Time:  #{invoice["entryTime"]}")
          puts("\tExit Time:   #{invoice["exitTime"]}")
          puts("\tDuration:    #{invoice["duration"]} seconds")
          puts("\tAmout:       \u20B9 #{invoice["invoiceAmount"]}")
          puts("\n-----------------------------------------------------------------------\n\n")
          puts("Press enter to continue!")
          STDIN.getch
        end
      end
    else
      if parkingLot.isEmpty?
        puts("No Cars Parked !!!")
      else
        parkedCars = parkingLot.allCars
        car = 0
        puts("\n\n-----------------------------------------------------------------------")
        puts("ALL PARKED CARS")
        puts("-----------------------------------------------------------------------\n\n")
        puts("\tParked Cars \t\t Slot No.\n\n")
        parkedCars.each { |car| puts("\t#{car["carNo"]} \t\t #{car["slotNo"]}") }
        puts("\n-----------------------------------------------------------------------\n\n")
        puts("Press enter to continue!")
        STDIN.getch
      end
    end
  end
end
