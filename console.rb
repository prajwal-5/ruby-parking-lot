require_relative "car"
require_relative "parking_lot"
require_relative "invoice_manager"

class Console
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
    if choice < 1 || choice > 6
      puts("Please choose a valid Option!!")
      return nil
    end
    choice
  end

  def choice
    @choice
  end

  def getDetails
    puts("\nNOTE: Registration Number is of format AANNNNNNNN where N-> Number and A-> Alphabet \nEg. KA10101010, HK10110011 are valid registration Number.\n\n")
    puts("Enter the Car's Registration Number: ")
    carNo = gets.chomp
  end

  def controller(choice)
    operation = ParkingLot.new
    invoiceManager = InvoiceManager.new

    if (choice == 1)
      if (operation.isFull?)
        puts("Parking lot is full !!!")
      else
        carNo = getDetails
        car = Car.new(carNo)
        if car.isValid(carNo)
          puts("\nCAR PARKED at Slot No #{operation.park(carNo)} !!!")
        else
          puts("Invalid Car Number !!!")
        end
      end
    elsif (choice == 2)
      if (operation.isEmpty?)
        puts("Parking lot is Empty !!!")
      else
        carNo = getDetails
        car = Car.new(carNo)
        if car.isValid(carNo)
          searchCar = operation.findCar(carNo)
          if (searchCar != false)
            puts("\n\nCAR FOUND !!!")
            puts("\nYour Car {#{searchCar["carNo"]}} is Parked at Parking Slot - #{searchCar["slotNo"]}\n\n")
            puts("Press 1 to unpark the car")
            puts("Press enter to return\n")
            choice = gets.chomp.to_i
            if (choice == 1)
              if (operation.unpark(searchCar))
                puts("\nUnparked your car !!!\n")
              else
                puts("\nSome Error Occured\n")
              end
            end
          else
            puts("\nCar Not Found !!!\n")
          end
        else
          puts("\nInvalid Car Number !!!\n")
        end
      end
    elsif (choice == 3)
      if invoiceManager.isEmpty?
        puts("No invoices to show")
      else
        invoices = invoiceManager.allInvoices
        invoice = 0
        puts("\n\n-----------------------------------------------------------------------")
        puts("ALL INOVICES")
        puts("-----------------------------------------------------------------------\n\n")
        puts("\tInvoice ID \t Duration \t Amount\n\n")
        while invoice < invoices.length
          puts("\t#{invoices[invoice]["invoiceId"]} \t\t #{invoices[invoice]["duration"]} \t\t #{invoices[invoice]["invoiceAmount"]}")
          invoice += 1
        end
        puts("\n-----------------------------------------------------------------------\n\n")
        puts("Press enter to continue!")
        STDIN.getch
      end
    elsif (choice == 4)
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
          puts("\tDuration:    #{invoice["duration"]}")
          puts("\tAmout:       #{invoice["invoiceAmount"]}")
          puts("\n-----------------------------------------------------------------------\n\n")
          puts("Press enter to continue!")
          STDIN.getch
        end
      end
    else
      if operation.isEmpty?
        puts("No Cars Parked !!!")
      else
        parkedCars = operation.allCars
        car = 0
        puts("\n\n-----------------------------------------------------------------------")
        puts("ALL PARKED CARS")
        puts("-----------------------------------------------------------------------\n\n")
        puts("\tParked Cars \t\t Slot No.\n\n")
        while car < parkedCars.length
          puts("\t#{parkedCars[car]["carNo"]} \t\t #{parkedCars[car]["slotNo"]}")
          car += 1
        end
        puts("\n-----------------------------------------------------------------------\n\n")
        puts("Press enter to continue!")
        STDIN.getch
      end
    end
  end
end
