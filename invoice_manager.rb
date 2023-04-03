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

  def generateInvoice(car)
    invoice = Invoice.new(car, @invoices.length)
    File.delete(@file)
    @file = File.open("invoice.json", "a+")
    @invoices.push(invoice.getInvoice)
    @file.write(@invoices.to_json)
    @file.close
  end

  def allInvoices
    @invoices
  end

  def findInvoice(invoiceID)
    @invoices.find { |invoice| invoice["invoiceId"] == invoiceID.to_i } || false
  end
end
