const express = require('express');
const router = express.Router();
const turnosController = require('../controllers/turnos.controller');

router.get('/', turnosController.get);

router.post('/', turnosController.create);

router.put('/:id', turnosController.update);

router.delete('/:id', turnosController.remove);

module.exports = router;
