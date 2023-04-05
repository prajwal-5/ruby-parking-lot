require_relative "invoice"
require "json"

class InvoiceManager
  def initialize
    @file = File.open("invoice.json", "a+")
    @invoices = JSON.load(@file) || []
  end

  def isEmpty?
    @invoices.empty?
  end

  def updateFile(fileName, data)
    @file.close
    @file = File.open(fileName, "w+")
    @file.write(data.to_json)
    @file.close
  end

  def generateInvoice(slot)
    invoice = Invoice.new(slot, @invoices.length)
    @invoices.push(invoice.getInvoice)
    updateFile("invoice.json", @invoices)
  end

  def allInvoices
    @invoices
  end

  def findInvoice(invoiceID)
    @invoices.find { |invoice| invoice["invoiceId"] == invoiceID.to_i } || false
  end

  def deleteInvoice(delInvoice)
    @invoices = @invoices.find_all { |invoice| invoice != delInvoice }
    updateFile("invoice.json", @invoices)
    true
  end
end
