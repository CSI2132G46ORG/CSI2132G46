import { useState } from 'react';
import './assets/styles/HotelCard.css';

const HotelCard = (props) => {
    const [title, setTitle] = useState(props.title);
    const [price, setPrice] = useState(props.price);
    const handleHotelCardClick = () => {
        props.handleHotelCardClick(true,props);
      };
    return (
        <div className="hotelCard">
            <h3>{title}</h3>
            $<p>{price}</p>
            <button onClick={handleHotelCardClick}>Select Hotel</button>
        </div>
    );
};

export default HotelCard;