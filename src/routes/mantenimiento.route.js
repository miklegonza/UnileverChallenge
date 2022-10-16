const express = require('express');
const router = express.Router();
const mantenimientoController = require('../controllers/mantenimiento.controller');

router.get('/', mantenimientoController.get);

router.post('/', mantenimientoController.create);

router.put('/:id', mantenimientoController.update);

router.delete('/:id', mantenimientoController.remove);

module.exports = router;
