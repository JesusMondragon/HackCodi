const fetch = require('node-fetch')
const firebase = require('../firebase')
const config = require('../config.json')
const admin = firebase.admin
const db = firebase.db


module.exports = {
    async create(name, lastname, phoneNumber) {
        if(!name) throw('No name provided')
        if(!lastname) throw('No lastname provided')
        if(!phoneNumber) throw('No phone number provided')

        let url = `${config.hsbc_url}/account/businesspartners/level2account`
        let params = {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'DirectLogin token="eyJhbGciOiJIUzI1NiJ9.eyIiOiIifQ.K8IE_ZoqEvPtwda2ZoGNL-8N9Gn1VQicpJ4CbXOTN1c"'
            },
            body: JSON.stringify({
                "user_id": "e843d7f9-73b5-4c44-b30f-e57058e6daaf",
                "label": phoneNumber,
                "product_code": "AC",
                "balance": {
                    "currency": "EUR",
                    "amount": "0"
                },
                "branch_id": "DERBY6",
                "account_routing": {
                    "scheme": "AccountNumber",
                    "address": "4930396"
                },
                "account_attributes": [
                    {
                        "product_code": "saving1",
                        "account_attribute_id": "613c83ea-80f9-4560-8404-b9cd4ec42a7f",
                        "name": "OVERDRAFT_START_DATE",
                        "type": "DATE_WITH_DAY",
                        "value": "2012-04-23"
                    }
                ]
            })
        }

        let body = getBody(name, lastname, phoneNumber, availableFolio)
        
        /*const answer = await fetch(emtech_url, params)
        const data = await answer.json()
        if (data.error) {
            throw ({
                code: data.error.code,
                message: data.error.message
            })
        }*/

        let data = {
            "account_id": "c0115389-03fa-4c46-8760-bfcc9ccf5b98",
            "user_id": "e843d7f9-73b5-4c44-b30f-e57058e6daaf",
            "label": "My Account 2",
            "product_code": "AC",
            "balance": {
                "currency": "EUR",
                "amount": "0.00"
            },
            "branch_id": "DERBY6",
            "account_routings": [
                {
                    "scheme": "AccountNumber",
                    "address": "4930396"
                }
            ],
            "account_attributes": []
        }


        return data
    },

    async read(
    ) {
        let url = `${config.gentera_url}/account/businesspartners/level2account`
    
        if(!email) throw('No email provided')
        if(!password) throw('No password provided')
    
        let params = getParams(email, password)
        const answer = await fetch(url, params)
    
        const data = await answer.json()
    
        if (data.error) throw (data.error)
    
        const decodedToken = await admin.auth().verifyIdToken(data.idToken)
        const doc = await db.doc(`users/${decodedToken.uid}`).get()
        
        let user = {
            token: data.idToken,
            id: decodedToken.uid,
            check_digit: 0,
            default_check_digit: 0,
            profile: doc.data().profile? doc.data().profile: {},
            scheme: doc.data().scheme? doc.data().scheme: {}
        }
        return user
    },

    get: (userId) => db.doc(`users/${userId}`).get().then((doc) => doc.profile),

    update: (userId, data) => db.doc(`users/${userId}`).update({profile: data}),

    async generateAccess() {
        let url = `https://dev.apilab.gentera.com.mx/v3/oauth/accesstoken`
        let params = getParams({
            "GrantType": "client_credentials",
	        "ClientSecret": "2Vw1H2fi55BqeZnX"
        })
        const answer = await fetch(url, params)
        const data = await answer.json()
    
        if (data.error) throw (data.error)

        if(!data.accessToken) throw ('Error token')
    },

    async getTransactions() {
        let params = {
            method: 'GET', 
            headers: {
                'Content-Type': 'application/json',
                'X-API-KEY': 'OA6BLGKP3psAdqiMEA8s6bt8x4vlyRZZ',
                'Authorization': 'Bearer kxbQSRF9Z2B7us8c10A02GtqGtGc'
            }
        }
        let url = `${config.gentera_url}/${accountId}/transactions`
        
        const answer = await fetch(url, params)
        const data = await answer.json()
        if (data.error) {
            throw ({
                code: data.error.code,
                message: data.error.message
            })
        }

        if(data.code != '00') throw('Bad bank service answer')

        return data.data
    }
}
