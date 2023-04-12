import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import EmployeeButton from "./EmployeeButton";
import './assets/styles/HotelChainForm.css';

const HotelChainForm = (props) => {
    const location = useLocation();

    const [id, setId] = useState(location.state && location.state.id? location.state.id:'');
    const [name, setName] = useState(location.state && location.state.name? location.state.name:'');
    const [street_address, setStAddress] = useState(location.state && location.state.street_address? location.state.street_address:'');
    const [city, setCity] = useState(location.state && location.state.city? location.state.city:'');
    const [province_or_state, setProvOrState] = useState(location.state && location.state.province_or_state? location.state.province_or_state:'');
    const [postal_code_or_zip_code, setPostOrZip] = useState(location.state && location.state.postal_code_or_zip_code? location.state.postal_code_or_zip_code:'');
    const [country, setCountry] = useState(location.state && location.state.country? location.state.country: '');
    const [numHotels, setNumHotels] = useState(location.state && location.state.numHotels? location.state.numHotels: 0);
    const port = 5100;
    const navigate = useNavigate();


    const updateName = (e) => {
        setName(e.target.value);
    };
    const updateStAd = (e) => {
        setStAddress(e.target.value);
    };
    const updateCity = (e) => {
        setCity(e.target.value);
    };
    const updateProvOrState = (e) => {
        setProvOrState(e.target.value);
    };
    const updatePostOrZip = (e) => {
        setPostOrZip(e.target.value);
    };
    const updateCountry = (e) => {
        setCountry(e.target.value);
    };

    const handleSubmit = (e) => {
        e.preventDefault();

        
        if (location.state){
            const body = {id, name, street_address, city, province_or_state, postal_code_or_zip_code, country};
            console.log(body);
            fetch(`http://localhost:${port}/hotelchains`, {
                method: 'PUT',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            })
            .then(
                navigate('/allhotelchains' , {replace: true})
            );
        }
        else {
            const body = {name, street_address, city, province_or_state, postal_code_or_zip_code, country};
            console.log(body);
            fetch(`http://localhost:${port}/hotelchains`, {
                method: 'POST',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            })
            .then((res) => {
                if (res.status == 200) {
                    navigate('/allhotelchains', {replace: true})
                }
            });
        }

    };

    const showAllHotels = () => {
        if (location.state) {
            return (<EmployeeButton title = "Show all Hotels" path='/allhotels' hotelChainId={id}/>);
        }
        else {
        }
    };

    return (
    <div className="hotelchainForm">
        <h2>Hotel Chain Form</h2>
        <form onSubmit={handleSubmit}>
            <input type={"text"} placeholder="Enter hotel chain name" onChange={updateName} value = {name}/>
            <input type={"text"} placeholder="Enter street address" onChange={updateStAd} value = {street_address}/>
            <input type={"text"} placeholder="Enter city" onChange={updateCity} value = {city}/>
            <input type={"text"} placeholder="Enter prov or state" onChange={updateProvOrState} value = {province_or_state} />
            <input type={"text"} placeholder="Enter post or zip" onChange={updatePostOrZip} value = {postal_code_or_zip_code}/>
            <input type={"text"} placeholder="Enter country" onChange={updateCountry} value = {country}/>
            <input type={"submit"} value="Submit"/>

        </form>
        {showAllHotels()}
    </div>
    );
};
export default HotelChainForm;