import './assets/styles/EmployeePage.css';
import EmployeeButton from './EmployeeButton';
import useToken from './useToken';

const EmployeePage = () => {
    const { token, setToken } = useToken();


    return (
        <div className="employeePage row">
            <div className="col-1-of-2">
                <EmployeeButton title = "All Bookings" path ='/allbookings' employeeId={token.id} />
                {/* <EmployeeButton title = "All Hotel Chains " path ='/allhotelchains' /> */}
                {/* <EmployeeButton title = "All Rooms"/> */}
                {/* <EmployeeButton title = "All Customers"/> */}
            </div>
            <div className="col-2-of-2">
                
            </div>
        </div>
    );
};

export default EmployeePage;