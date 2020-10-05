/*
api/login
*/

const { Router } = require('express');
const { check } = require('express-validator');
const { crearUsuario,loginUsuario } = require("../controllers/auth");

const { validarCampos } = require("../middlewares/valida-campos");

const router =Router();

router.post('/new', [
    check('nombre','El nombre es obligatorio').not().isEmpty(),
    check('password','La contraseña es obligatoria').not().isEmpty(),
    check('email','El correo es obligatorio').isEmail(),
    validarCampos
], crearUsuario );

router.post("/",[
    check('email','El email es obligatorio').not().isEmpty(),
    check('password','La contraseña es obligatoria').not().isEmpty(),    
    validarCampos

], loginUsuario);

module.exports=router; 