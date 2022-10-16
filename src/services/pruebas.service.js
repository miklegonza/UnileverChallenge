const pool = require("./db.service");
const helper = require("../utils/helper.util");
const config = require("../configs/db.config");

async function get(page = 1, id) {
    let stmt = "SELECT * FROM " + config.db.database + ".pruebas";

    if (typeof id != "undefined")
        stmt += " WHERE id = ?";

    const rows = await pool.query(stmt, id);
    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return { data, meta };
}

async function create(prueba) {
    const data = [
        prueba.concepto_prueba,
        prueba.fecha,
        prueba.estado,
        prueba.duracion,
        prueba.maquina
    ];
    let stmt = "INSERT INTO " + config.db.database + ".pruebas (concepto_prueba, fecha, estado, duracion, maquina) VALUES (?, ?, ?, ?, ?);";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Prueba creada" : "Error al crear prueba";
}

async function update(id, prueba) {
    const data = [
        prueba.concepto_prueba,
        prueba.fecha,
        prueba.estado,
        prueba.duracion,
        prueba.maquina,
        id
    ];
    let stmt = "UPDATE " + config.db.database + ".pruebas SET concepto_prueba = ?, fecha = ?, estado = ?, duracion = ?, maquina = ? WHERE id = ?;";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Prueba modificada" : "Error al modificar prueba";
}

async function remove(id) {
    let stmt = "DELETE FROM " + config.db.database + ".pruebas WHERE id = ?;";
    const result = await pool.query(stmt, id);
    return result.affectedRows ? "Prueba eliminada" : "Error al eliminar prueba";
}

module.exports = { get, create, update, remove };
