import { useState } from 'react';
import './assets/styles/HotelCard.css';

const HotelCard = (props) => {
    const [title, setTitle] = useState(props.title);
    const [price, setPrice] = useState(props.price);
    const [hotelId, setHotelId] = useState(props.hotelId);
    const address = `${props.stAd}, ${props.city}, ${props.provOrState} ${props.postOrZip}, ${props.country}`;

    const handleHotelCardClick = () => {
        props.handleHotelCardClick(true,props);
      };
    
    return (
        <div className="hotelCard" onClick={handleHotelCardClick}>
            <p><b>{title}</b></p>
            <p><b>Address:</b> {address}</p>
            <p><b>Price: </b>$ {price}</p>
            {/* <button onClick={handleHotelCardClick}>Select Hotel</button> */}
        </div>
    );
};

export default HotelCard;