import fetch from 'node-fetch';
import * as Constants from './constants';

export default class Service {
    static instance = null;
    token = '';

    static getInstance() {
        if (!this.instance) {
            this.instance = new Service();
        }
        return this.instance;
    }

    login(username, password, cb) {
        const payload = {'username': username, 'password': password}
        fetch(Constants.URL + Constants.ENDPOINT_AUTHENTICATION, {
            method: Constants.METHOD_POST,
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(payload)
        }).then((response) => {
            return response.json();
        }).then((body) => {
            if (!body.success) {
                cb(false);
            }
            this.token = body.token
            cb(true, body.user);
        });
    }
}