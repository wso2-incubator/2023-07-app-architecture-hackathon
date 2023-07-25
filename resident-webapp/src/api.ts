import axios from 'axios'
import oauth from 'axios-oauth-client'

let accessToken: string = '';

export function setAccessToken(token: string) {
    accessToken = token;
}

export const API = axios.create({
    baseURL: 'https://1698d406-65dc-49be-b615-ab2451a002b1-dev.e1-us-east-azure.choreoapis.dev/qfxg/visit-service/visit-420/1.0.0'
   
});
