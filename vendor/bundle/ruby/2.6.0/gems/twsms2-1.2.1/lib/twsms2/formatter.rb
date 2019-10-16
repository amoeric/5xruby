module Twsms2
  module Formatter
    def match_string(rule, string)
      match_data = rule.match(string)
      match_data.nil? ? nil : match_data[1]
    end

    def format_time_string(time)
      return nil if time.nil?
      new_time = to_asia_taipei_timezone(time)
      new_time.strftime('%Y%m%d%H%M')
    end

    def to_asia_taipei_timezone(time)
      utc_time = time.utc? ? time.dup : time.dup.utc
      asia_taipei_time = utc_time.getlocal('+08:00')
      asia_taipei_time
    end

    def message_status_sanitize(original_text)
      new_text = case original_text
                 when 'DELIVRD'  then 'delivered'
                 when 'EXPIRED'  then 'expired'
                 when 'DELETED'  then 'deleted'
                 when 'UNDELIV'  then 'undelivered'
                 when 'ACCEPTD'  then 'transmitting'
                 when 'UNKNOWN'  then 'unknown'
                 when 'REJECTD'  then 'rejected'
                 when 'SYNTAXE'  then 'incorrect_sms_system_syntax'
                 when 'MOBERROR' then 'incorrect_phone_number'
                 when 'MSGERROR' then 'incorrect_content'
                 when 'OTHERROR' then 'sms_system_other_error'
                 when 'REJERROR' then 'illegal_content'
                 else 'status_undefined'
                 end

      new_text
    end

    def format_message_status(original_info)
      new_info = {
        access_success: false,
        is_delivered: false,
        message_status: nil,
        error: nil
      }

      code_text  = match_string(/<code>(?<code>\w+)<\/code>/, original_info)
      status_text = match_string(/<statustext>(?<status>\w+)<\/statustext>/, original_info)

      new_info[:access_success] = !code_text.nil? && !status_text.nil? && code_text == '00000'

      if new_info[:access_success]
        new_info[:message_status] = message_status_sanitize(status_text)
        new_info[:is_delivered]   = new_info[:message_status] == 'delivered'
      else
        new_info[:error] = code_text.nil? ? "TWSMS:CODE_NOT_FOUND" : "TWSMS:#{code_text}".upcase
      end

      new_info
    end

    def format_send_message_info(original_info)
      new_info = {
        access_success: false,
        message_id: nil,
        error: nil
      }

      code_text  = match_string(/<code>(?<code>\w+)<\/code>/, original_info)
      message_id_text = match_string(/<msgid>(?<message_id>\d+)<\/msgid>/, original_info)

      new_info[:access_success] = !code_text.nil? && !message_id_text.nil? && code_text == '00000'

      if new_info[:access_success]
        new_info[:message_id] = message_id_text
      else
        new_info[:error] = code_text.nil? ? "TWSMS:CODE_NOT_FOUND" : "TWSMS:#{code_text}".upcase
      end

      new_info
    end

    def format_balance_info(original_info)
      new_info = {
        access_success: false,
        message_quota: 0,
        error: nil
      }

      code_text  = match_string(/<code>(?<code>\w+)<\/code>/, original_info)
      point_text = match_string(/<point>(?<point>\d+)<\/point>/, original_info)

      new_info[:access_success] = !code_text.nil? && !point_text.nil? && code_text == '00000'

      if new_info[:access_success]
        new_info[:message_quota] = point_text.to_i
      else
        new_info[:error] = code_text.nil? ? "TWSMS:CODE_NOT_FOUND" : "TWSMS:#{code_text}".upcase
      end

      new_info
    end

  end
end