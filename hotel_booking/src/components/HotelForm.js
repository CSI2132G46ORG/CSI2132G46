import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import EmployeeButton from "./EmployeeButton";

const HotelForm = () => {
    const location = useLocation();
    const [hotelId, setHotelId] = useState(location.state && location.state.hotelId? location.state.hotelId:'');
    const [category, setCategory] = useState(location.state && location.state.category? location.state.category:'');
    const [stAd, setStAddress] = useState(location.state && location.state.stAdr? location.state.stAdr:'');
    const [city, setCity] = useState(location.state && location.state.city? location.state.city:'');
    const [provOrState, setProvOrState] = useState(location.state && location.state.provOrState? location.state.provOrState:'');
    const [postOrZip, setPostOrZip] = useState(location.state && location.state.postOrZip? location.state.postOrZip:'');
    const [country, setCountry] = useState(location.state && location.state.country? location.state.country:'');
    const [email, setEmail] = useState(location.state && location.state.email? location.state.email:'');
    const [hotelChainId, setHotelChainId] = useState(location.state && location.state.hotelChainId? location.state.hotelChainId: '');
    const port = 5100;
    const navigate = useNavigate();


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

    const updateHotelChainId = (e) => {
        setHotelChainId(e.target.value);
    };


    const extraInput = () => {
        if (!location.state) {
            return (
                <div>
                    <input type={"text"} value={hotelChainId} onChange={updateHotelChainId} placeholder="Enter hotel chain Id"/>
                </div>
            );
        }
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
            })
            .then(
                navigate('/allhotels', {replace: true, state: {
                    hotelChainId: hotelChainId
                }})
            );
        }
        else {
            const body = {category, stAd, city, provOrState, postOrZip, country, email, hotelChainId};
            console.log(body);
            fetch(`http://localhost:${port}/hotels`, {
                method: 'POST',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            })
            .then((res) => {
                // if (res.status == 200) {
                //     navigate('/allrooms', {replace: true, state: {
                //         hotelId: hotelId
                //     }})
                // }
            });
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
        <div className="hotelForm">
            <h2>Modify Rooms</h2>
            <form onSubmit={handleSubmit}>
                <input type={"text"} value={category} onChange={updateCategory} placeholder="Enter a category"/>
                <input type={"text"} value={stAd} onChange={updateStAd} placeholder="Enter street address"/>
                <input type={"text"} value={city}  onChange={updateCity} placeholder="Enter city"/>
                <input type={"text"} value={provOrState} onChange={updateProvOrState} placeholder="Enter province or state"/>
                <input type={"text"} value={postOrZip} onChange={updatePostOrZip} placeholder="Enter postal code or zip code"/>
                <input type={"text"} value={country} onChange={updateCountry} placeholder="Enter country"/>
                <input type={"text"} value={email} onChange={updateEmail} placeholder="Enter email"/>
                {extraInput()}
                <input type={"submit"} value="submit"/>
            </form>
            {showAllRooms()}
        </div>
    );
};

export default HotelForm;