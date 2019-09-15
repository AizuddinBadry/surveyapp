module NotificationHelper
    def alert
      content = ""
      li_content = ''
      flash.each do |key, value|
        value.each do |k, v|
          li_content << "<span>#{k} : #{v[0]}<span></br>"
        end unless value.respond_to?(:to_str)
        content << "<div class='alert alert-#{key}'>#{li_content.size < 1 ? '<span>' + value + '</span>' : li_content}</div>"
      end
      content.html_safe
    end
  end
  