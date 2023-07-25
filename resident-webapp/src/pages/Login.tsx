import { useState } from 'react';
import { useAuthContext } from "@asgardeo/auth-react";
import { Navigate } from "react-router-dom";
import { Button, Typography, Container, CircularProgress, Alert, Snackbar, Box } from '@mui/material';

const Login = () => {
    const { state, signIn, signOut } = useAuthContext();
    const [openError, setOpenError] = useState(false);

    const handleSignInClick = async (): Promise<void> => {
        try {
            await signIn();
            //setSignedIn(true);
        } catch (error) {
            //setOpenError(true);
        }
    }

    const handleSignOutClick = (): void => {
        signOut();
        //setSignedIn(false);
    }

    const handleClose = (event?: React.SyntheticEvent, reason?: string) => {
        if (reason === 'clickaway') {
            return;
        }
        setOpenError(false);
    };

    if (state.isAuthenticated) {
        return <Navigate to="/" />;
    }

    if (state.isLoading) {
        return (
            <Container maxWidth="sm" sx={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
                <CircularProgress />
            </Container>
        );
    }

    return (
        <Container maxWidth="sm" sx={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <Box sx={{ textAlign: 'center' }}>
                <img src='logo.jpg' alt='logo' width="200" />
                <Typography variant="h2" style={{ color: "#333" }}>Welcome Residents</Typography>
            </Box>
            <br />
            <Typography variant="h6">You have not signed in!</Typography>
            <Button variant="contained" color="primary" onClick={handleSignInClick}>Sign In</Button>
            <Snackbar open={openError} autoHideDuration={6000} >
                <Alert onClose={handleClose} severity="error">
                    Error occurred during Sign In!
                </Alert>
            </Snackbar>
        </Container>
    );
};

export default Login;
