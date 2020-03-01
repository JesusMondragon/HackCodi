const fetch = require('node-fetch')
const firebase = require('../firebase')
const config = require('../config.json')
const admin = firebase.admin
const db = firebase.db


function getBody(name, lastname, phoneNumber, folio) {
    return  {
        "UUID":"61bb1f5e-7cc6-4b15-a2ef-dfb454ba373d",
        "Identifiers":{
           "ServiceOfficeID":"2987",
           "CommerceID":"J211",
           "OriginID":"Z06"
        },
        "BusinessPartnerCreateLevel2AccountData":{
           "NameData":{
              "GivenName": name,
              "MiddleName": lastname,
              "FamilyName":"Gonzalez",
              "AditionalFamilyName":"Herrera"
           },
           "BirthDate":"1995-05-15",
           "Gender":"0",
           "DocumentIdentifiers":{
              "Code":"ZCVELE",
              "ID":"ARMNJR92120714H700"
           },
           "CardIdentification": folio,
           "RegionBirth":"DF",
           "BirthCountryCode":"MX",
           "CitizenshipCode":"MX",
           "PhoneData":{
              "PhoneTypeID":"6",
              "PhoneNumber":{
                 "SubscriberID": phoneNumber
              }
           },
           "AddressData":{
              "AddressTypeCode":"XXDEFAULT",
              "StreetName":"Canela",
              "CountryCode":"MX",
              "RegionCode":"DF",
              "CityName":"Mexico",
              "DistrictName":"Iztacalco",
              "AdditionalCityName":"Granjas Mexico",
              "StreetPostalCode":"08400",
              "HouseID":"484",
              "AdditionalHouseID":"C-203"
           }
        }
     }
}

function getParams(body) {
    return {
        method: 'POST', 
        headers: {
            'Content-Type': 'application/json',
            'X-API-KEY': 'OA6BLGKP3psAdqiMEA8s6bt8x4vlyRZZ',
            'Authorization': 'Bearer nvCKrTetqeAxFLPhXe7ioxlSCSDd' 
        },
        body: JSON.stringify(body)
    }
}

module.exports = {
    async create(name, lastname, phoneNumber) {
        if(!name) throw new Error('No name provided')
        if(!lastname) throw new Error('No lastname provided')
        if(!phoneNumber) throw new Error('No phone number provided')

        let url = `${config.gentera_url}/account/businesspartners/level2account`
        let folios = await db.collection(`folios`).get()

        let availableFolio = null
        folios.forEach(folio => availableFolio = folio.data().enabled? folio.id: availableFolio)
        
        if(availableFolio)
            console.log(availableFolio);
        else 
            throw new Error('No more folios')

        let body = getBody(name, lastname, phoneNumber, availableFolio)
        console.log(body);
        
        let params = getParams(body)
        console.log(params);
        
        const answer = await fetch(url, params)

        console.log(answer)
        const data = await answer.json()
        console.log(data)
        if (data.error) {
            throw new Error(ata.error.message)
        }

        await db.doc(`folios/${availableFolio}`).update({enabled: false})

        

        /*let data = {
            MessageHeader: {
                UUID: "E6FEE872-D102-1EDA-96EA-AFEA205700A1",
                CreationDateTime: "2020-03-01T00:42:15Z",
                SenderBusinessSystemID: "BS_SAP_CRM_DEV",
                SenderParty: {
                    ContactPerson: {
                        "InternalID": "RFCPOD"
                    }
                }
            },
            Level2AccountCreationDataResponse: {
                BusinessPartnerIDCreated: "0073215632",
                CLABEAccount: 130420002000832030,
                OpportunityID: "0102140529",
                BankAccountContractID: "00200083203"
            },
            Log: {
                BusinessDocumentProcessingResultCode: 3,
                Item: {
                    TypeID: "Servicios Digitales",
                    SeverityCode: 1,
                    ReferenceObjectNodeSenderTechnicalID: "0102140529",
                    Note: "No fue posible dar de alta al cliente en Servicios Digitales"
                }
            }
        }
*/
        if(data.Log.BusinessDocumentProcessingResultCode !== 3) throw new Error('Bad bank service answer')

        return data
    },

    async read(
    ) {
        let url = `${config.gentera_url}/account/businesspartners/level2account`
    
        if(!email) throw new Error('No email provided')
        if(!password) throw new Error('No password provided')
    
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

    update: (userId, data) => db.doc(`users/${userId}`).update({profile: data}),

    async generateAccess() {
        let url = `https://dev.apilab.gentera.com.mx/v3/oauth/accesstoken`
        let params = getParams({
            "GrantType": "client_credentials",
	        "ClientSecret": "2Vw1H2fi55BqeZnX"
        })
        const answer = await fetch(url, params)
        const data = await answer.json()
    
        if (data.error) throw (data.error)

        if(!data.accessToken) throw new Error('Error token')
    },

    async getTransactions() {
        let params = {
            method: 'GET', 
            headers: {
                'Content-Type': 'application/json',
                'X-API-KEY': 'OA6BLGKP3psAdqiMEA8s6bt8x4vlyRZZ',
                'Authorization': 'Bearer kxbQSRF9Z2B7us8c10A02GtqGtGc'
            }
        }
        let url = `${config.gentera_url}/${accountId}/transactions`
        
        const answer = await fetch(url, params)
        const data = await answer.json()
        if (data.error) {
            throw new Error({
                code: data.error.code,
                message: data.error.message
            })
        }

        if(data.code !== '00') throw new Error('Bad bank service answer')

        return data.data
    }
}
