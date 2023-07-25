import { SetStateAction, useEffect, useState } from 'react';
import { useAuthContext } from "@asgardeo/auth-react";
import { useParams } from "react-router-dom";
import { API, setAccessToken } from '../api';
import VisitDetailCard from '../components/schedules/VisitDetailCard';


const ViewActualVisit = () => {
    let { id } = useParams();
    let idString: string = id ? id.toString() : '';
    return (
        <div>
            <VisitDetailCard visitId={idString} />
        </div>
    );
};

export default ViewActualVisit;