import axios from 'axios';

const API = axios.create({
    baseURL : "http://192.168.0.106:5124/api"
})

export default API;