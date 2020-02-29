const fetch = require('node-fetch')
const firebase = require('../../firebase')
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
    async signup(email, password) {
        if(!email) throw('No email provided')
        if(!password) throw('No password provided')

        let emtech_url = `https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${config.g_key}`
        let params = getParams(email, password)
        const answer = await fetch(emtech_url, params)
        const data = await answer.json()
        if (data.error) {
            throw ({
                code: data.error.code,
                message: data.error.message
            })
        }

        let user = await db.doc(`users/${data.localId}`).set({
            profile: {
                email: email
            }
        })

        return {
            token: data.idToken,
            id: data.localId
        }
    },

    async signin(
        email,
        password
    ) {
        let url = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAsoN34jDSGWbvuu5UrKdJmBSqwxeZ-ztE`
    
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

    update: (userId, data) => db.doc(`users/${userId}`).update({profile: data})
}
