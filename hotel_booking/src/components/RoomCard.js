import './assets/styles/RoomCard.css';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';


const RoomCard = (props) => {

    const [roomNumber, setRoomNumber] = useState(props.roomNumber);
    const [hotelId, setHotelId] = useState(props.hotelId);
    const [price, setPrice] = useState(props.price);
    const [capacity, setCapacity] = useState(props.capacity);
    const [view, setView] = useState(props.view);
    const [extended, setExtended] = useState(props.extended);
    const [problems, setProblems] = useState(props.problems);
    const port = 5100;
    const navigate = useNavigate();


    const deleteRoom = () => {
        const body = {roomNumber, hotelId};
        console.log(body);
        fetch(`http://localhost:${port}/rooms`, {
            method: 'DELETE',
            headers: {"content-type": "application/JSON"},
            body: JSON.stringify(body)
        });
    };

    const handleClick = () => {
        navigate('/modifyrooms', {
            state: {
                roomNumber: roomNumber,
                hotelId: hotelId,
                price: price,
                capacity: capacity,
                view: view,
                extended: extended,
                problems: problems
            }
        });

    };
    return (
        <div className='roomCard' onClick={handleClick}>
            <p>Room number: {roomNumber}</p>
            <p>Capacity: {capacity}</p>
            <p>View: {view}</p>
            <p>Extended: {extended}</p>
            <p>Problems: {problems}</p>
        </div>
    );
};

export default RoomCard;