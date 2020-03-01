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

        let url = `${config.hsbc_url}/hsbc.02.hk.hsbc/accounts`
        let params = {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `DirectLogin token="${config.hsbc_token}"`
            },
            body: JSON.stringify({
                "user_id": `${config.hsbc_user}`,
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
        
        const answer = await fetch(url, params)
        const data = await answer.json()
        if (data.error) {
            throw ({
                code: data.error.code,
                message: data.error.message
            })
        }

        return data
    },

    async read() {
        let url = `${config.hsbc_url}/users/current`
        let params = {
            method: 'GET', 
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `DirectLogin token="${config.hsbc_token}"`
            },
        }
        const answer = await fetch(url, params)
    
        const data = await answer.json()
    
        if (data.error) throw (data.error)
    

        return data
    },
    
    async getTransactions() {
        let params = {
            method: 'GET', 
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `DirectLogin token="${config.hsbc_token}"`
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
