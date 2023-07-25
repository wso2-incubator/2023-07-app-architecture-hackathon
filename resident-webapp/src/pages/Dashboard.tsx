import { SetStateAction, useEffect, useState } from 'react';
import { useAuthContext } from "@asgardeo/auth-react";
import { API, setAccessToken } from '../api';
import ScheduleList from '../components/schedules/ScheduleList';
import ActualVisits from '../components/schedules/ActualVisits';

const Dashboard = () => {

    return (
        <div>
            <ScheduleList />
            <br />
            <ActualVisits />
        </div>
    );
};

export default Dashboard;