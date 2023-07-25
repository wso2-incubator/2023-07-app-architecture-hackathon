import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import { Box } from '@mui/material';
import { API } from '../../api';
import { useEffect, useState } from 'react';
import { useAuthContext } from "@asgardeo/auth-react";
import { ActualVisit } from "../../types/domain";


interface VisitDetailCardProps {
    visitId: string;
}

const VisitDetailCard: React.FC<VisitDetailCardProps> = ({ visitId }) => {
    const [scheduleVisit, setScheduleVisit] = useState<ActualVisit | undefined>(undefined);
    const { getAccessToken } = useAuthContext();


    async function getVisit() {
        const accessToken = await getAccessToken();
        console.log(accessToken);
        let url: string = '/actualVisits/' + visitId;
        API.get(url, {
            headers: {
                Authorization: `Bearer ${accessToken}`
            }
        })
            .then((response) => {
                console.log(response);
                setScheduleVisit(response.data);
            })
            .catch((error) => {
                console.log(error);
            });
    }

    useEffect(() => {
        if (scheduleVisit === undefined) {
            getVisit();
        }
    }, [scheduleVisit]);


    const approveVisit = () => {
        // Add code here to handle the approval of the visit
        console.log(`Visit ${visitId} has been approved.`);
    };

    return (
        <Box>
            <Typography variant="h5" component="div">
                Visit Details
            </Typography>
            {scheduleVisit &&
                <Card sx={{ maxWidth: 400 }}>
                    <CardContent>
                        <Typography>
                            In Time: {scheduleVisit.inTime} <br />
                            Out Time: {scheduleVisit.outTime} <br />
                            House No: {scheduleVisit.houseNo} <br />
                            Visitor Name: {scheduleVisit.visitorName} <br />
                            Visitor NIC: {scheduleVisit.visitorNIC} <br />
                            Visitor Phone No: {scheduleVisit.visitorPhoneNo} <br />
                            Vehicle Number: {scheduleVisit.vehicleNumber} <br />
                            Visit Date: {scheduleVisit.visitDate} <br />
                            Is Approved: {scheduleVisit.isApproved ? "Yes" : "No"} <br />
                            Comment: {scheduleVisit.comment} <br />
                            Visit Id: {scheduleVisit.visitId}
                        </Typography>
                        {scheduleVisit.isApproved === false &&
                            <Button variant="contained" color="primary" onClick={approveVisit}>
                                Approve
                            </Button>
                        }
                    </CardContent>
                </Card>
            }
            {scheduleVisit === undefined && <Typography variant="h6" component="div">Not Found</Typography>}
        </Box>
    );
};

export default VisitDetailCard;
