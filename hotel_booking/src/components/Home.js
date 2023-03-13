import Navbar from "./Navbar";
import SearchBar from "./Searchbar";

import './assets/styles/Home.css';
import Footer from "./Footer";

const Home = () => {
    return (
        <div className="home">
            {/* <Navbar/> */}
            <div>
                <SearchBar/>
            </div>
            {/* <Footer/> */}
        </div>
    );
};

export default Home;