import { useState } from 'react';
import { Link } from 'react-router-dom';
import './assets/styles/SignIn.css'

const Signin = () => {
    // const [token, setToken] = useState();
    const [username, setEmail] = useState();
    const [password, setPassword] = useState();


    async function loginUser(credentials) {
        return fetch('http://localhost:5000/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(credentials)
        })
          .then(data => data.json())
    }

    function setToken(userToken) {
        sessionStorage.setItem('token', JSON.stringify(userToken));
    }

    function getToken() {
        const tokenString = sessionStorage.getItem('token');
        const userToken = JSON.parse(tokenString);
        return userToken?.token
    }

    const handleSubmit  = async e => {
        e.preventDefault();
        const token = await loginUser({
            username,
            password
          });
        setToken(token);
    };
    
    const token = getToken();


    if(!token){
        return (
            <div className="login">
                <form onSubmit={handleSubmit}>
                    <h1>Sign in</h1>
                    <input type="email" placeholder='Email address' onChange={e => setEmail(e.target.value)} required/>
                    <input type="password" placeholder='password' onChange={e => setPassword(e.target.value)} required/>
                    <input type="submit" value="sign in"/>
                </form>
                <p>Don't have an account? <Link to='/signup'> Create one </Link></p>
            </div>
        );
    }
    else{
        return(
            <div>
                <h1>You're connected</h1>
            </div>
        );
    }
    
};

export default Signin;