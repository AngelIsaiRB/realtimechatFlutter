const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');
const { usuarioConectado, usuarioDesconectado } = require('../controllers/socket');



// Mensajes de Sockets
io.on('connection',   client => {    

    // verificar autentificado
    const [valido,uid]= comprobarJWT(client.handshake.headers["x-token"]);
    if(!valido){
        console.log('Rechazado');
        return client.disconnect();
       
    }
    console.log('Cliente Conectado--------');
    //cliente autentificado
    usuarioConectado(uid);


    client.on('disconnect', () => {
        console.log('Cliente desconectado');
        usuarioDesconectado(uid);
    });

    /*client.on('mensaje', ( payload ) => {
        console.log('Mensaje', payload);
        io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    });*/


});
