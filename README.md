# HackCodi

El proyecto esta compuesto por un plataforma que expone un API Rest y una aplicación móvil que la consume.

La plataforma se conecta a 4 API's:
-Tecobro para la creación de "cuenta CoDi" con Banxico
    Para lo cual expone os endpoints 
      /users/signup (POST)
      /users/signin (POST)
      /codi_accounts (POST, GET)
      /charges (POST, GET) para generar códigos QR
-HSBC para creación de cuentas N2
      /bank_accounts (POST, GET), con el parametro que indica que banco se utilizará
-Finlab para creación de cuentas N2
      /bank_accounts (POST, GET), con el parametro que indica que banco se utilizará
-CyberSouerce para generar cargos a la tarjeta de la cuenta bancaria de los comercios
      /payments (POST)

Este sistema permite:
-al usuario, crear una cuenta en Banxico para la generación de código QR bajo el estándar CoDi 
-al usuario, crear una cuenta bancaria (ya sea via Finllab o con HSBC) en caso de que el usuario de la App no tenga una
-al usuario, generar mensajes de cobro con QR CoDi, ya sea con monto o sin monto
-a TeCobro, generar un cargo a la tarjeta (asociada a la cuenta bancaria del usuario) para cobrar la licencia de uso

Las herramientas utilizadas son:
Plataforma: Montada en Google Firebase utilizando la herramienta "functions" que provee para exponer los endpoints de la API utilizando javascript como lenguaje y nodejs para el desarrollo asi como firebase tools para el despliegue asi como Visual Studio Code IDE. La documentación del API se encuentra en Swagger en https://app.swaggerhub.com/apis-docs/jdashel/HackCodi/1.0.0

Aplicación móvil: Se desarrolló para iOS y Android utilizando la herramienta de desarrollo creada por Google llamada Flutter debido a que nos permite el desarrollo multiplataforma y genera un compilado nativo para ambas plataformas con la misma base de desarrollo utilizando el lenguaje Dart y Visual Studio Code como IDE.

La seguridad del sistema esta sustentada en HTTPS y token de inicio de sesión provisto por Google Cloud asi como respetando las indicaciones de los proovedores de las API's consumidas.

El sistema en el repositorio está organizado en dos branch llamadas switch_dev y app_dev para la plataforma y para la aplicación respectivamente.

