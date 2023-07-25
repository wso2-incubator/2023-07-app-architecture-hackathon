import { SetStateAction, useEffect, useState } from 'react';
import { useAuthContext } from "@asgardeo/auth-react";
import { useParams } from "react-router-dom";
import { API, setAccessToken } from '../api';
import VisitDetailCard from '../components/schedules/VisitDetailCard';


const ViewActualVisit = () => {
    let { id } = useParams();

    const example = {
        "inTime": "string",
        "outTime": "string",
        "houseNo": "string",
        "visitorName": "string",
        "visitorNIC": "string",
        "visitorPhoneNo": "string",
        "vehicleNumber": "string",
        "visitDate": "string",
        "isApproved": true,
        "comment": "string",
        "visitId": "0"
    };

    return (
        <div>
            <VisitDetailCard visit={example} />
        </div>
    );
};

export default ViewActualVisit;