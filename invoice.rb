require "date"

class Invoice
  def initialize(slot, invoiceId)
    @carNo = slot["carNo"]
    @entryTime = slot["entryTime"]
    @exitTime = DateTime.now
    @duration = calcDuration(@entryTime)
    @invoiceAmount = calcAmount(@duration)
    @invoiceId = invoiceId
  end

  def checkParse(entryTime)
    if entryTime.class == String
      entryTime = DateTime.parse(entryTime)
    end
    entryTime
  end

  def calcDuration(entryTime)
    convertToSeconds = 24 * 60 * 60
    ((DateTime.now - checkParse(entryTime)) * convertToSeconds).to_i
  end

  def calcAmount(duration)
    priceChart = {
      0..10 => 100,
      10..30 => 200,
      30..60 => 300,
      60..nil => 500,
    }
    priceChart.select { |time| time === duration }.values.first
  end

  def getInvoice
    {
      "invoiceId" => @invoiceId,
      "carNo" => @carNo,
      "entryTime" => @entryTime,
      "exitTime" => @exitTime,
      "duration" => @duration,
      "invoiceAmount" => @invoiceAmount,
    }
  end
end
