BOOKINGBUG_ROOT = Pathname.new(RAILS_ROOT).realpath.to_s

unless defined?(BBUG_CONFIG)
  BBUG_CONFIG = Bookingbug::Config.read_config("#{BOOKINGBUG_ROOT}/config/bookingbug.yml")
  BBUG_URL = Bookingbug::Config.set_bbug_path # BookingBug link for rendering a widget.
end

module Bookingbug
  
  attr_accessor :bbug_host
  
  # render smart widget
  def render_smart_widget(options = {})
    Bookingbug.set_bbug_host(request.host_with_port)
    SmartWidget.render(options)
  end
  
  # render event widget
  def render_event_widget(options = {})
    Bookingbug.set_bbug_host(request.host_with_port)
    EventWidget.render(options)
  end
  
  def set_bbug_host(host_address)
    Bookingbug::bbug_host = host_address
  end

end

include Bookingbug