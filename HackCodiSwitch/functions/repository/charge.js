


let amountless_qr = {
    "v": {
        "DEV": "8964621321/1"
    },
    "TYP": 19,
    "ic": {
        "IDC": "282684DDC7",
        "SER": 2902201038,
        "ENC": "r77qxmjN0iD1dLYPg94ERlXj6NgqNAOqD61P/cNv7tYVO5eR9i9t8mzpyIwtOkRGoSflGQDrTZXsA3qJhA3XVg/zpHz4jAiMELmu11UmGNbjnuomk8jJIuR0xm/EPArp/02J9DK72617p84jXor4ydfIBoJBDevVPG+FyFCrgiwJHBxU26Go2n6lx00/SOBmXHlUEjeb2c1LADDqaCQ8yNTF7VuhRl2VIT4XcFTT26Cwy8jfrKCts0xeMs52egJtY7BVcNbamrAjgsADLflBgJS44KgMmQVNJFclh68OJGC9tDjeFeTNTv9Zo2tjafpE"
    },
    "CRY": "+RiOJgGhk7AqmrqtJRXQTZECh3mbGwpUZrrjlCQCdjg="
}

let amount_qr = {
    "CRY": "H2+m7143nY5q0UjkWyNdGQ+xSFI5hOBfEmcYxgdTPLg=",
    "v": {
        "DEV": "8964621321/1"
    },
    "TYP": 19,
    "ic": {
        "IDC": "28268541B4",
        "SER": 2902201042,
        "ENC": "yqT0QsevrFI7EaFmWX9AKww9ErhTgGbreo9LhBWQtIXjt6uPLZ1JSrBUIv/v/U0TymK+hw8sj+tcanhWjaakrfeSmJ8ssaKisAuMz6zrFTylAdn1xldGaxnQ2ATUkpe/sme21yLr/ZOBgkL0NOAGo9hfHhbL6EmmT6tsTSTwKSwYEnNXhszdcRmuBTcwSEhcrBUPILE68ffD35NqZHvb1Ut9GEBhaQ2uwf9jQIcx9EKK3PuIjTXt0h1HPTObIhceuofu/IF2zGoNYdKbAi4Qp/Wys4ACH6DIaBwLMRcyZUdlB7Lzl4ZVTMHEBJ/xJPR3"
    }
}



module.exports = {
    async generate(amount, concept, reference, mode) {
        if(mode === 'string') 
            if(amount)
                return amount_qr
            
        return amountless_qr
    },

    async send(amount, concept, reference) {

        return true
    }
} 