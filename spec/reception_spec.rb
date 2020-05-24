require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../reception.rb')
require_relative('../bouncer.rb')
require_relative('../room.rb')

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

        @reception = Reception.new(@bouncer, @rooms, 1000)

    end



    def test_get_till_balance
        assert_equal(1000, @reception.till_balance)
    end

    def test_check_available_room_capacity
        assert_equal(3, @reception.check_available_room_capacity(@room1))
    end

    def test_customer_can_afford__false
        entry_fee = @room2.entry_fee
        assert_equal(false, @reception.customer_can_afford?(@customer_steve, entry_fee))
    end

    def test_customer_can_afford__true
        entry_fee = @room2.entry_fee
        assert_equal(true, @reception.customer_can_afford?(@customer_pat, entry_fee))
    end

    def test_increase_till_balance
        @reception.increase_till_balance(30)
        assert_equal(1030, @reception.till_balance)
    end

    def test_take_group_payment
        customers = [@customer_phillipa, @customer_cat]
        entry_fee = @room1.entry_fee
        @reception.take_group_payment(customers, entry_fee)
        assert_equal(@reception.till_balance, 1010)
        assert_equal(@customer_phillipa.wallet_balance, 1495)
    end

    def test_group_customers_by_booking_name
        customers= [@customer_phillipa, @customer_cat, @customer_paul]
        grouped = @reception.group_customers_by_booking_name(customers)
        assert_equal( {"Pat" => [@customer_phillipa, @customer_cat], "Colin" => [@customer_paul]}, grouped)
    end

    def test_add_new_customers_to_waiting_customers
        @reception.enter_reception(@customer_phillipa, @customer_cat)
        current_customers= @reception.waiting_customers
        new_customers = @reception.group_customers_by_booking_name([@customer_pat, @customer_paul])
        @reception.add_new_customers_to_waiting_customers(new_customers)

        assert_equal({"Pat" => [@customer_phillipa, @customer_cat, @customer_pat], "Colin" => [@customer_paul]}, @reception.waiting_customers)
    end

    def test_enter_reception_filter
        @reception.enter_reception(@customer_pat, @customer_cat, @customer_steve)
        assert_equal({"Pat" => [@customer_pat, @customer_cat]}, @reception.waiting_customers)
    end

    def test_customers_for_specified_room
        @reception.enter_reception(@customer_phillipa, @customer_cat, @customer_paul)
        room_custs = @reception.get_customers_for_room_by_booking_name("Colin")
        assert_equal([@customer_paul], room_custs)
    end

    def test_only_customers_who_will_fit_in_room
        @reception.enter_reception(@customer_pat, @customer_phillipa, @customer_cat, @customer_paul)
        room_custs = @reception.get_customers_for_room_by_booking_name("Pat")
        fit = @reception.only_customers_who_will_fit_in_room(room_custs, 2, "Pat")
        assert_equal([@customer_pat, @customer_phillipa], fit)
        assert_equal([@customer_cat], @reception.waiting_customers["Pat"])
    end

    def test_reject_customers_without_enough_money
        customers = [@customer_steve, @customer_pat, @customer_cat]
         customers
        not_broke = @reception.reject_customers_without_enough_money(customers, 90)
        assert_equal([@customer_pat, @customer_cat], not_broke)
    end

    def test_allocate_customers_to_rooms
        @reception.enter_reception(@customer_pat, @customer_cat, @customer_steve)
        @reception.allocate_customers_to_rooms
    end
        
end