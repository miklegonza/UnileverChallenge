const express = require('express');
const router = express.Router();
const tiemposController = require('../controllers/tiempos.controller');

router.get('/', tiemposController.get);

module.exports = router;
