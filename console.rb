require_relative "car"
require_relative "parkingLot"
require_relative "invoiceManager"

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
        return @choice
    end

    def isValid(choice)
        if choice < 1 || choice > 6
            puts("Please choose a valid Option!!")
            return nil
        end
        return choice
    end

    def choice
        return @choice
    end

    def getDetails
        puts("Enter the Car's Registration Number: ")
        carNo = gets.chomp
        return carNo
    end

    def controller(choice)
        operation = ParkingLot.new
        invoiceManager = InvoiceManager.new

        if(choice == 1)
            if(operation.isFull)
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
        elsif(choice == 2)
            if(operation.isEmpty)
                puts("Parking lot is Empty !!!")
            else
                carNo = getDetails
                car = Car.new(carNo)
                if car.isValid(carNo)
                    searchCar = operation.findCar(carNo)
                    if(searchCar != false)
                        parkedCars = operation.allCars
                        puts("\n\nCAR FOUND !!!")
                        puts("\nYour Car {#{parkedCars[searchCar]["carNo"]}} is Parked at Parking Slot - #{parkedCars[searchCar]["slotNo"]}\n\n")
                        puts("Press 1 to unpark the car")
                        puts("Press any other key to return\n")
                        choice = gets.chomp.to_i
                        if(choice == 1) 
                            if(operation.unpark(searchCar))
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
        elsif(choice == 3)
            if invoiceManager.isEmpty
                puts("No invoices to show")
            else
                invoices = invoiceManager.allInvoices
                invoice = 0
                puts("\n\n-----------------------------------------------------------------------")
                puts("ALL INOVICES")
                puts("-----------------------------------------------------------------------\n\n")
                puts("\tInvoice ID \t\t Duration \t Amount\n\n")
                while invoice < invoices.length
                    puts("\t#{invoices[invoice]["invoiceId"]} \t\t #{invoices[invoice]["duration"]} \t\t #{invoices[invoice]["invoiceAmount"]}")
                    invoice += 1
                end
                puts("\n-----------------------------------------------------------------------\n\n")
                puts("Press any key to continue!")
                STDIN.getch
            end
        elsif(choice == 4)
            if(invoiceManager.isEmpty)
                puts("No Invoices Generated !!!")
            else
                puts("Enter Invoice ID: ")
                invoiceID = gets.chomp
                invoice = invoiceManager.findInvoice(invoiceID)
                if(invoice == false) 
                    puts("No invoice Found")
                else
                    invoices = invoiceManager.allInvoices
                    puts("\n\n-----------------------------------------------------------------------")
                    puts("INVOICE DETAILS")
                    puts("-----------------------------------------------------------------------\n\n")
                    puts("\tInvoiceID:   #{invoices[invoice]["invoiceId"]}")
                    puts("\tCar No.:     #{invoices[invoice]["carNo"]}")
                    puts("\tEntry Time:  #{invoices[invoice]["entryTime"]}")
                    puts("\tExit Time:   #{invoices[invoice]["exitTime"]}")
                    puts("\tDuration:    #{invoices[invoice]["duration"]}")
                    puts("\tAmout:       #{invoices[invoice]["invoiceAmount"]}")
                    puts("\n-----------------------------------------------------------------------\n\n")
                    puts("Press any key to continue!")
                    STDIN.getch
                end
            end
        else
            if operation.isEmpty
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
                puts("Press any key to continue!")
                STDIN.getch
            end
        end
    end
end
