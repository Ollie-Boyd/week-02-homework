require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../reception.rb')
require_relative('../bouncer.rb')
require_relative('../room.rb')
require_relative('../song.rb')


class ReceptionTest < Minitest::Test

    def setup
        customer_pat_properties = {name: "Pat", age: 19, alcohol_level: 0, wallet_balance: 1000, tunefullness: 1, booking_name: "Pat", fav_song: @believin}
        customer_phillipa_properties = {name: "Phillipa", age: 21, alcohol_level: 3, wallet_balance: 1500, tunefullness: 5, booking_name: "Pat", fav_song: @country_roads}
        customer_cat_properties = {name: "Cat", age: 18, alcohol_level: 0, wallet_balance: 900, tunefullness: 3, booking_name: "Pat", fav_song: @hit_me_baby}
        customer_steve_properties = {name: "Steve", age: 19, alcohol_level: 9, wallet_balance: 30, tunefullness: 4, booking_name: "Pat", fav_song: @country_roads}
        customer_paul_properties = {name: "Paul", age: 19, alcohol_level: 0, wallet_balance: 1000, tunefullness: 4, booking_name: "Colin", fav_song: @country_roads}
        customer_wilson_properties = {name: "Wilson", age: 12, alcohol_level: 2, wallet_balance: 350, tunefullness: 4, booking_name: "Pat", fav_song: @hit_me_baby}
                            
        @customer_pat = Customer.new(customer_pat_properties)
        @customer_phillipa = Customer.new(customer_phillipa_properties)
        @customer_cat = Customer.new(customer_cat_properties)
        @customer_steve = Customer.new(customer_steve_properties)
        @customer_paul = Customer.new(customer_paul_properties)
        @customer_wilson = Customer.new(customer_wilson_properties)
        
        @bouncer = Bouncer.new()

        room1_properties= {capacity: 3, booking_name: "Pat", entry_fee: 5 }
        room2_properties= {capacity: 1, booking_name: "Lewis", entry_fee: 60 }
        @room1 = Room.new(room1_properties) 
        @room2 = Room.new(room2_properties) 
        @rooms = [@room1, @room2]
       

        @hit_me_baby = Song.new("Britney Spears", "Baby One More Time")
        @country_roads = Song.new("John Denver", "Take Me Home, Country Roads")
        @believin = Song.new("Journey", "Don't Stop Believin'")

        @reception = Reception.new(@bouncer, @rooms, 1000)

    end

    def test_get_capacity
        assert_equal( 3, @room1.capacity())
    end

    def test_get_number_of_customers_in_room
        assert_equal( 0, @room1.number_in_room)
    end

    def test_get_booking_name
        assert_equal( "Pat", @room1.booking_name)
    end

    def test_get_room_entry_fee
        assert_equal( 5, @room1.entry_fee)
    end

    def test_get_customers_in_room
        assert_equal( [], @room1.customers_in_room)
    end

    def test_add_songs_to_room
        @room1.load_songs(@hit_me_baby, @country_roads, @believin)
        assert_equal( [@hit_me_baby, @country_roads, @believin], @room1.songs)
    end

    def test_play_song
        @room1.load_songs(@hit_me_baby, @country_roads, @believin)
        @room1.play_song()
    end

    def test_get_group_reaction
        @reception.enter_reception(@customer_phillipa, @customer_cat, @customer_pat)
        @reception.allocate_customers_to_rooms()
        @room1.load_songs(@country_roads)
        reaction = @room1.group_reaction(@customer_cat)
        assert_equal(["aww yer geein it yer best love!", "aww yer geein it yer best love!"], reaction)
    end

    def test_leave_karaoke
        @reception.enter_reception(@customer_phillipa, @customer_cat, @customer_pat)
        @reception.allocate_customers_to_rooms()
        @room1.customer_leave(@customer_cat)
        assert_equal([@customer_phillipa, @customer_pat], @room1.customers_in_room)
    end
end