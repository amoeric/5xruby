module CheckEndtimeHelper
  def checkendtime(time)
    time < DateTime.now
  end
end
