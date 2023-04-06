import { useState } from 'react';
import './assets/styles/RoomCard.css';

const RoomCard = (props) => {
  const [roomNumber, setroomNumber] = useState(props.roomNumber);
  const [price, setprice] = useState(props.price);
  const [capacity, setcapacity] = useState(props.capacity);
  const [view, setview] = useState(props.view);
  const [extended, setextended] = useState(props.extended);
  const [problems, setproblems] = useState(props.problems);
  const [amenities, setamenities] = useState(props.amenities);

  const handlePayLater = () => {
    props.handlePayButtonClick(false,props,amenitiesToSend);
  };
  
  const handlePayOnline = () => {
    props.handlePayButtonClick(true,props,amenitiesToSend);
  };

  const amenitiesToSend = amenities.map((amenity) => amenity.amenity).join(', ');

  return (
    <div className="roomCard">
      <h3>Room {roomNumber} &nbsp;&nbsp;</h3>
      <p>
        <br />
        <br />
        <br />
        Price: {price} &nbsp;&nbsp;
      </p>
      <p>
        <br />
        <br />
        <br />
        Capacity: {capacity}&nbsp;&nbsp;
      </p>
      <p>
        <br />
        <br />
        <br />
        View: {view}&nbsp;&nbsp;
      </p>
      <p>
        <br />
        <br />
        <br />
        Extended: {extended ? 'Yes' : 'No'}&nbsp;&nbsp;
      </p>
      <p>
        <br />
        <br />
        <br />
        Problems: {problems ? 'Yes' : 'No'}&nbsp;&nbsp;
      </p>
      {amenities.length > 0 && (
        <p>
          <br />
          <br />
          <br />
          Amenities: {amenitiesToSend}&nbsp;&nbsp;
        </p>
      )}
      <button onClick={handlePayLater}>Pay Later</button>
      <button onClick={handlePayOnline}>Pay Online</button>
    </div>
  );
};

export default RoomCard;
