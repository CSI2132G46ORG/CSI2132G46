import './assets/styles/Filter.css';
import DatePickers from './DatePicker.js';
import Navbar from './Navbar.js';
import PeoplePicker from './PeoplePicker.js';
import SearchButton from './SearchButton.js';

const Filter = () => {
    return (
        <div className='filterpage'>
            <Navbar/>
            <div>
            <DatePickers />
            <PeoplePicker />
            <SearchButton />
            </div>
        </div>
    );
};

export default Filter;