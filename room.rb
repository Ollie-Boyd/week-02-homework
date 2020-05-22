class Room
    attr_accessor :capacity, :booking_name, :entry_fee, :customers_in_room
    attr_writer :customers_in_room
  
    def initialize(room_attributes)
        room_attributes.each {|key, value| self.send(("#{key}="), value)}
        @customers_in_room = []
    end

    def number_in_room
        return @customers_in_room.count
    end
  end
  