import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './assets/styles/SearchButton.css';

function SearchButton(props) {
      // const [checkInDate, setCheckInDate] = useState(null);
      // const [checkOutDate, setCheckOutDate] = useState(null);
      // const [numPeople, setNumPeople] = useState(1);

      const navigate = useNavigate();

      const handleSearchButtonClick = (e) => {
        
        console.log("Search button clicked");

        if(window.location.pathname==="/checkinout"){
          setTimeout((e) => {
            navigate("/filter", {state: {
                checkIn: props.checkInDate,
                checkOut: props.checkOutDate,
                ppl: props.numPeople
            }});
          }, 200);
        }
        else if (window.location.pathname==="/filter") {
          e.preventDefault();
          props.updateDates();

        }

        
        
      };
    
      return (
        <div className="search-button-container">
            <button className="search-button" onClick={handleSearchButtonClick}>Search</button>
        </div>
    
      );
    }
    
    export default SearchButton;