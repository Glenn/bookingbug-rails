# Bookingbug

BBUG_URL = "localhost:3000"

BOOKINGBUG_ROOT = Pathname.new(RAILS_ROOT).realpath.to_s
require "bookingbug/bbug_config"
require "bookingbug/bbug_widget"
require "bookingbug/bbug_smart_widget"
require "bookingbug/bbug_event_widget"

unless defined?(BBUG_CONFIG)
  BBUG_CONFIG = BookingBug::Config.read_config("#{BOOKINGBUG_ROOT}/config/bookingbug.yml")
end