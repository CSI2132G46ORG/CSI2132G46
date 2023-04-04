import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './assets/styles/Payment.css';
import BackNavBar from "./BackNavbar";
import Navbar from './Navbar';
import useToken from './useToken';
import { useLocation } from 'react-router-dom';

const Payment = (props) => { 
    const { token, setToken } = useToken();
    const [roomNum, setRoomNum] = useState(1);
    const [hotelID, setHotelID] = useState(1);
    const [checkInDate, setCheckInDate] = useState('2023/05/06');
    const [checkOutDate, setCheckOutDate] = useState('2023/05/15');
    const [capacity, setCapacity] = useState();
    const [amenities, setAmenities] = useState();
    const [view, setView] = useState();
    const [hotelName, setHotelName] = useState();
    const [extended, setExtended] = useState();
    const [price, setPrice] = useState(150);
    const [locationTemp, setLocation] = useState("Ottawa, Canada");
    const [address, setAddress] = useState('');
    const [city, setCity] = useState('');
    const [provOrState, setProvorState] = useState('');
    const [postOrZip, setPostOrZip] = useState('');
    const [country, setCountry] = useState('');
    const [ssn_sin, setSsnSin] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [name, setName] = useState('');
    
    const navigate = useNavigate();
    const location = useLocation();
    const port = 5100;
    var providedCapacity= (location.state!=null && location.state.capacity !=null) ? location.state.capacity:'Mariot inn';
    var providedHotelName= (location.state!=null && location.state.hotelName !=null) ? location.state.hotelName:'king';
    var providedCheckIn= (location.state!=null && location.state.checkIn !=null) ? location.state.checkIn:new Date();
    var providedCheckout = (location.state!=null && location.state.checkOut !=null) ? location.state.checkOut:new Date();
    var providedArea = (location.state!=null && location.state.area !=null) ? location.state.area:'Ottawa, Canada';
    var providedPrice = (location.state!=null && location.state.price !=null) ? location.state.price:250;
    
    const passwordForm = () => {
        if (!token) {
            return (
                <div>
                    <h4>Personal Info </h4>
                    <input type="text" placeholder="Street address" value={address} onChange={e => setAddress(e.target.value)} required/>
                    <input type="text" placeholder="City" value={city} onChange={e => setCity(e.target.value)} required/>
                    <input type="text" placeholder="Province or State" value={provOrState} onChange={e => setProvorState(e.target.value)} required/>
                    <input type="text" placeholder="Postal code or Zip code" value={postOrZip} onChange={e => setPostOrZip(e.target.value)} required/>
                    <input type="text" placeholder="Country" value={country} onChange={e => setCountry(e.target.value)} required/>
                    <input type="text" placeholder="SSN or SIN" value={ssn_sin} onChange={e => setSsnSin(e.target.value)} required/>
                    <h4>Password</h4>
                    <input type={'password'} placeholder="Create a password" required/>
                    <input type={'password'} placeholder="Confirm your password" onChange={e => setPassword(e.target.value)} required/>
                </div>
            );
        }

    };

    const addBookingArchive = async () => {
        fetch(
            `http://localhost:${port}/lastbooking`, {method: 'GET' }
        )
        .then(d => {
            return d.json();
        })
        .then((res) => {
            console.log('last ', res[0]);
            const {booking_id, customer_id, room_id, hotel_id, checkin_date, checkout_date, booking_date} = res[0];
            const archive = {booking_id, customer_id, room_id, hotel_id, checkin_date, checkout_date, booking_date};
            console.log('archive is added.... ');
            fetch(`http://localhost:${port}/bookingarchives`, {
                method: 'POST',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(archive)
            })
            .then((res) => {
                if (res.status==200){
                    console.log('booking archive added successfully');
                    navigate('/reservio', { replace: true });
                }
            }

            );
            ;

        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault()
        
        
        try {
            if(!token){
                
                const res = fetch(`http://localhost:${port}/customers/${email}`, {method: 'GET' })
                .then(d => {
                    return d.json();
                })
                .then(data => {
                    if(data.length!=0){
                        console.log("user already exists");
                    }
                    else {
                    const userBody = {name, address, city, provOrState, postOrZip, country, ssn_sin, email, password};
                    console.log(userBody);
                
                    const response = fetch(`http://localhost:${port}/signUp`, {
                        method: 'POST',
                        headers: {"content-type": "application/JSON"},
                        body: JSON.stringify(userBody)
                    });
                    
    
                    // console.log(response);
                    return response;
                    }
                })
                .then(res => {
                        if (res.status==200) {
                            
                            fetch(`http://localhost:${port}/customers/${email}`, {method: 'GET' })
                            .then(d => {
                                return d.json();
                            })
                            .then((data) => {
                                    const id = data[0].id;
                                    const full_name = data[0].full_name;
                                    setToken(
                                        {token: {
                                            id: id,
                                            full_name: full_name
                                        }}
                                    );
                                    const customerID = id;
        
                                    const body = {customerID, roomNum, hotelID, checkInDate, checkOutDate};
                                    console.log(body);


                                    fetch(`http://localhost:${port}/bookings`, {
                                    method: 'POST',
                                    headers: {"content-type": "application/JSON"},
                                    body: JSON.stringify(body)
                                    })
                                    .then((res) => {
                                            if (res.status==200) {
                                                addBookingArchive();
                                            }
                                        }

                                    );
                                }
                            );

                        
                    }
                    else {
    
                    }
                }
    
                );
                
            }
            else {
                //Connected customer

                const customerID = token.id;
        
                const body = {customerID, roomNum, hotelID, checkInDate, checkOutDate};
                console.log(token);
                console.log(body);
            
                fetch(`http://localhost:${port}/bookings`, {
                    method: 'POST',
                    headers: {"content-type": "application/JSON"},
                    body: JSON.stringify(body)
                })
                .then((response) => {
                    if (response.status==200) {
                        //navigate('/reservio', { replace: true });
                        addBookingArchive();
                    }
                })
                ;
            }
        } catch (error) {
            console.log(error);
        }
        
    };

    return (
    <div className='payment'>
        <Navbar token={token}/>
        <form onSubmit={handleSubmit}>
            <h3>Personal Information </h3>
            <input type={'text'} id={'name'} placeholder='Enter your full name' onChange={e => {setName(e.target.value)}} required/>
            <input type={'email'} id='email1' placeholder='Enter your email' required/>
            <input type={'email'} id='email2' placeholder='Confirm your email' onChange={e => {setEmail(e.target.value)}} required/>
            <input type={'text'} id='phone' placeholder='Enter your phone number' required/>
            <h3>Room Details </h3>
            <div>
                <span>Amenities: {amenities}</span>
                <span>Capacity: {providedCapacity}</span>
            </div>
            <h3>Payment</h3>
            <input type={'text'} id={'paymentName'} placeholder='Enter your full name'required/>
            <input type={'text'} placeholder='0000 0000 0000 0000' id='ccnum' required/>
            <input type={'text'} id='expMonth' placeholder='MM' style={{display: 'inline-block', width: '40px'}} required/>/
            <input type={'text'} id='expYear' placeholder='YY' style={{display: 'inline-block', width: '40px'}} required/>
            <input type={'text'} placeholder='CVV' id='cvv'/>
            <h4>Billing Address</h4>
            <input type={'text'} id={'country'} placeholder='Enter your country' required/>
            <input type={'text'} id={'paymentziporpost'} placeholder='Enter your Postal Code or Zip code' required/>
            {passwordForm()}
            

            <h3>Hotel Details </h3>
            <h5>Hotel Name: {providedHotelName}</h5>
            <p><b>Location</b>: {providedArea}</p>
            <span><b>Check In</b>: {providedCheckIn}</span>
            <span><b>Check Out</b>: {providedCheckout}</span>
            <p><b>Price Per Night</b>: ${providedPrice}</p>
            <input type={'submit'} value='Book'/>
        </form>
    </div>
    );
};

export default Payment;