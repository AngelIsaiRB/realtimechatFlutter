const express = require('express');
const path = require('path');
require('dotenv').config();

// App de Express
const app = express();
//db config
const {dbConnection} = require("./database/config");
dbConnection();

// lectura de body http
app.use(express.json());


// Node Server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/socket');




// Path público
const publicPath = path.resolve( __dirname, 'public' );
app.use( express.static( publicPath ) );

// mis rutas
app.use("/api/login", require("./routes/auth"));
app.use("/api/usuarios", require("./routes/usuario"));
app.use("/api/mensajes", require("./routes/mensajes"));





server.listen( process.env.PORT, ( err ) => {

    if ( err ) throw new Error(err);

    console.log('Servidor corriendo en puerto', process.env.PORT );

});


