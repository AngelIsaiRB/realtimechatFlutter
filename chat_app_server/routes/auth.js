/*
api/login
*/

const { Router } = require('express');
const { check } = require('express-validator');
const { crearUsuario } = require("../controllers/auth");

const { validarCampos } = require("../middlewares/valida-campos");

const router =Router();

router.post('/new', [
    check('nombre','El nombre es obligatorio').not().isEmpty(),
    check('password','La contraseña es obligatoria').not().isEmpty(),
    check('email','El correo es obligatorio').isEmail(),
    validarCampos
], crearUsuario );


module.exports=router; 