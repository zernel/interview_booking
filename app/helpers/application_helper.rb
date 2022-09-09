module ApplicationHelper
  def fa_icon(name, type: 'solid')
    "<i class='fa-#{type} fa-#{name}'></i>".html_safe
  end
end
