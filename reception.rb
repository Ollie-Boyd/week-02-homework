class Reception

    attr_reader :waiting_customers 

    def initialize( bouncer)
        @waiting_customers = []
        @bouncer = bouncer
    end

    def enter_reception( *people )
        @waiting_customers, rejected = people.partition{ |person| @bouncer.customer_acceptable(person) }  
        @bouncer.bounce(rejected)    
    end

end