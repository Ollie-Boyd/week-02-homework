class Customer

    attr_reader :name, :age, :alcohol_level, :wallet_balance, :tunefullness, :booking_name, :fav_song, :room

    attr_writer :room

    #everyone reacts the same, I ran out of time to write multiple reactions per customer.   
    @@reactions = {1 => "get awa wi yi!", 2 => "ma poor wee lugs", 3 => "aww yer geein it yer best love!", 4 => "Ya wee dancer!", 5 => "Pya belter!!"} 


    def initialize(customer_attributes)
        customer_attributes.each {|key, value| instance_variable_set("@#{key}", value) }
        @room 
    end

    def reduce_wallet_balance(amount)
        @wallet_balance -= amount
    end

    def sing_song()
        song = @room.play_song
        group_reaction = @room.group_reaction(self)
        p group_reaction
        return "Yaldi!!!" if song == @fav_song
        
    end
    
    def react_to_performance(tunefullness)
        return @@reactions[tunefullness]
    end

    def leave_karaoke()
        @room.customer_leave(self)
    end
end