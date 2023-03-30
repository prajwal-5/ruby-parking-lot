require_relative "invoice"
require "json"

class InvoiceManager
    def initialize
        @file = File.open("invoice.json", "a+")
        @invoices = JSON.load(@file) || []
    end

    def isEmpty
        return @invoices.length == 0
    end

    def generateInvoice(parkedCars, car)
        invoice = Invoice.new(parkedCars, car) 
        File.delete(@file)
        @file = File.open("invoice.json", "a+")
        @invoices.push(invoice.getInvoice)
        @file.write(@invoices.to_json)
        @file.close
    end

    def allInvoices
        return @invoices
    end

    def findInvoice(invoiceID)
        invoice = 0
        while invoice < @invoices.length
            if invoiceID == @invoices[invoice][:invoiceId]
               return invoice
            end
            invoice += 1
        end
        return false
    end
end