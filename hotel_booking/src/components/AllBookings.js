import { useEffect } from "react";
import { useState } from "react";
import BookingCard from "./BookingCard";
import EmployeeButton from "./EmployeeButton";
import useToken from "./useToken";

const AllBookings = () => {

    const [bookings, setBookings] = useState([]);
    const { token, setToken } = useToken();
    const port = 5100;

    const getAllBookings = async () => {
        fetch(`http://localhost:${port}/bookings/${token.hotel_id}`, { method: 'GET' })
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
        <div className="allBookings">
            <h2>Bookings </h2>
            {/* <EmployeeButton title = 'Check in Customer' path='/createrenting'/> */}
            {
                bookings.map((obj) => {
                    console.log(obj);

                    return(
                        <BookingCard key = {obj.booking_id} bookingId = {obj.booking_id} customerId = {obj.customer_id} 
                        checkInDate = {obj.checkin_date} hotelId={obj.hotel_id}
                        checkOutDate = {obj.checkout_date} roomNumber = {obj.room_id} bookingDate={obj.booking_date} token= {token}/>
                    );
                    
                })
            }

        </div>
    );
};

export default AllBookings;