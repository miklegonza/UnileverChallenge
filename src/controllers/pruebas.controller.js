const pruebasService = require('../services/pruebas.service');

async function get(req, res, next) {
    try {
        res.json(await pruebasService.get(req.query.page, req.query.id));
    } catch (err) {
        console.error('Get error:', err.message);
        next(err);
    }
}

async function create(req, res, next) {
    try {
        res.json(await pruebasService.create(req.query));
    } catch (err) {
        console.error('Post error:', err.message);
        next(err);
    }
}

async function update(req, res, next) {
    try {
        res.json(await pruebasService.update(req.params.id, req.query));
    } catch (err) {
        console.error('Put error:', err.message);
        next(err);
    }
}

async function remove(req, res, next) {
    try {
        res.json(await pruebasService.remove(req.params.id));
    } catch (err) {
        console.error('Delete error:', err.message);
        next(err);
    }
}

module.exports = { get, create, update, remove }
