const fetch = require('node-fetch')
const firebase = require('../../firebase')
const config = require('../../config.json')
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
        phone_number
    ) {
        if(!phone_number) throw('No phone number provided')

        let register_url = `${config.codi_url}/register`
        let params = {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify( {
                phone_number: phone_number
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
            id: "adfdsafwqfw"
        }

        let codi_account = await db.collection(`users/${userId}/codi_accounts`).set({
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
    },

    update: (userId, account_id, data) => db.doc(`users/${userId}/codi_accounts/${account_id}`).update({info: data}),

    delete: (userId, account_id) => db.doc(`users/${userId}/codi_accounts/${account_id}`).get().update({enabled: false})
}
