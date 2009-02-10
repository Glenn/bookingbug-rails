module BookingBug
  class Widget
    
    attr_accessor :scheme, :style, :background_color, :company_id, :event_id, :ref_id
    
    def initialize(values)
      if !values.blank?
        @style = values[:style].blank? ? Widget.get_style : values[:style]
        @scheme = values[:scheme].blank? ? Widget.get_scheme : values[:scheme]
        @background_color = values[:background_color].blank? ? Widget.get_bg_color : values[:background_color]
        @company_id = Widget.get_company_id
        @event_id = values[:event_id].blank? ? Widget.get_event_id : values[:event_id]
        @ref_id = values[:ref_id].blank? ? Widget.get_ref_id : values[:ref_id]
      elsif !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank?
        @style = BBUG_CONFIG[:bookingbug][:style]
        @scheme = BBUG_CONFIG[:bookingbug][:scheme]
        @background_color = BBUG_CONFIG[:bookingbug][:background_color]
        @company_id = BBUG_CONFIG[:bookingbug][:company_id]
        @event_id = BBUG_CONFIG[:bookingbug][:event_id]
        @ref_id = BBUG_CONFIG[:bookingbug][:ref_id]
      else
        @style = "basic"
        @scheme = 1
        @background_color = "FFFFFF"
      end
    end
    
    def self.bookingbug_widget(values = {})
      if BookingBug::Widget.validate_company
        widget = BookingBug::Widget.new(values)
        if BookingBug::Widget.validate_event || BookingBug::Widget.validate_ref_no
          script = "<script type=\"text/javascript\" src=\"http://#{BBUG_URL}/widget/event"
          script += "?comp_id=#{widget.company_id}"
        else
          script = "<script type=\"text/javascript\" src=\"http://#{BBUG_URL}/widget/all"
          script += "?id=#{widget.company_id}"
        end
        script += "&event_id=#{widget.event_id}"
        script += "&ref_id=#{widget.ref_id}"
        script += "&bgcol=#{widget.background_color}"
        script += "&scheme=#{widget.scheme}"
        script += "&resize=http://localhost:3001/resize.html"
        script += "&style=#{widget.style} \">"
        script += "</script>"
        return script
      else
        return "<div style='border: 1px solid #AAAAAA; font-weight: bold; padding: 5px;'>Something went wrong. This is probably due to invalid credentails.</div>"
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
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:scheme] : 1
    end
    
    def self.get_style
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:style] : "basic"
    end
    
    def self.get_bg_color
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:background_color] : "FFFFFF"
    end
    
    def self.get_company_id
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:company_id] : nil
    end
    
    def self.get_event_id
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:event_id] : nil
    end
    
    def self.get_ref_id
      return !BBUG_CONFIG.blank? && !BBUG_CONFIG[:bookingbug].blank? ? BBUG_CONFIG[:bookingbug][:ref_id] : nil
    end
  end
end

