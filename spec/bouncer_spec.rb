require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../reception.rb')
require_relative('../bouncer.rb')
require_relative('../song.rb')

class BouncerTest < Minitest::Test

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