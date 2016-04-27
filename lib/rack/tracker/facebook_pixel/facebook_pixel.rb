class Rack::Tracker::FacebookPixel < Rack::Tracker::Handler
  class Event < OpenStruct
    def write
      ['track', event, to_h.except(:event).compact].map(&:to_json).join(', ')
    end
  end
  
  class EventCustom < OpenStruct
    def write
      ['trackCustom', event, to_h.except(:event).compact].map(&:to_json).join(', ')
    end
  end

  self.position = :body

  def render
    Tilt.new( File.join( File.dirname(__FILE__), 'template/facebook_pixel.erb') ).render(self)
  end

  def self.track(name, *event)
    { name.to_s => [event.last.merge('class_name' => 'Event')] }
  end
  
  def self.track_custom(name, *event)
    { name.to_s => [event.last.merge('class_name' => 'EventCustom')] }
  end
end
