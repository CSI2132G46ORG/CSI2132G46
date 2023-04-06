import { useEffect } from "react";
import { useState } from "react";
import { useLocation } from "react-router-dom";
import AllHotelsCard from "./AllHotelsCard";
import EmployeeButton from "./EmployeeButton";

const AllHotels = () => {
    const location = useLocation();
    const [hotelChainId, setHotelChainId] = useState(location.state && location.state.hotelChainId? location.state.hotelChainId:'');
    const [category, setCategory] = useState();
    const [stAd, setStAddress] = useState();
    const [city, setCity] = useState();
    const [results, setResults] = useState([]);

    const port = 5100;

    const getAllHotels = () => {
        fetch(`http://localhost:${port}/allhotels/${hotelChainId}`, { method: 'GET' })
        .then(d => {
            return d.json();
        })
        .then((res) => {
            console.log(res);
            setResults(res);
        })
    };

    useEffect(() => {
        getAllHotels();
    }, []);

    return (
        <div className="allHotels">
            <h2>All Hotels</h2>

            <EmployeeButton title = "Add new Hotel" path='/modifyhotels'/>
            {
                results.map((obj) => {
                    console.log('obj ', obj);
                    return (
                        <AllHotelsCard key = {obj.id} hotelId={obj.id} category = {obj.category} numRooms = {obj.number_of_rooms} 
                        stAdr = {obj.street_address} city = {obj.city} provOrState = {obj.province_or_state} postOrZip={obj.postal_code_or_zip_code}
                        country = {obj.country} email = {obj.contact_email} hotelChainId={obj.hotel_chain_id}/>
                    );
                })
            }
        </div>
    );
};

export default AllHotels;