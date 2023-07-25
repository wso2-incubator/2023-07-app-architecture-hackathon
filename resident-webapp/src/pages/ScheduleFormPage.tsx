import { SetStateAction, useEffect, useState } from 'react';
import { useAuthContext } from "@asgardeo/auth-react";
import { API, setAccessToken } from '../api';
import ScheduleForm from '../components/schedules/ScheduleForm';

const ScheduleFormPage = () => {

    return (
        <div>
            <ScheduleForm />
        </div>
    );
};

export default ScheduleFormPage;