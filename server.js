const http = require( 'http' ),
   fs = require( 'fs' ),
   // IMPORTANT: you must run `npm install` in the directory for this assignment
   // to install the mime library used in the following line of code - done.
   mime = require( 'mime' ),
   dir = '/',
   port = 3000

const server = http.createServer( function ( request, response ) {
   if( request.method === 'GET' ) {
      handleGet( request, response )
   } else if( request.method === 'POST' ) {
      handlePost( request, response )
   }
} )

const handleGet = function ( request, response ) {
   const filename = dir + request.url.slice( 1 )

   if( request.url === '/' ) {
      sendFile( response, 'views/login.html' )
   } else {
      sendFile( response, filename )
   }
}

const handlePost = function ( request, response ) {
   let dataString = ''

   request.on( 'data', function ( data ) {
      dataString += data
   } )

   request.on( 'end', function () {
      console.log( JSON.parse( dataString ) )

      // ... do something with the data here!!!

      response.writeHead( 200, "OK", {
         'Content-Type': 'text/plain'
      } )
      response.end()
   } )
}

const sendFile = function ( response, filename ) {
   const type = mime.getType( filename )

   fs.readFile( filename, function ( err, content ) {

      // if the error = null, then we've loaded the file successfully
      if( err === null ) {

         // status code: https://httpstatuses.com
         response.writeHeader( 200, {
            'Content-Type': type
         } )
         response.end( content )

      } else {

         // file not found, error code 404
         response.writeHeader( 404 )
         response.end( '404 Error: File Not Found' )

      }
   } )
}

server.listen( process.env.PORT || port )