module Bookingbug
  
  class Config
    def self.read_config(config_file)
      config = YAML.load(ERB.new(IO.read(config_file)).result)
      config
    end
    
    def self.set_bbug_path
      !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? && !BBUG_CONFIG[:bookingbug][:site].blank? && validate_site ? BBUG_CONFIG[:bookingbug][:site].to_s + ".bookingbug.com" : "www.bookingbug.com"
    end
    
    def self.validate_site
      BBUG_CONFIG[:bookingbug][:site].to_s == "www" || BBUG_CONFIG[:bookingbug][:site].to_s == "uk" || BBUG_CONFIG[:bookingbug][:site].to_s == "us" ? (return true) : (return false)
    end    
  end
  
end

