import { useState } from "react";
import EmployeeButton from "./EmployeeButton";
import useToken from "./useToken";
import RentingCard from "./RentingCard";
import { useEffect } from "react";

const AllRentings = () => {
    const [rentings, setRentings] = useState([]);
    const { token, setToken } = useToken();
    const port = 5100;


    const getAllRentings = async () => {
        fetch(`http://localhost:${port}/rentings/${token.hotel_id}`, { method: 'GET' })
        .then(res => res.json())
        .then(data => {
            console.log(data);
            setRentings(data);
        });
    };

    useEffect(() => {
        getAllRentings();
    }, []);


    return (
        <div className="allRentings">
            <h2>All Rentings</h2>
            <EmployeeButton title = 'Check In Customer' path = '/createRenting'/>

            {
                rentings.map((obj) => {
                    console.log(obj);

                    return(
                        <RentingCard key = {obj.renting_id} rentingId = {obj.renting_id} employeeId = {obj.employee_id}
                         customerId = {obj.customer_id} checkInDate = {obj.checkin_date} hotelId={obj.hotel_id} 
                         paidFor = {obj.paid_for} checkOutDate = {obj.checkout_date} roomNumber = {obj.room_id} rentingDate={obj.renting_date}
                         bookingId = {obj.booking_id}/>
                    );
                    
                })
            }

        </div>
    );
};

export default AllRentings;