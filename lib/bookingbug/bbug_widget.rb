module BookingBug
  class Widget
    attr_accessor :scheme, :style, :background_color, :company_id, :host
    
    def initialize(values)
      if !values.blank?
        @style = values[:style].blank? ? Widget.get_style : values[:style]
        @scheme = values[:scheme].blank? ? Widget.get_scheme : values[:scheme]
        @background_color = values[:background_color].blank? ? Widget.get_bg_color : values[:background_color]
        @company_id = Widget.get_company_id
        @host = Widget.get_host
      elsif !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank?
        @style = BBUG_CONFIG[:bookingbug][:style].blank? ? "basic" : BBUG_CONFIG[:bookingbug][:style]
        @scheme = BBUG_CONFIG[:bookingbug][:scheme].blank? ? 1 : BBUG_CONFIG[:bookingbug][:scheme]
        @background_color = BBUG_CONFIG[:bookingbug][:background_color].blank? ? "FFF" : BBUG_CONFIG[:bookingbug][:background_color]
        @company_id = BBUG_CONFIG[:bookingbug][:company_id]
        @host = Widget.get_host
      else
        @style = "basic"
        @scheme = 1
        @background_color = "FFFFFF"
        @host = Widget.get_host
      end
    end
    
    def self.validate_company
      !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? && !BBUG_CONFIG[:bookingbug][:company_id].blank? ? true : false
    end
    
    def self.validate_ref_no
      !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? && !BBUG_CONFIG[:bookingbug][:ref_id].blank? ? true : false
    end
    
    def self.validate_event
      !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? && !BBUG_CONFIG[:bookingbug][:event_id].blank? ? true : false
    end
    
    def self.get_scheme
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? && !BBUG_CONFIG[:bookingbug][:scheme].blank? ? BBUG_CONFIG[:bookingbug][:scheme] : 1
    end
    
    def self.get_style
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? && !BBUG_CONFIG[:bookingbug][:style].blank? ? BBUG_CONFIG[:bookingbug][:style] : "basic"
    end
    
    def self.get_bg_color
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? && !BBUG_CONFIG[:bookingbug][:background_color].blank? ? BBUG_CONFIG[:bookingbug][:background_color] : "FFFFFF"
    end
    
    def self.get_company_id
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:company_id] : nil
    end
    
    def self.get_host
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? (BBUG_CONFIG[:bookingbug][:host].to_s + "/resize.html") : nil
    end
    
    def self.get_event_id
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:event_id] : nil
    end
    
    def self.get_ref_id
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:ref_id] : nil
    end
    
    def get_params_string(values= {})
      params = ""
      count = 0
      values.each do |value|
        count == 0 ? (params = "?#{value[0]}=#{value[1]}") : (params += "&#{value[0]}=#{value[1]}")
        count += 1
      end
      return params
    end
    
    def show_error
      return "<div style='border: 1px solid #AAAAAA; font-weight: bold; padding: 5px;'>Something went wrong. We are unable to render BookingBug widget. This is probably due to invalid or missing credentails.</div>"
    end
    
  end
  
end

