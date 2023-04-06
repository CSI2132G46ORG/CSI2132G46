import Navbar from "./Navbar";
import SearchBar from "./Searchbar";

import './assets/styles/Home.css';
import Footer from "./Footer";
import { useState } from "react";
import useToken from "./useToken";

const Home = () => {
    const { token, setToken } = useToken();
    console.log(token);

    return (
        <div className="home">
            <Navbar token={token}/>
            <div>
                <h1>Enjoy The Best Hotels in North America</h1>
                <SearchBar/>
            </div>
            <Footer/>
            <div className="admin-link">
                <a href="/employeeLogin" className="btn btn-primary">Are you an Admin? Click Here</a>
            </div>
        </div>
    );
};

export default Home;