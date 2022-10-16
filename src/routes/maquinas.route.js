const express = require('express');
const router = express.Router();
const maquinasController = require('../controllers/maquinas.controller');

router.get('/', maquinasController.get);

router.post('/', maquinasController.create);

router.put('/:id', maquinasController.update);

router.delete('/:id', maquinasController.remove);

module.exports = router;
