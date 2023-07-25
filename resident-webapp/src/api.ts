import axios from 'axios'
import oauth from 'axios-oauth-client'

// const getClientCredentials = oauth.clientCredentials(
//     axios.create(),
//     'https://sts.choreo.dev/oauth2/token',
//     '4Kw9b_nQah9INNfEba7rxK_qG3Ia',
//     'z2VHkLi9eOUAPQhKknyex1jvACAa'
// );

let accessToken: string = '';

export function setAccessToken(token: string) {
    accessToken = token;
}

// const getClientCredentials = oauth.clientCredentials(
//     axios.create(),
//     'https://sts.choreo.dev/oauth2/token',
//     'LfVhMqso5Ba5kOFiBMpN4zcPvlQa',
//     'twRntngofffPNfVKW7b_KL_Jveca'
// );


export const API = axios.create({
    //baseURL: 'https://ca90bad8-a13d-4960-826d-694284830e39-prod.e1-us-east-azure.choreoapis.dev/pzan/shipping/1.0.0'
    baseURL: 'https://run.mocky.io/v3/ed285f2c-1ce9-47ce-aaef-350e972131f0/test'
});

// API.interceptors.request.use(async (config) => {
//     //const accessToken = await getClientCredentials('');
//     //config.headers.Authorization = `Bearer ${accessToken.access_token}`;
//     config.headers.Authorization = `Bearer ${accessToken}`;
//     return config;
// });

// const axiosInstance = axios.create({
//     baseURL: 'http://localhost:9090/shipping',
// });
