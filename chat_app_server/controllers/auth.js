const { response } = require("express");


const crearUsuario=(req, res=response)=>{

   
    
    res.json({
        ok:true,
        msg:"crear Usuario!!"

    });
}

module.exports={
    crearUsuario
}