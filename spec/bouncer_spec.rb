require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../reception.rb')
require_relative('../bouncer.rb')

class BouncerTest < Minitest::Test

    def setup
                            #Name, age, alcohol_level, wallet_balance, tunefullness, booking_name
        @customer_pat = Customer.new("Pat", 19, 0, 1000, 1, "Pat")
        @customer_phillipa = Customer.new("Phillipa", 21, 3, 1500, 5, "Pat")
        @customer_cat = Customer.new("Cat", 18, 0, 900, 3, "Pat")
        @customer_steve = Customer.new("Steve", 80, 9, 30, 4, "Pat")
        @customer_wilson = Customer.new("Wilson", 12, 2, 350, 4, "Pat")
        @customer_paul = Customer.new("Paul", 19, 0, 1000, 4, "Colin")

        @rejected= [@customer_wilson, @customer_steve]

        @bouncer = Bouncer.new()
    end
    #we can pass an array to bounce and the bouncer will bounce everyone in the array or we can pass an array and an optional customer's name and it will bounce only that person from the array 
    def test_bounce__one_customer
        
        @bouncer.bounce(@rejected, @customer_wilson)
        assert_equal([@customer_steve], @rejected)
    end

    def test_bounce__whole_array
        
        @bouncer.bounce(@rejected)
        assert_equal([], @rejected)
    end

    def test_take_money
        
        @bouncer.bounce(@rejected, @customer_wilson)
        assert_equal(350, @bouncer.evenings_tips)
    end

    def test_customer_decent__too_young
        assert_equal(false, @bouncer.customer_acceptable(@customer_wilson))
    end

    def test_customer_decent__too_drunk
        assert_equal(false, @bouncer.customer_acceptable(@customer_steve))
    end

    def test_customer_decent__ok
        assert_equal(true, @bouncer.customer_acceptable(@customer_pat))
    end


end