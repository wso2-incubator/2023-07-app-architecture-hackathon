import * as React from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import { Box, Typography } from '@mui/material';

const rows = [
    {
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
        "visitId": 0
    },
    // ... more rows here ...
];

export default function ScheduleList() {
    return (
        <Box sx={{ width: '100%' }}>
            <Typography variant="h4" component="div" gutterBottom>
                Visitors at the Gate
            </Typography>
            <TableContainer component={Paper}>
                <Table sx={{ minWidth: 650 }} aria-label="simple table">
                    <TableHead>
                        <TableRow>
                            <TableCell>In Time</TableCell>
                            <TableCell>Out Time</TableCell>
                            <TableCell>Visitor Name</TableCell>
                            <TableCell>Visitor NIC</TableCell>
                            <TableCell>Visitor Phone No</TableCell>
                            <TableCell>Vehicle Number</TableCell>
                            <TableCell>Visit Date</TableCell>
                            <TableCell>Is Approved</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {rows.map((row) => (
                            <TableRow key={row.visitId}>
                                <TableCell>{row.inTime}</TableCell>
                                <TableCell>{row.outTime}</TableCell>
                                <TableCell>{row.visitorName}</TableCell>
                                <TableCell>{row.visitorNIC}</TableCell>
                                <TableCell>{row.visitorPhoneNo}</TableCell>
                                <TableCell>{row.vehicleNumber}</TableCell>
                                <TableCell>{row.visitDate}</TableCell>
                                <TableCell>{row.isApproved ? "Yes" : "No"}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>
        </Box>
    );
}