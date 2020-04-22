module ApplicationHelper

  def flash_style_type(key)
    case key
    when "notice"
      "info"
    when "alert"
      "danger"
    else
      "light"
    end
  end

end
