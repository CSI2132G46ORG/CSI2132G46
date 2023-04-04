import { useState } from "react";
import { useLocation } from "react-router-dom";
import EmployeeButton from "./EmployeeButton";

const HotelForm = () => {
    const location = useLocation();
    const [hotelId, setHotelId] = useState(location.state && location.state.hotelId? location.state.hotelId:'');
    const [category, setCategory] = useState(location.state.category);
    const [stAd, setStAddress] = useState(location.state.stAdr);
    const [city, setCity] = useState(location.state.city);
    const [provOrState, setProvOrState] = useState(location.state.provOrState);
    const [postOrZip, setPostOrZip] = useState(location.state.postOrZip);
    const [country, setCountry] = useState(location.state.country);
    const [email, setEmail] = useState(location.state.email);
    const port = 5100;


    const updateCategory = (e) => {
        setCategory(e.target.value);
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
    const updateEmail = (e) => {
        setEmail(e.target.value);
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        if (location.state){
            const body = {hotelId, category, stAd, city, provOrState, postOrZip, country, email};
            console.log(body);
            fetch(`http://localhost:${port}/hotels`, {
                method: 'PUT',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            });
        }
        else {

        }
    };

    const showAllRooms = () => {
        if (location.state) {
            return (<EmployeeButton title = "Show All Rooms" path='/allrooms' hotelId={hotelId}/>);
        }
        else {
        }
    };

    return (
        <div>
            <form onSubmit={handleSubmit}>
                <input type={"text"} value={category} onChange={updateCategory} placeholder="Enter a category"/>
                <input type={"text"} value={stAd} onChange={updateStAd} placeholder="Enter street address"/>
                <input type={"text"} value={city}  onChange={updateCity} placeholder="Enter city"/>
                <input type={"text"} value={provOrState} onChange={updateProvOrState} placeholder="Enter province or state"/>
                <input type={"text"} value={postOrZip} onChange={updatePostOrZip} placeholder="Enter postal code or zip code"/>
                <input type={"text"} value={country} onChange={updateCountry} placeholder="Enter country"/>
                <input type={"text"} value={email} onChange={updateEmail} placeholder="Enter email"/>
                <input type={"submit"} value="submit"/>
            </form>
            {showAllRooms()}
        </div>
    );
};

export default HotelForm;