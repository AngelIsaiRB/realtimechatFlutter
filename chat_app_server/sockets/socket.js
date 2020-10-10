const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');
const { usuarioConectado, usuarioDesconectado, grabarMensaje } = require('../controllers/socket');



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
    
    // ingresar a una sala en particular 
    //se unen autmaticamente a dos sala global, client.id , 

    client.join(uid);

    //escuchar el mansaje del cliente

    client.on("mensaje-personal", async (payload)=>{
        await grabarMensaje(payload);
        io.to(payload.para).emit("mensaje-personal",payload);
    });


    client.on('disconnect', () => {
        console.log('Cliente desconectado');
        usuarioDesconectado(uid);
    });

    /*client.on('mensaje', ( payload ) => {
        console.log('Mensaje', payload);
        io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    });*/


});
