const tiempoService = require("../services/tiempos.service");

async function get(req, res, next) {
    try {
        res.json(await tiempoService.get(req.query.page, req.query.id));
    } catch (err) {
        console.error("Get error:", err.message);
        next(err);
    }
}

module.exports = { get };
