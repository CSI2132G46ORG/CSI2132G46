import { useState } from "react";
import useToken from "./useToken";
import DatePickers from './DatePickers';
import { useLocation } from "react-router-dom";
import './assets/styles/CreateRenting.css';
import { useEffect } from "react";

const CreateRenting = () => {

    const { token, setToken } = useToken();
    const location = useLocation();

    const [roomNumber, setRoomNumber] = useState(location.state && location.state.roomNumber ? location.state.roomNumber: '' );
    const [checkInDate, setCheckInDate] = useState(location.state && location.state.checkin_date ? new Date (location.state.checkin_date): new Date());
    const [checkOutDate, setCheckOutDate] = useState(location.state && location.state.checkout_date ? new Date (location.state.checkout_date): new Date());
    const [customerId, setCustomerId] = useState(location.state && location.state.customerId ? location.state.customerId: '');
    const [bookingId, setBookingId] = useState(location.state && location.state.bookingId ? location.state.bookingId: -1);

    const hotelId = token.hotel_id;
    const employeeId = token.id;
    
    
    const port = 5100;

    // if (PaymentResponse.){}

    const createRentRequest = () => {};

    const createRentArchive = () => {
        fetch(
            `http://localhost:${port}/lastrenting`, {method: 'GET' }
        )
        .then(d => {
            return d.json();
        })
        .then((res) => {
            console.log('last ', res[0]);
            const {renting_id, customer_id, employee_id, room_id, hotel_id,
                checkin_date, checkout_date, renting_date, paid_for, booking_id} = res[0];
        //    const archive = {renting_id, customer_id, employee_id, room_id, hotel_id,
        //        checkin_date, checkout_date, renting_date, paid_for, booking_id};
                const archive = res[0];
            console.log('archive is added.... ', archive);
            fetch(`http://localhost:${port}/rentingarchives`, {
                method: 'POST',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(archive)
            })
            .then((res) => {
                if (res.status==200){
                    console.log('renting archive added successfully');
                    // navigate('/reservio', { replace: true });
                }
            }

            );
            ;

        });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        const body = {};

        if (!location.state) {

        }

        else {

            var checkInStr = checkInDate.toLocaleDateString('fr-FR');
            var checkOutStr = checkOutDate.toLocaleDateString('fr-FR');
            checkInStr = checkInStr.split("/").reverse().join("/").replace(/\//g, "_");
            checkOutStr = checkOutStr.split("/").reverse().join("/").replace(/\//g, "_");
        // console.log(checkInStr);
            const body = {customerId, employeeId, roomNumber, hotelId, checkInStr, checkOutStr, bookingId};

            fetch(`http://localhost:${port}/rentings`, {
                    method: 'POST',
                    headers: {"content-type": "application/JSON"},
                    body: JSON.stringify(body)
            })
            .then((response) => {
                if (response.status==200) {
                    // navigate('/reservio', { replace: true });
                     createRentArchive();
                }
            });
            }
        
    };

    const updateRoomNumber = (e) => {
        setRoomNumber(e.target.value);
    };

    return (
        <div className="createRenting">
            <h3> Complete Renting Now </h3>

            <form onSubmit={handleSubmit}>
                <input type={"text"} placeholder='Enter customer name' required/>
                <input type={"text"} placeholder='Enter customer email' required/>
                <input type={"text"} placeholder='Enter room number' value={roomNumber} onChange={updateRoomNumber}  required/>
                <DatePickers defaultCheckIn={checkInDate} defaultCheckOut={checkOutDate} setCheckInDate={setCheckInDate} setCheckOutDate={setCheckOutDate}/>
                <h3>Payment</h3>
                    <input type={'text'} id={'paymentName'} placeholder='Enter your full name'required/>
                    <input type={'text'} placeholder='0000 0000 0000 0000' id='ccnum' required/>
                    <input type={'text'} id='expMonth' placeholder='MM' style={{display: 'inline-block', width: '40px'}} required/>/
                    <input type={'text'} id='expYear' placeholder='YY' style={{display: 'inline-block', width: '40px'}} required/>
                    <input type={'text'} placeholder='CVV' id='cvv'/>
                    <h4>Billing Address</h4>
                    <input type={'text'} id={'country'} placeholder='Enter your country' required/>
                    <input type={'text'} id={'paymentziporpost'} placeholder='Enter your Postal Code or Zip code' required/>
                <input type={"submit"} placeholder='Enter customer name' value="Create Renting"/>
            </form>
        </div>
    );
};

export default CreateRenting;