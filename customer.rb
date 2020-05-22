class Customer

    attr_reader :name, :age, :alcohol_level, :wallet_balance, :tunefullness, :booking_name

    def initialize(name, age, alcohol_level, wallet_balance, tunefullness, booking_name)
        #Name, age, alcohol_level, wallet, tunefullness, booking_name
        @name = name
        @age = age
        @alcohol_level = alcohol_level
        @wallet_balance = wallet_balance
        @tunefullness = tunefullness
        @booking_name = booking_name
    end


    def reduce_wallet_balance(amount)
        @wallet_balance -= amount
    end
end