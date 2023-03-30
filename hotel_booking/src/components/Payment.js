import { useState } from 'react';
import './assets/styles/Payment.css';
import BackNavBar from "./BackNavbar";
import useToken from './useToken';

const Payment = (props) => { 
    const { token, setToken } = useToken();
    const [roomNum, setRoomNum] = useState();
    const [hotelID, setHotelID] = useState();
    const [checkInDate, setCheckInDate] = useState();
    const [checkOutDate, setCheckOutDate] = useState();
    const [capacity, setCapacity] = useState();
    const [amenities, setAmenities] = useState();
    const [view, setView] = useState();
    const [hotelName, setHotelName] = useState();
    const [extended, setExtended] = useState();
    const [price, setPrice] = useState();
    

    return (
    <div className='payment'>
        <BackNavBar/>
        <form>
            <h3>Person Information: </h3>
            <input type={'text'} id={'name'} placeholder='Enter your full name'/>
            <input type={'email'} id='email1' placeholder='Enter your email'/>
            <input type={'email'} id='email2' placeholder='Confirm your email'/>
            <input type={'text'} id='phone' placeholder='Email your phone number'/>
            <h3>Room Details: </h3>
            <h3>Payment</h3>
            <input type={'text'} id={'name'} placeholder='Enter your full name'/>
            <input type={'text'} placeholder='0000 0000 0000 0000' id='ccnum'/>
            <input type={'number'} id='expMonth' placeholder='MM' style={{display: 'inline-block', width: '40px'}}/>/
            <input type={'number'} id='expYear' placeholder='YY' style={{display: 'inline-block', width: '40px'}}/>
            <input type={'number'} placeholder='CVV' id='cvv'/>
            <h4>Billing Address</h4>
            <input type={'text'} id={'name'} placeholder='Enter your full name'/>
            <input type={'text'} id={'name'} placeholder='Enter your Postal Code or Zip code'/>
            <h3></h3>

            <h4>Price Per Night: </h4>
            <span>Check In: </span>
            <span>Check Out: </span>
            <input type={'submit'} value='Book'/>
        </form>
    </div>
    );
};

export default Payment;