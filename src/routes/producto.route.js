const express = require('express');
const router = express.Router();
const productoController = require('../controllers/producto.controller');

router.get('/', productoController.get);

router.post('/', productoController.create);

router.put('/:id', productoController.update);

router.delete('/:id', productoController.remove);

module.exports = router;
