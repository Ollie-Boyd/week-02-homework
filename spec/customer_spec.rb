require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../song.rb')
require_relative('../room.rb')
require_relative('../bouncer.rb')
require_relative('../reception.rb')


class CustomerTest < Minitest::Test

    def setup

        @hit_me_baby = Song.new("Britney Spears", "Baby One More Time")
        @country_roads = Song.new("John Denver", "Take Me Home, Country Roads")
        @believin = Song.new("Journey", "Don't Stop Believin'")

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
        @reception = Reception.new(@bouncer, @rooms, 1000)
        
        
    end

    
    
    def test_get_customer_name
        assert_equal("Cat", @customer_cat.name)
    end

    def test_get_customer_age
        assert_equal(18, @customer_cat.age)
    end

    def test_get_customer_alcohol_level
        assert_equal(0, @customer_cat.alcohol_level)
    end

    def test_get_customer_wallet_balance
        assert_equal(900, @customer_cat.wallet_balance)
    end

    def test_get_customer_tunefullness
        assert_equal(3, @customer_cat.tunefullness)
    end

    def test_get_customer_booking_name
        assert_equal("Pat", @customer_cat.booking_name)
    end

    def test_reduce_customer_wallet_balance
        assert_equal(0, @customer_cat.reduce_wallet_balance(@customer_cat.wallet_balance))
    end

    def test_sing__fav_song
        @reception.enter_reception(@customer_phillipa, @customer_cat)
        @reception.allocate_customers_to_rooms()
        @room1.load_songs(@hit_me_baby)
        potential_exclamation=@customer_cat.sing_song
        assert_equal("Yaldi!!!", potential_exclamation )
    end

    def test_sing__not_fav_song
        @reception.enter_reception(@customer_phillipa, @customer_cat)
        @reception.allocate_customers_to_rooms()
        @room1.load_songs(@country_roads)
        potential_exclamation=@customer_cat.sing_song
        assert_nil(potential_exclamation)
    end

    def test_react_to_performance
        assert_equal("Ya wee dancer!", @customer_cat.react_to_performance(4))
    end

    def test_leave_karaoke
        @reception.enter_reception(@customer_phillipa, @customer_cat, @customer_pat)
        @reception.allocate_customers_to_rooms()
        @customer_cat.leave_karaoke()
        assert_equal([@customer_phillipa, @customer_pat], @room1.customers_in_room)
    end
end