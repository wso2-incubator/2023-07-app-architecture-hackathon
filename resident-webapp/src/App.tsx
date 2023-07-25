import './App.css';
import { useState } from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider, useAuthContext } from "@asgardeo/auth-react";
import { TokenExchangePlugin } from "@asgardeo/token-exchange-plugin";
import Layout from "./pages/Layout";
import Dashboard from "./pages/Dashboard";

import NoPage from "./pages/NoPage";
import Login from './pages/Login';

const authConfig = {
    "baseUrl": "https://api.asgardeo.io/t/architecturemindmeld",
    "clientID": "kMMz9FOPufwyYOCw6GKWltS8XuMa",
    "scope": [
        "openid",
        "profile"
    ],
    "signInRedirectURL": "https://" + window.location.host + "/login",
    "signOutRedirectURL": "https://" + window.location.host + "/login",
}

function App() {

    return (
        <AuthProvider config={authConfig}>
            <BrowserRouter basename="/">
                <Routes>
                    <Route path="/login" element={<Login />} />
                    <Route path="/" element={<Layout />}>
                        <Route index element={<Dashboard />} />
                        <Route path="*" element={<NoPage />} />
                    </Route>
                </Routes>
            </BrowserRouter>
        </AuthProvider>
    );
}

export default App;
