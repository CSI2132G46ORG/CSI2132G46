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

    const deleteBooking = () => {
        if (window.confirm('Are you sure you want to delete')) {
            console.log('confirmed')
            const body = {bookingId};
            console.log(body);
            fetch(`http://localhost:${port}/bookings`, {
                method: 'DELETE',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            });
        }

        else {

        }
        
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
        <div className="bookingCard">
            <p> <b>Customer Name:</b> {customerName} </p>
            <p> <b>Room Number:</b> {roomNumber}</p>
            <span><b>Check In:</b> {checkin_date} </span>
            <span><b>Check Out:</b> {checkout_date} </span>
            <p><b>Booking Date:</b> {booking_date} </p>
            <div className='cardBlock'>
                <div onClick={deleteBooking}><img src={require('./assets/img/trash.png')} alt='trash image' /></div>
                <div style={{display: 'block', textDecoration: 'underline'}} onClick={handleClick}>Modify Booking</div>
            </div>
        </div>
    )
};
export default BookingCard;