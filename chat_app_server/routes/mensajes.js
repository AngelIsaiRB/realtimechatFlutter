

// path :  /api/mensajes


const { Router } = require('express');
const { obtenerchat } = require('../controllers/mensajes');
const { validarJWT } = require('../middlewares/validar-jwt');

const router =Router();



router.get("/:de",validarJWT,obtenerchat);



module.exports=router; 