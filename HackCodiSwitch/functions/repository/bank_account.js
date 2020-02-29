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
        
    ) {
        if(!email) throw('No email provided')
        if(!password) throw('No password provided')

        let bank_url = `${config.gentera_url}/account/businesspartners/level2account`
        let params = {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify( {
                "UUID": "61bb1f5e-7cc6-4b15-a2ef-dfb454ba371d",
                "Identifiers": {
                    "ServiceOfficeID": "242",
                    "CommerceID": "J211",
                    "OriginID": "Z06"
                },
                "BusinessPartnerCreateLevel2AccountData": {
                    "NameData": {
                        "GivenName": "Maria",
                        "MiddleName": "Carreto",
                        "FamilyName": "Paz",
                        "AditionalFamilyName": "Mentor"
                    },
                    "BirthDate": "1992-12-07",
                    "Gender": "0",
                    "DocumentIdentifiers": {
                        "Code": "ZCVELE",
                        "ID": "ARMNJR92120714H700"
                    },
                    "CardIdentification": "2867288",
                    "RegionBirth": "DF",
                    "BirthCountryCode": "MX",
                    "CitizenshipCode": "MX",
                    "PhoneData": {
                        "PhoneTypeID": "6",
                        "PhoneNumber": {
                            "SubscriberID": "5543783455"
                        }
                    },
                    "AddressData": {
                        "AddressTypeCode": "XXDEFAULT",
                        "StreetName": "Canela",
                        "CountryCode": "MX",
                        "RegionCode": "DF",
                        "CityName": "Mexico",
                        "DistrictName": "Iztacalco",
                        "AdditionalCityName": "Granjas Mexico",
                        "StreetPostalCode": "08400",
                        "HouseID": "484",
                        "AdditionalHouseID": "C-203"
                    }
                }
                
            } )
        }

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

    get: (userId, accountId) => {
        if(accountId) {
            return db.doc(`users/${userId}/bank_accounts/${accountId}`).get().then((doc) => doc.info)
        }

        return db.doc(`users/${userId}/bank_accounts`).get()
    }
}
