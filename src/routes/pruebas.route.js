const express = require('express');
const router = express.Router();
const pruebasController = require('../controllers/pruebas.controller');

router.get('/', pruebasController.get);

router.post('/', pruebasController.create);

router.put('/:id', pruebasController.update);

router.delete('/:id', pruebasController.remove);

module.exports = router;
