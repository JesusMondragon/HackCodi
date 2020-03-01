const firebase = require('../firebase')
const genteraClient = require('./gentera') 
const hsbcClient = require('./hsbc') 
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
    async create(userId, name, lastname, phoneNumber, provider) {
        let accountResult = null
        if(provider == 'HSBC') {
             accountResult = await hsbcClient.create(name, lastname, phoneNumber)
        } 

        accountResult = await genteraClient.create(name, lastname, phoneNumber)

        if(!accountResult) throw ('No provider')

        console.log(accountResult)

        let bank_account = await db.collection(`users/${userId}/bank_accounts`).add({
            account_id: accountResult.Level2AccountCreationDataResponse.BankAccountContractID
        })
        
        return {
            account_id: accountResult.Level2AccountCreationDataResponse.BankAccountContractID
        }
    },

    get: (userId, accountId) => {
        if(accountId) {
            return db.doc(`users/${userId}/bank_accounts/${accountId}`).get().then((doc) => doc.info)
        }

        return db.doc(`users/${userId}/bank_accounts`).get()
    }
}
