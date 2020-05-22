class Bouncer

    attr_reader :evenings_tips

    def initialize(evenings_tips = 0)
        @evenings_tips = evenings_tips
    end

    def take_cash(customer)
        @evenings_tips += customer.wallet_balance
        customer.reduce_wallet_balance(customer.wallet_balance)
    end
    # will bounce a group by default but you can (optionally) specify a specific customer to bounce. 
    def bounce(customers_array, specific_customer= false)
        if specific_customer 
            take_cash(specific_customer)
            customers_array.delete_if{ |customer| customer == specific_customer}
        else
            customers_array.each{ |customer| take_cash(customer)}
            customers_array.clear
        end
    end

    def customer_acceptable(customer)
        customer.age >=18 && customer.alcohol_level <= 8
    end
end