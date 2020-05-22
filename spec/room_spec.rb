require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../reception.rb')
require_relative('../bouncer.rb')
require_relative('../room.rb')

class ReceptionTest < Minitest::Test

    def setup
        
                                  #Name, age, alcohol_level, wallet, tunefullness, booking_name
        @customer_pat = Customer.new("Pat", 19, 0, 1000, 1, "Pat")
        @customer_phillipa = Customer.new("Phillipa", 21, 3, 1500, 5, "Pat")
        @customer_cat = Customer.new("Cat", 18, 0, 900, 3, "Pat")
        @customer_steve = Customer.new("Steve", 80, 9, 30, 4, "Pat")
        @customer_wilson = Customer.new("Wilson", 12, 2, 350, 4, "Pat")
        @customer_paul = Customer.new("Paul", 19, 0, 1000, 4, "Colin")
        
        @bouncer = Bouncer.new()
        room1_properties= {capacity: 3, booking_name: "Pat", entry_fee: 5 }
        room2_properties= {capacity: 1, booking_name: "Lewis", entry_fee: 7 }
        @room1 = Room.new(room1_properties) 
        @room2 = Room.new(room2_properties) 
        @rooms = [@room1, @room2]
        @reception = Reception.new(@bouncer)

    end

    def test_get_capacity
        assert_equal( 3, @room1.capacity())
    end

    def test_get_number_of_customers_in_room
       # room.add_customers(errrrrrrrrr)
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

end