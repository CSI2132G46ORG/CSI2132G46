import { useNavigate } from 'react-router-dom';
import './assets/styles/AllHotelsCard.css';

const { useState } = require("react");

const AllHotelsCard = (props) => {
    const [hotelId, setHotelId] = useState(props.hotelId);
    const [category, setCategory] = useState(props.category);
    const [numRooms, setNumRooms] = useState(props.numRooms);
    const [stAdr, setStAddress] = useState(props.stAdr);
    const [city, setCity] = useState(props.city);
    const [provOrState, setProvOrState] = useState(props.provOrState);
    const [postOrZip, setPostOrZip] = useState(props.postOrZip);
    const [country, setCountry] = useState(props.country);
    const [email, setEmail] = useState(props.email);
    const navigate = useNavigate();
    const port = 5100;


    const deleteHotel = () => {
        const body = {hotelId};
        console.log(body);
        fetch(`http://localhost:${port}/hotels`, {
            method: 'DELETE',
            headers: {"content-type": "application/JSON"},
            body: JSON.stringify(body)
        });
    };

    const handleClick = () => {
        navigate('/modifyhotels', {
            state: {
                hotelId: hotelId,
                category: category,
                numRooms: numRooms,
                stAdr: stAdr,
                city: city,
                provOrState: provOrState,
                postOrZip: postOrZip,
                country: country,
                email: email
            }});
    };

    return (
        <div className="allHotelsCard" onClick={handleClick}>
            <p>Category: {category} </p>
            <p> Number of Rooms: {numRooms}</p>
            <p> Address: {stAdr}, {city}, {provOrState} {postOrZip}, {country}</p>
            <p> Email: {email}</p>
        </div>
    );
};

export default AllHotelsCard;