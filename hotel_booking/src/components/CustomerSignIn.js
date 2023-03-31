import { useState } from 'react';
import { Link } from 'react-router-dom';
import SignInForm from './SignInForm';
import useToken from './useToken';

const Signin = () => {

   
    return (
        <div className="login">
            <SignInForm type={'customers'}/>
            <p>Don't have an account? <Link to='/signup'> Create one </Link></p>
        </div>
    );
    
    
};

export default Signin;