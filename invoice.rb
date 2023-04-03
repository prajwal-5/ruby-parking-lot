require "date"

class Invoice
  def initialize(car, invoiceId)
    @carNo = car["carNo"]
    @entryTime = car["entryTime"]
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
    amount
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
