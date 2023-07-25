import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import { Box } from '@mui/material';

type Visit = {
    inTime: string;
    outTime: string;
    houseNo: string;
    visitorName: string;
    visitorNIC: string;
    visitorPhoneNo: string;
    vehicleNumber: string;
    visitDate: string;
    isApproved: boolean;
    comment: string;
    visitId: string;
};

interface VisitDetailCardProps {
    visit: Visit;
}

const VisitDetailCard: React.FC<VisitDetailCardProps> = ({ visit }) => {
    const approveVisit = () => {
        // Add code here to handle the approval of the visit
        console.log(`Visit ${visit.visitId} has been approved.`);
    };

    return (
        <Box>
            <Typography variant="h5" component="div">
                Visit Details
            </Typography>
            <Card sx={{ maxWidth: 400 }}>
                <CardContent>

                    <Typography>
                        In Time: {visit.inTime} <br />
                        Out Time: {visit.outTime} <br />
                        House No: {visit.houseNo} <br />
                        Visitor Name: {visit.visitorName} <br />
                        Visitor NIC: {visit.visitorNIC} <br />
                        Visitor Phone No: {visit.visitorPhoneNo} <br />
                        Vehicle Number: {visit.vehicleNumber} <br />
                        Visit Date: {visit.visitDate} <br />
                        Is Approved: {visit.isApproved ? "Yes" : "No"} <br />
                        Comment: {visit.comment} <br />
                        Visit Id: {visit.visitId}
                    </Typography>
                    <Button variant="contained" color="primary" onClick={approveVisit}>
                        Approve
                    </Button>
                </CardContent>
            </Card>
        </Box>
    );
};

export default VisitDetailCard;
