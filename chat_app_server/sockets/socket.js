const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');


// Mensajes de Sockets
io.on('connection', client => {    
    const [valido,uid]= comprobarJWT(client.handshake.headers["x-token"]);
    if(!valido){
        console.log('Rechazado');
        return client.disconnect();
       
    }
    console.log('Cliente Conectado--------');
    

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });

    /*client.on('mensaje', ( payload ) => {
        console.log('Mensaje', payload);
        io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    });*/


});
