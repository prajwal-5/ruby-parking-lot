require "date"

class Invoice
    def initialize(parkedCars, car)
        @carNo = parkedCars[car][:carNo]
        @entryTime = parkedCars[car][:entryTime]
        @exitTime = DateTime.now
        @duration = calcDuration(@entryTime)
        @invoiceAmount = calcAmount(@duration)
        @invoiceId = calcInvoiceId(@carNo, @entryTime)
    end

    def calcInvoiceId(carNo, entryTime)
        entryTime = entryTime.to_datetime
        day = entryTime.day.to_s
        hour = entryTime.hour.to_s
        min = entryTime.min.to_s
        sec = entryTime.sec.to_s
        return day + hour + min + sec 
    end

    def calcDuration(entryTime)
        return ((DateTime.now - entryTime.to_datetime) * 24 * 60 * 60).to_i
    end

    def calcAmount(duration)
        amount = 0
        if duration > 60 
            amount = 500
        elsif duration > 30
            amount = 300
        elsif duration > 10
            amount = 200
        else
            amount = 100
        end
        return amount
    end

    def getInvoice
        invoice = {
            :invoiceId => @invoiceId,
            :carNo => @carNo,
            :entryTime => @entryTime,
            :exitTime => @exitTime,
            :duration => @duration,
            :invoiceAmount => @invoiceAmount
        }
        return invoice
    end
end