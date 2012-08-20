module ApplicationHelper
  def time_ago(from_time, to_time = Time.now)
    from_time = from_time.to_time
    to_time = to_time.to_time
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    distance_in_seconds = ((to_time - from_time).abs).round
    case distance_in_minutes
    when 0..1           then time = (distance_in_seconds < 60) ? "#{distance_in_seconds} seconds ago" : "1 #{t('timestamps.minute_ago')}"
    when 2..59          then time = "#{distance_in_minutes} minutes ago"
    when 60..90         then time = "1 hour ago"
    when 90..1440       then time = "#{(distance_in_minutes.to_f / 60.0).round} hours ago"
    when 1440..2160     then time = "1 day ago" # 1-1.5 days
    when 2160..2880     then time = "#{(distance_in_minutes.to_f / 1440.0).round} days ago" # 1.5-2 days
      #else time = from_time.strftime(t('date.formats.default'))
    end
    if distance_in_minutes > 2880
      distance_in_days = (distance_in_minutes/1440.0).round
      case distance_in_days
      when 0..30    then time = "#{distance_in_days} days ago"
      when 31..364  then time = "#{(distance_in_days.to_f / 30.0).round} months ago"
      else               time = "#{(distance_in_days.to_f / 365.24).round} years ago"
      end
    end

    return time
  end
  def full_names(patient)
    name1=nil
    names=nil
    fullnames=nil
    if patient
    name1=patient.surname.concat(" ").concat(patient.first_name) unless patient.given_name.nil?
    names =name1.concat(" ").concat(patient.given_name) unless patient.given_name.nil?
    fullnames=names
    patient=nil
    return fullnames.to_s
    else
      "None defined"
    end
  end
end
