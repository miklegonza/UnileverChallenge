const express = require("express");
const router = express.Router();
const materiaPrimaController = require("../controllers/materia-prima.controller");

router.get("/", materiaPrimaController.get);

router.post("/", materiaPrimaController.create);

router.put("/:id", materiaPrimaController.update);

router.delete("/:id", materiaPrimaController.remove);

module.exports = router;
