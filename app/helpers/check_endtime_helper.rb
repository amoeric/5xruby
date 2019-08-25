module CheckEndtimeHelper
  def check_end_time(time)
    time < DateTime.now
  end
end
