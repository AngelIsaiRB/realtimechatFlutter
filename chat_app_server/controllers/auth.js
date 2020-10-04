const { response } = require("express");
const bcrypt = require("bcryptjs");
const Usuario = require("../models/usuario");
const { generarJWT } = require("../helpers/jwt");

const crearUsuario= async (req, res=response)=> {

    const { email, password } = req.body;
    try {

        const existeEmail = await Usuario.findOne({email});
        if(existeEmail){
            return res.status(400).json({
                ok:false,
                msg:"eel correo ya se encuentra registrado"
            });
        }
        
        const usuario = new Usuario(req.body);
        //encriptar contrsena
        const salt = bcrypt.genSaltSync();
        usuario.password = bcrypt.hashSync(password,salt);

        await usuario.save();
        //generar JWT
        const token= await generarJWT(usuario.id);

         res.json({
             ok:true,
            usuario,
            token
     
         });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            ok:false,
            msg:"hable con el administrador"
        });
    
    }
  
}

module.exports={
    crearUsuario
}