module ApplicationHelper
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:time, l(time.to_date, :format => :long), options.merge(:datetime => time.getutc.iso8601)) if time
  end

  def cached_page?
    controller_name == 'home' && ['index', 'alphabetic'].include?(action_name)
  end
end
