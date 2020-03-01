const fetch = require('node-fetch')
const firebase = require('../firebase')
const config = require('../config.json')
const admin = firebase.admin
const db = firebase.db

function getParams(email, password) {
    return {
        method: 'POST', 
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify( {
            email: email,
            password: password,
            returnSecureToken: true
        } )
    }
}

module.exports = {
    async create(
        userId,
        phone_number,
        clabe
    ) {
        if(!phone_number) throw(Error('No phone number provided'))
        if(!clabe) throw(Error('No clabe provided'))

        let register_url = `${config.codi_url}/registroInicial`
        let params = {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify( {
                phone_number: phone_number,
                clabe: clabe
            } )
        }

        // LLamada a servicio de banxico
        /*const answer = await fetch(register_url, params)
        const codi_account_data = await answer.json()
        if (data.error) {
            throw ({
                code: data.error.code,
                message: data.error.message
            })
        }*/
        const codi_account_data = {
            id:  Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15)
        }

        let codi_account = await db.collection(`users/${userId}/codi_accounts`).add({
            id: codi_account_data.id,
            phone_number: phone_number
        })

        return {
            id: codi_account.id
        }
    },

    read: (userId, account_id) => {
        if(account_id){
            return db.doc(`users/${userId}/codi_accounts/${account_id}`).get()
        } else {
            return db.collection(`users/${userId}/codi_accounts`).get()
        }
    }
}
