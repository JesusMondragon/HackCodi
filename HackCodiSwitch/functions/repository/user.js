const fetch = require('node-fetch')
const firebase = require('../../firebase')
const condig = require('../../config.json')
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
        password,
        device_alias,
        check_digit,
        device_id,
        device_os,
        device_os_version,
        device_manufacturer,
        device_model,
        project_token,
        hmac,
        certification_identifier,
        timestamp,
        hash
    ) {
        let url = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAsoN34jDSGWbvuu5UrKdJmBSqwxeZ-ztE`
    
        if(!email) throw('No email provided')
        if(!password) throw('No password provided')
        if(!device_alias) throw('No device alias provided')
        if(check_digit == null) throw('No check digit provided')
        if(!device_id) throw('No device id provided')
        if(!device_os) throw('No device os provided')
        if(!device_os_version) throw('No device os version provided')
        if(!device_manufacturer) throw('No device manufacturer provided')
        if(!device_model) throw('No device model provided')
        if(!project_token) throw('No project token provided')
        if(!hmac) throw('No hmac provided')
        if(!certification_identifier) throw('No certification identifier provided')
        if(!timestamp) throw('No timestamp provided')
        if(!hash) throw('No hash provided')
    
        let params = getParams(email, password)
        const answer = await fetch(url, params)
    
        const data = await answer.json()
    
        if (data.error) throw (data.error)
    
        const decodedToken = await admin.auth().verifyIdToken(data.idToken)
        const doc = await db.doc(`users/${decodedToken.uid}`).get()
        
        let user = {
            token: data.idToken,
            id: decodedToken.uid,
            check_digit: codi_answer.dv,
            default_check_digit: codi_answer.dvOmision,
            profile: doc.data().profile? doc.data().profile: {},
            scheme: doc.data().scheme? doc.data().scheme: {}
        }
        return user
    },

    get: (userId) => db.doc(`users/${userId}`).get().then((doc) => doc.profile),

    update: (userId, data) => db.doc(`users/${userId}`).update({profile: data})
}
