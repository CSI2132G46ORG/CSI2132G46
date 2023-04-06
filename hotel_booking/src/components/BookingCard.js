import { useEffect } from 'react';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './assets/styles/BookingCard.css';

const BookingCard = (props) => {
    const [hotelName, setHotelName] = useState();
    const [bookingId, setBookingId] = useState(props.bookingId);
    const [checkin_date, setCheckInDate] = useState(props.checkInDate.split('T')[0].replace(/-/g, '/'));
    const [checkout_date, setCheckOutDate] = useState(props.checkOutDate.split('T')[0].replace(/-/g, '/'));
    const [customerId, setCustomerId] = useState(props.customerId);
    const [customerName, setCustomerName] = useState();
    const [roomNumber, setRoomNumber] = useState(props.roomNumber);
    const [booking_date, setBookingDate] = useState(props.bookingDate.split('T')[0]);
    
    const port = 5100;
    const navigate = useNavigate();

    const findCustomerName = async () => {
        fetch(`http://localhost:${port}/customersbyid/${customerId}`)
        .then((response) => response.json())
        .then((data) => {
            console.log('customer Data', data);
            setCustomerName(data[0].full_name);
        }
        )
        ;
    };

    const handleClick = () => {

        navigate('/createrenting', {state: {
            bookingId: bookingId,
            checkin_date: checkin_date,
            checkout_date: checkout_date,
            roomNumber: roomNumber,
            customerId: customerId
        }});
    };

    useEffect(() => {
        findCustomerName();
    }, []);
    


    return (
        <div className="bookingCard" onClick={handleClick}>
            <p> Customer Name: {customerName} </p>
            <p> Room Number: {roomNumber}</p>
            <span>Check In: {checkin_date} </span>
            <span>Check Out: {checkout_date} </span>
            <p>Booking Date: {booking_date} </p>
        </div>
    )
};
export default BookingCard;