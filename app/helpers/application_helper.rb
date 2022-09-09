module ApplicationHelper
  def fa_icon(name, type: 'solid')
    "<i class='fa-#{type} fa-#{name}'></i>".html_safe
  end

  def time_range(start_time, duration: Meeting::DURATION)
    end_time = start_time + duration

    "#{fa_icon("clock", type: "regular")} #{start_time.strftime("%H:%M")} ~ #{end_time.strftime("%H:%M")}".html_safe
  end

  def calendar_card_klass(status)
    # Reference: bootstrap card styles https://getbootstrap.com/docs/5.2/components/card/#card-styles
    case status.to_s
    when "not_open"
      "text-dark bg-light"
    when 'open'
      "border-info"
    when 'booked'
      "border-success"
    when 'cancelled'
      "border-warning"
    end
  end

  def meeting_status_label(status)
    # Reference: bootstrap badge styles https://getbootstrap.com/docs/5.2/components/badge/#background-colors
    label_klass = case status.to_s
                  when 'not_open'
                    "bg-secondary"
                  when 'open'
                    "bg-info"
                  when 'booked'
                    "bg-success"
                  when 'cancelled'
                    "bg-warning"
                  end

    content_tag :span, status.titleize, class: "badge rounded-pill #{label_klass}"
  end
end
