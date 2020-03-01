const fetch = require('node-fetch')
const firebase = require('../firebase')
const config = require('../config.json')
const admin = firebase.admin
const db = firebase.db

function getParams() {
    return {
        method: 'GET', 
        headers: {
            'Content-Type': 'application/json',
            'X-API-KEY': 'OA6BLGKP3psAdqiMEA8s6bt8x4vlyRZZ',
            'Authorization': 'Bearer kxbQSRF9Z2B7us8c10A02GtqGtGc'
        }
    }
}

module.exports = {
    async read(accountId) {
        let params = getParams()
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
    },

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
    }
}
