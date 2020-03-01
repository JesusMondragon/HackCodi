const Firebase = require('./firebase')
const User = require('./repository/user')
const BankAccount = require('./repository/bank_account')
const CodiAccount = require('./repository/codi_account')
const CyberSourcePayments = require('./repository/cybersource')
const Charge = require('./repository/charge')

const functions = Firebase.functions
const admin = Firebase.admin

function setCors(request, response) {
    response.set('Access-Control-Allow-Origin', '*');
    if (request.method === 'OPTIONS') {
        response.set('Access-Control-Allow-Methods', 'GET, POST, PUT');
        response.set('Access-Control-Allow-Headers', 'Content-Type, auth');
        response.set('Access-Control-Max-Age', '3600');
        response.status(204).send('')
    }
}

exports.users = functions.https.onRequest((request, response) => {
    setCors(request, response)

    let executeMethod
    
    switch (request.path) {
    case '/signin':
        if(request.method != 'POST') return response.status(404).send()

        executeMethod = User.signin(request.body.email, request.body.password)
            .then((user) => response.status(200).send(user))
        
        break
    case '/signup':
        if(request.method != 'POST') return response.status(404).send()
        executeMethod = User.signup(request.body.email, request.body.password)
            .then((token) => response.status(200).send(token))
        break;
    case '': {
            if(!request.headers.auth) return response.status(403).send()
            let verifyUser = admin.auth().verifyIdToken(request.headers.auth)
        
            switch(request.method) {
            case 'GET':
                executeMethod = verifyUser
                    .then((decodedToken) => User.get(decodedToken.uid))
                    .then((user) => response.status(200).send(user))
        
                break;
            case 'PUT':
                executeMethod = verifyUser
                    .then((decodedToken) => User.update(decodedToken.uid, request.body))
                    .then(() => response.status(200).send())
                break;
            default:
                return response.status(404).send()
            }
        }
        break;
    default:
        return response.status(404).send()
    }
    
    return executeMethod
        .catch((error) => {
            console.log(error);
            return response.status(400).send({code: 400, description: 'wrong parameters'})
        })
});

exports.bank_accounts = functions.https.onRequest((request, response) => {
    if(!request.headers.auth) return response.status(403).send()
    let verifyUser = admin.auth().verifyIdToken(request.headers.auth)
        
    switch(request.method) {
    case 'POST':
        executeMethod = verifyUser
            .then((decodedToken) => BankAccount.create(
                decodedToken.uid,
                request.body.name,
                request.body.lastname,
                request.body.phone_number,
                request.body.provider
            ))
            .then((user) => response.status(200).send(user))

        break;
    case 'GET':
        executeMethod = verifyUser
            .then((decodedToken) => BankAccount.read(
                decodedToken.uid,
                request.body.account_id
            ))
            .then((user) => response.status(200).send(user))

        break;
    default:
        return response.status(404).send()
    }

    return executeMethod.catch((error) => {
        console.log(error);
        return response.status(400).send()
    })
});

exports.codi_accounts = functions.https.onRequest((request, response) => {
    if(!request.headers.auth) return response.status(403).send()
    let verifyUser = admin.auth().verifyIdToken(request.headers.auth)
    switch(request.method) {
    case 'POST':
        executeMethod = verifyUser
            .then((decodedToken) => CodiAccount.create(
                decodedToken.uid,
                request.body.phone_number,
                request.body.clabe
            ))
            .then((user) => response.status(200).send(user))

        break;
    case 'GET':
        executeMethod = verifyUser
            .then((decodedToken) => CodiAccount.read(
                decodedToken.uid,
                request.body.account_id
            ))
            .then((user) => response.status(200).send(user))

        break;
    default:
        return response.status(404).send()
    }

    return executeMethod.catch((error) => {
        console.log(error);
        return response.status(400).send()
    })
});

exports.charges = functions.https.onRequest((request, response) => {
    if(!request.headers.auth) return response.status(403).send()
    let verifyUser = admin.auth().verifyIdToken(request.headers.auth)

    if(request.method != 'POST') return response.status(404).send()

    switch(request.path) {
    case '/generate':
        executeMethod = verifyUser
            .then((decodedToken) => Charge.generate(
                decodedToken.uid,
                request.body.amoun,
                request.body.concept,
                request.body.reference,
                request.body.mode
            ))
            .then((user) => response.status(200).send(user))

        break;
    case '/send':
        executeMethod = verifyUser
            .then((decodedToken) => CodiAccount.read(
                decodedToken.uid,
                request.body.amoun,
                request.body.concept,
                request.body.reference,
            ))
            .then((user) => response.status(200).send(user))

        break;
    default:
        return response.status(404).send()
    }

    return executeMethod.catch((error) => {
        console.log(error);
        return response.status(400).send()
    })
});

exports.payments = functions.https.onRequest((request, response) => {
    if(!request.headers.auth) return response.status(403).send()
    let verifyUser = admin.auth().verifyIdToken(request.headers.auth)

    if(request.method != 'POST') return response.status(404).send()

    switch(request.method) {
    case 'POST':
        executeMethod = verifyUser
            .then((decodedToken) => CyberSourcePayments.standaloneHttpSignature((result) => {
                return response.status(200).send(result)
            }))

        break;
    default:
        return response.status(404).send()
    }

    return executeMethod.catch((error) => {
        console.log(error);
        return response.status(400).send()
    })
})


