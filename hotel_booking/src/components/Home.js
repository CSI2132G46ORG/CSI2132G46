import Navbar from "./Navbar";
import SearchBar from "./Searchbar";

import './assets/styles/Home.css';
import Footer from "./Footer";
import { useState } from "react";
import useToken from "./useToken";

const Home = () => {
    const { token, setToken } = useToken();


    return (
        <div className="home">
            <Navbar token={token}/>
            <div>
                <h1>Enjoy The Best Hotels in North America</h1>
                <SearchBar/>
            </div>
            <Footer/>
        </div>
    );
};

export default Home;