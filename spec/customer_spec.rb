require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')

class CustomerTest < Minitest::Test

    def setup
                            #Name, age, alcohol_level, wallet, tunefullness, booking_name
        @customer_pat = Customer.new("Pat", 19, 0, 1000, 1, "Pat")
        @customer_phillipa = Customer.new("Phillipa", 21, 3, 1500, 5, "Pat")
        @customer_cat = Customer.new("Cat", 18, 0, 900, 3, "Pat")
        @customer_steve = Customer.new("Steve", 19, 9, 30, 4, "Pat")
        @customer_paul = Customer.new("Paul", 19, 0, 1000, 4, "Colin")
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
end