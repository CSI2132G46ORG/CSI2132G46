import './App.css';
import  { BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Home from './Home.js';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route exact path='/reservio' element = {<Home/>}/>
        </Routes>
      </div>
    </Router>
  );
}

export default App;
