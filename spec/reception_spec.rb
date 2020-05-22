require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../customer.rb')
require_relative('../reception.rb')

class ReceptionTest < Minitest::Test

    def setup
        @reception = Reception.new()
    end

    def test_add_to_reception
        @reception.add(@customer_pat, @customer_pete, @customer_phil)
    end
end