require "spec_helper"
require_relative "../car"
require_relative "../slot"
require_relative "../invoice"
require_relative "../invoice_manager"

describe("Checking Invoice Manager's") do
  before(:all) do
    @invoiceManager = InvoiceManager.new()
    @allInvoices = @invoiceManager.allInvoices
    @initialInvoices = @allInvoices.length
  end

  before(:each) do
    @car = Car.new("KA10101010")
    @slot = Slot.new(9, @car)
    @invoiceManager.generateInvoice(@slot.getSlot)
  end

  it("invoice generating service") do
    expect(@invoiceManager.findInvoice(@allInvoices.length - 1)).not_to eql false
  end

  it("delete invoice service") do
    @invoiceManager.deleteInvoice(@invoiceManager.findInvoice(@allInvoices.length - 1))
    expect(@invoiceManager.findInvoice(@allInvoices.length - 1)).to eql false
  end

  it("find invoice by invoice ID service") do
    expect(@invoiceManager.findInvoice(@allInvoices.length - 1)).not_to eql false
  end

  after(:each) do
    @allInvoices = @invoiceManager.allInvoices
    while (@allInvoices.length > @initialInvoices)
      @invoiceManager.deleteInvoice(@invoiceManager.findInvoice(@allInvoices.length - 1))
      @allInvoices = @invoiceManager.allInvoices
    end
  end

  after(:all) do
    if @initialInvoices == 0
      File.delete("invoice.json")
    end
  end
end
