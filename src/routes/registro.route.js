/**
 * El .route.js define las rutas de cada una de las peticiones
 */

 const express = require('express');
 const router = express.Router();
 const controller = require('../controllers/registro.controller');
 
 router.get('/', controller.get);
 
 router.post('/', controller.create);
 
 router.put('/:id', controller.update);
 
 router.delete('/:id', controller.remove);
 
 module.exports = router;
 