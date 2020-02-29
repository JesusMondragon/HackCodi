const Firebase = require('./firebase')
const User = require('./repository/emtech/user')

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

        executeMethod = User.signin(
            request.body.email,
            request.body.password,
            request.body.device_alias,
            request.body.check_digit,
            request.body.device_id,
            request.body.device_os,
            request.body.device_os_version,
            request.body.device_manufacturer,
            request.body.device_model,
            request.body.project_token,
            request.body.hmac,
            request.body.certification_identifier,
            parseInt(request.body.timestamp),
            request.body.hash
        )
        .then((user) => response.status(200).send(user))
        
        break
    case '/signup':
        if(request.method != 'POST') return response.status(404).send()
        executeMethod = User.signup(
            request.body.email,
            request.body.password
        )
            .then((token) => response.status(200).send(token))
        break;
    case '': {
            if(!request.headers.auth) return response.status(403).send()
            let verifyUser = _Firebase.admin.auth().verifyIdToken(request.headers.auth)
        
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
            let code = Error.validate(error)
            return response.status(code).send({code: 400, description: error})
        })
});

exports.accounts = functions.https.onRequest((request, response) => {
    
});
