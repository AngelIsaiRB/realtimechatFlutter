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

const loginUsuario= async (req, res=response)=> {
    const {email, password}=req.body;
    try {

        const usuarioDB = await Usuario.findOne({email});
        if(!usuarioDB){
            return res.status(404).json({
                ok:false,
                msg:"no found"
            });
        }
        const validpassword = bcrypt.compareSync(password, usuarioDB.password);
        if(!validpassword){
            return res.status(400).json({
                ok:false,
                msg:"la contraseña no es valida"
            });
        }

        const token = await generarJWT(usuarioDB.id);
        res.json({
            ok:true,
           usuario: usuarioDB,
           token
    
        });


    } catch (error) {
        console.log(error);
      return  res.status(500).json({
            ok:false,
           msg:"Hable con el administrador"    
        });
    }    
}

const renewToken = async (req, res=response)=>{
    const uid = req.uid;
    const usuario = await Usuario.findById(uid);
    const token= await generarJWT(uid);    
    res.json({
        ok:true,
        usuario,
        token
        
    })
}

module.exports={
    crearUsuario,
    loginUsuario,
    renewToken
}