module BookingBug
  
  class EventWidget < BookingBug::Widget
    
    attr_accessor :ref_id, :event_id
    
    def initialize(values = {})
      @event_id = values[:event_id].blank? ? Widget.get_event_id : values[:event_id]
      @ref_id = values[:ref_id].blank? ? Widget.get_ref_id : values[:ref_id]
      super(values)
    end
    
    def self.render(values = {})
      if BookingBug::Widget.validate_company
        event_widget = BookingBug::EventWidget.new(values)
        script = "<script type=\"text/javascript\" src=\"http://#{BBUG_URL}/widget/event"
        if !event_widget.ref_id.blank?
          script += event_widget.get_params_string(:comp_id => event_widget.company_id, :bgcol => event_widget.background_color, :scheme => event_widget.scheme, :style => event_widget.style, :resize => event_widget.host, :ref_id => event_widget.ref_id)
        else
          script += event_widget.get_params_string(:comp_id => event_widget.company_id, :bgcol => event_widget.background_color, :scheme => event_widget.scheme, :style => event_widget.style, :resize => event_widget.host, :event_id => event_widget.event_id)
        end
        script += "\">"
        script += "</script>"
        return script
      else
        return "<div style='border: 1px solid #AAAAAA; font-weight: bold; padding: 5px;'>Something went wrong. We are unable to render BookingBug widget. This is probably due to invalid or missing credentails.</div>"
      end
    end
    
  end
  
end