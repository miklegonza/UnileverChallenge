const express = require('express');
const router = express.Router();
//require controller

router.get('/', controller.get);

router.post('/', controller.create);

router.put('/:id', controller.update);

router.delete('/:id', controller.remove);

module.exports = router;
