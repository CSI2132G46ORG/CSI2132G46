import React, { useState } from 'react';
import './styles/SearchButton.css';

function SearchButton() {

    const handleSearchButtonClick = () => {
        console.log("Search button clicked");
      };
    
      return (
        <div className="search-button-container">
            <button className="search-button" onClick={handleSearchButtonClick}>Search</button>
        </div>
    
      );
    }
    
    export default SearchButton;