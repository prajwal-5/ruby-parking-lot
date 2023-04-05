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
    amount = (duration > 60) ? 500 : (duration > 30) ? 300 : (duration > 10) ? 200 : 100
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
