class Room
    attr_reader :capacity, :booking_name, :entry_fee, :customers_in_room, :songs

  
    def initialize(room_attributes)
        room_attributes.each {|key, value| instance_variable_set("@#{key}", value) }
        @customers_in_room = []
        @songs = []
    end

    def number_in_room
        return @customers_in_room.count
    end

    def load_songs(*new_songs)
        @songs += new_songs
    end

    def add_customers(new_customers)
        @customers_in_room += new_customers
    end

    def play_song
        number_of_songs= @songs.length
        track_number = rand(number_of_songs)
        return @songs[track_number]
    end
   
    def group_reaction(singer)
        tunefullness = singer.tunefullness
        customers_who_are_not_singer = @customers_in_room.select{ |customer| customer != singer }
        reactions_from_group = customers_who_are_not_singer.map { |customer| customer.react_to_performance(tunefullness) }
        return reactions_from_group
    end

    def customer_leave(customer_who_wants_to_go)
        @customers_in_room.delete(customer_who_wants_to_go)
    end

  end
  