require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../reception.rb')
require_relative('../bouncer.rb')

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

        @reception = Reception.new(@bouncer)

        @rooms = [@room1, @room2]
    end

    def test_enter_reception
        @reception.enter_reception(@customer_pat, @customer_phillipa, @customer_cat, @customer_steve, @customer_wilson, @customer_paul)
        assert_equal([@customer_pat, @customer_phillipa, @customer_cat, @customer_paul], @reception.waiting_customers)
    end
end