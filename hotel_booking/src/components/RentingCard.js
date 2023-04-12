import { useEffect } from 'react';
import './assets/styles/RentingCard.css';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const RentingCard = (props) => {
    const [hotelName, setHotelName] = useState();
    const [rentingId, setRentingId] = useState(props.rentingId);
    const [bookingId, setBookingId] = useState(props.bookingId);
    const [checkin_date, setCheckInDate] = useState(props.checkInDate.split('T')[0].replace(/-/g, '/'));
    const [checkout_date, setCheckOutDate] = useState(props.checkOutDate.split('T')[0].replace(/-/g, '/'));
    const [customerId, setCustomerId] = useState(props.customerId);
    const [customerName, setCustomerName] = useState();
    const [roomNumber, setRoomNumber] = useState(props.roomNumber);
    const [rentingDate, setBookingDate] = useState(props.rentingDate.split('T')[0]);
    
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

    const deleteRenting = () => {
        const body = {rentingId};
        console.log(body);
        if (window.confirm('Are you sure you want to delete')) {
            fetch(`http://localhost:${port}/rentings/${rentingId}`, {
                method: 'DELETE',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            });
        }
    };


    const handleClick = () => {
        
        navigate('/createrenting', {state: {
            bookingId: bookingId,
            rentingId: rentingId,
            checkin_date: checkin_date,
            checkout_date: checkout_date,
            customerName: customerName,
            roomNumber: roomNumber,
            customerId: customerId
        }});
    };

    useEffect(() => {
        findCustomerName();
    }, []);

    return (
        <div className="RentingCard">
            <p> <b>Customer Name:</b> {customerName} </p>
            <p> <b>Room Number:</b> {roomNumber}</p>
            <span><b>Check In:</b> {checkin_date} </span>
            <span><b>Check Out:</b> {checkout_date} </span>
            <p><b>Creation Date:</b> {rentingDate} </p>
            <div className='cardBlock'>
                <div onClick={deleteRenting}><img src={require('./assets/img/trash.png')} alt='trash' /></div>
                <div style={{display: 'block', textDecoration: 'underline'}} onClick={handleClick}>Modify Rent</div>

            </div>
        </div>
    );
};

export default RentingCard;