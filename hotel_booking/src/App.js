import './App.css';
import  { BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Home from './components/Home.js';
import CheckInOut from './components/CheckInOut';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route exact path='/reservio' element = {<Home/>}/>
          <Route path='/checkinout' element={<CheckInOut/>}/>
        </Routes>
      </div>
    </Router>
  );
}

export default App;
