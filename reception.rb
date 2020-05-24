class Reception

    attr_reader :waiting_customers, :till_balance 

    def initialize( bouncer, rooms, till_balance)
        @waiting_customers = {}
        @bouncer = bouncer
        @rooms = rooms
        @till_balance = till_balance
    end
    
    def enter_reception( *people )
        accepted, rejected = people.partition{ |person| @bouncer.customer_acceptable(person) }  
        @bouncer.bounce(rejected)
        grouped = group_customers_by_booking_name(accepted)
        add_new_customers_to_waiting_customers(grouped)
    end
   
    def add_new_customers_to_waiting_customers(new_customers)
        @waiting_customers = @waiting_customers.merge(new_customers){|key, existing_customers, new_customers| [existing_customers, new_customers].flatten}
    end

    def group_customers_by_booking_name(customers)
        customers.group_by { |customer| customer.booking_name}
    end

    def check_available_room_capacity(room)
        return room.capacity - room.number_in_room
    end
     
    def customer_can_afford?(customer, entry_fee)
        return customer.wallet_balance >= entry_fee
    end
    
    def increase_till_balance(amount_to_increase)
        @till_balance += amount_to_increase
    end
    
    def take_group_payment(customers, entry_fee)
        customers.each do |customer|
            customer.reduce_wallet_balance(entry_fee)
            increase_till_balance(entry_fee)
        end
    end
   
    def get_customers_for_room_by_booking_name(booking_name)
        customers_for_room = @waiting_customers[booking_name]
        return customers_for_room 
    end
    
    def only_customers_who_will_fit_in_room(customers_for_room, capacity, booking_name)
        customers_that_fit, remaining = customers_for_room.partition.with_index { |_, index| index <= capacity-1 }
        @waiting_customers[booking_name] = remaining
        return customers_that_fit
    end
    
    def reject_customers_without_enough_money(customers, room_rate)
        customers, rejected = customers.partition{ |customer| customer_can_afford?(customer, room_rate) }  
        @bouncer.bounce(rejected) 
        return customers
    end

    def assign_room_object_to_customers(customers_who_can_afford, room)
        customers_who_can_afford.each { |customer| customer.room=room}
    end

    def allocate_customers_to_rooms()
        @rooms.each do |room|
            room_rate = room.entry_fee
            capacity = check_available_room_capacity(room)
            booking_name = room.booking_name
            customers_for_room = get_customers_for_room_by_booking_name(booking_name)
            next if customers_for_room == nil
            customers_that_fit = only_customers_who_will_fit_in_room(customers_for_room, capacity, booking_name)
            next if customers_that_fit == nil
            customers_who_can_afford = reject_customers_without_enough_money(customers_that_fit, room_rate)
            next if customers_who_can_afford == nil
            take_group_payment(customers_who_can_afford, room_rate)
            assign_room_object_to_customers(customers_who_can_afford, room)
            room.add_customers(customers_who_can_afford)

        end
    end

end