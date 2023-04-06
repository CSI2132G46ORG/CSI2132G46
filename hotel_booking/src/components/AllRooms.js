import { useState } from "react";
import { useEffect } from "react";
import { useLocation } from "react-router-dom";
import AllRoomsCard from "./AllRoomsCard";
import EmployeeButton from "./EmployeeButton";
import HotelCard from "./HotelCard";
import RoomCard from "./RoomCard";

const AllRooms = () => {
    const port = 5100;
    const location = useLocation();
    const [results, setResults] = useState([]);
    const [hotelId, setHotelId] = useState(location.state && location.state.hotelId? location.state.hotelId: '');

    const getAllRooms = () => {
        fetch(`http://localhost:${port}/rooms/${hotelId}`, { method: 'GET' })
        .then(d => {
            return d.json();
        })
        .then((res) => {
            console.log(res);
            setResults(res);
        });
    };

    

    useEffect(() => {
        getAllRooms();
    }, []);

    return (
        <div>
            <h2>All Rooms</h2>
            <EmployeeButton title = "Add new Room" path='/modifyrooms'/>
            {
                results.map((obj) => {
                    console.log(obj);
                    return (
                        <AllRoomsCard key={`${obj.room_number}_${obj.hotel_id}`} roomNumber = {obj.room_number} hotelId = {obj.hotel_id} price = {obj.price}
                        capacity = {obj.capacity} view = {obj.view} extended = {obj.extended.toString()} problems = {obj.problems.toString()}/>
                    );  
                })
            }
        </div>

        
    );
};

export default AllRooms;