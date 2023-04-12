import './assets/styles/EmployeePage.css';
import EmployeeButton from './EmployeeButton';
import useToken from './useToken';

const EmployeePage = () => {
    const { token, setToken } = useToken();


    return (
        <div className="employeePage">
                <h2>Employee Page</h2>
                <EmployeeButton title = "All Bookings" path ='/allbookings'/>
                <EmployeeButton title = "All Rentings" path ='/allrentings' />
                {/* <EmployeeButton title = "All Hotel Chains " path ='/allhotelchains' /> */}
                {/* <EmployeeButton title = "All Rooms"/> */}
                {/* <EmployeeButton title = "All Customers"/> */}

        </div>
    );
};

export default EmployeePage;