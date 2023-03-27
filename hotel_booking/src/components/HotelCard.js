import { useState } from 'react';
import './assets/styles/HotelCard.css';

const HotelCard = (props) => {
    const [title, setTitle] = useState(props.title);
    const [price, setPrice] = useState(props.price);
    return (
        <div className="hotelCard">
            <h3>{title}</h3>
            <p>{price}</p>
        </div>
    );
};

export default HotelCard;