import { useState } from "react";
import { useNavigate } from "react-router-dom";
import './assets/styles/HotelChainCard.css';

const HotelChainCard = (props) => {
    const [id, setId] = useState(props.hcId);
    const [name, setName] = useState(props.name);
    const [street_address, setSetAddress] = useState(props.stAd);
    const [city, setCity] = useState(props.city);
    const [province_or_state, setProvOrState] = useState(props.provOrState);
    const [postal_code_or_zip_code, setPostOrZip] = useState(props.postOrZip);
    const [country, setCountry] = useState(props.country);
    const [numHotels, setNumHotels] = useState(props.numHotels);
    const navigate = useNavigate();
    const port = 5100;


    const deleteHotelChain = () => {
        const body = {id};
        console.log(body);
        if (window.confirm('Are you sure you want to delete')) {
            fetch(`http://localhost:${port}/hotelchains`, {
                method: 'DELETE',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            });
        }
        else {

        }
        
    };

    const handleClick = () => {

        navigate('/modifyhotelchains', {state: {
            id: id,
            name: name,
            street_address: street_address,
            city: city,
            province_or_state: province_or_state,
            postal_code_or_zip_code: postal_code_or_zip_code,
            country: country
        }});
    };

    return (
        <div className="hotelChainCard">
            <p><b>Name:</b> {name}</p>
            <p><b>Address:</b> {street_address}, {city}, {province_or_state}, {postal_code_or_zip_code}, {country}</p>
            <p><b>Number of hotels:</b> {numHotels}</p>
            <div className='cardBlock'>
                <div onClick={deleteHotelChain}><img src={require('./assets/img/trash.png')} alt='trash image' /></div>
                <div style={{display: 'block', textDecoration: 'underline'}} onClick={handleClick}>Modify Hotel Chain</div>
            </div>
        </div>
    );
};

export default HotelChainCard;