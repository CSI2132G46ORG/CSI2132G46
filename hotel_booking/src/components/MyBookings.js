import { useState } from "react";
import useToken from "./useToken";
import BookingCard from "./BookingCard";
import { useEffect } from "react";

const MyBookings = () => {
    const [bookings, setBookings] = useState([]);
    const { token, setToken } = useToken();
    const port = 5100;

    const getAllBookings = async () => {
        fetch(`http://localhost:${port}/bookingsForCustomer/${token.id}`, { method: 'GET' })
        .then(res => res.json())
        .then(data => {
            console.log(data);
            setBookings(data);
        });
    };

    useEffect(() => {
        getAllBookings();
    }, []);



    return (

        <div className="myBookings">
            <h2>My Bookings</h2>
            {
                bookings.map((obj) => {
                    console.log(obj);

                    return(
                        <BookingCard key = {obj.booking_id} bookingId = {obj.booking_id} customerId = {obj.customer_id} 
                        checkInDate = {obj.checkin_date} hotelId={obj.hotel_id}
                        checkOutDate = {obj.checkout_date} roomNumber = {obj.room_id} bookingDate={obj.booking_date}/>
                    );
                    
                })
            }
        </div>
    );
};

export default MyBookings;