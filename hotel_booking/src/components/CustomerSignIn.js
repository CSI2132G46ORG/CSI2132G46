import { useState } from 'react';
import { Link } from 'react-router-dom';
import './assets/styles/SignInForm.css'
import SignInForm from './SignInForm';
import useToken from './useToken';

const Signin = () => {
    const [username, setEmail] = useState();
    const [password, setPassword] = useState();
    const { token, setToken } = useToken();

    if(!token){
        return (
            <div className="login">
                <SignInForm type={'customers'}/>
                <p>Don't have an account? <Link to='/signup'> Create one </Link></p>
            </div>
        );
    }
    else {
        console.log('token ', token);

        return(
            <div>
                <h1>You're connected</h1>
            </div>
        );
    }
    
};

export default Signin;