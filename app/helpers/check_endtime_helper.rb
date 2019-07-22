module CheckEndtimeHelper
  require 'date'
  def checkendtime(time)
    time < DateTime.now
  end
end
