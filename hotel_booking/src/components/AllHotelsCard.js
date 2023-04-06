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
    const [hotelChainId, setHotelChainId] = useState(props.hotelChainId);
    const navigate = useNavigate();
    const port = 5100;


    const deleteHotel = () => {
        if (window.confirm('Are you sure you want to delete')) {
            console.log('confirmed')
            const body = {hotelId};
            console.log(body);
            fetch(`http://localhost:${port}/hotels`, {
                method: 'DELETE',
                headers: {"content-type": "application/JSON"},
                body: JSON.stringify(body)
            });
        }

        else {

        }
        
    };

    const handleClick = () => {
        
        console.log('handleClick');
        
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
                email: email,
                hotelChainId: hotelChainId
            }});
        
    };

    return (
        <div className="allHotelsCard">
            <p><b>Category: </b> {category} </p>
            <p><b>Number of Rooms:</b>  {numRooms}</p>
            <p><b>Address:</b>  {stAdr}, {city}, {provOrState} {postOrZip}, {country}</p>
            <p><b>Email:</b>  {email}</p>
            <div className='cardBlock'>
                <div onClick={deleteHotel}><img src={require('./assets/img/trash.png')} alt='trash image' /></div>
                <div style={{display: 'block', textDecoration: 'underline'}} onClick={handleClick}>Modify Hotel</div>
            </div>
        </div>
    );
};

export default AllHotelsCard;