const admin = require('firebase-admin')
var serviceAccount = require("./eneek-67b61-firebase-adminsdk-zlgsz-54dac904d9.json");
const functions = require('firebase-functions')
var firebase

function getInstance() {
    if(!firebase) {
        firebase = {}
        admin.initializeApp({
            credential: admin.credential.cert(serviceAccount),
            databaseURL: "https://eneek-67b61.firebaseio.com"
        });
        firebase.admin = admin
        firebase.db = admin.firestore()
        firebase.functions = functions
    }
    return firebase
}

module.exports.admin = getInstance().admin
module.exports.db = getInstance().db
module.exports.functions = getInstance().functions