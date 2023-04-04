import { useEffect } from "react";
import { useState } from "react";
import EmployeeButton from "./EmployeeButton";
import HotelChainCard from "./HotelChainCard";

const AllHotelChains = () => {

    const [results, setResults] = useState([]);
    const port = 5100;
    
    const getAllHC =  () => {
        fetch(`http://localhost:${port}/hotelchains/`, { method: 'GET' })
        .then(res => res.json())
        .then(data => {
            console.log("hotels ", data);
            setResults(data);
        });
    };

    useEffect(() => {
        getAllHC();
    }, []);

    return (
        <div className="allHotelchains">
            <EmployeeButton title = "Add new hotel chain" path ='/' />
            {
                results.map((obj) => {
                    console.log(obj);

                    return(
                        <HotelChainCard key = {obj.id} hcId = {obj.id} name = {obj.name} stAd = {obj.street_address} 
                        city = {obj.city} provOrState={obj.province_or_state}
                        postOrZip = {obj.postal_code_or_zip_code} country = {obj.country} numHotels={obj.number_of_hotels}/>
                    );
                    
                })
            }
        </div>
    );
};

export default AllHotelChains;