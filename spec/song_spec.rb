require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../song.rb')

class BusStopTest < Minitest::Test

    def setup
        @hit_me_baby = Song.new("Britney Spears", "Baby One More Time")
        @country_roads = Song.new("John Denver", "Take Me Home, Country Roads")
        @believin = Song.new("Journey", "Don't Stop Believin'")
    end

    def test_get_artist
        assert_equal("Journey", @song.artist)
    end
end