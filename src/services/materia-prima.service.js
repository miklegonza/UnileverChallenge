const pool = require("./db.service");
const helper = require("../utils/helper.util");
const config = require("../configs/db.config");

async function get(page = 1, id) {
    let stmt = "SELECT * FROM " + config.db.database + ".materia_prima";

    if (typeof id != "undefined") stmt += " WHERE id = ?";

    const rows = await pool.query(stmt, id);
    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return { data, meta };
}

async function create(materia) {
    const data = [
        materia.nombre,
        materia.cantidad_stock,
        materia.fecha_vencimiento,
    ];
    let stmt = "INSERT INTO " + config.db.database + ".materia_prima (nombre, cantidad_stock, fecha_vencimiento) VALUES (?, ?, ?);";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Materia prima creada" : "Error al crear materia prima";
}

async function update(id, materia) {
    const data = [
        materia.nombre,
        materia.cantidad_stock,
        materia.fecha_vencimiento,
        id,
    ];
    let stmt = "UPDATE " + config.db.database + ".materia_prima SET nombre = ?, cantidad_stock = ?, fecha_vencimiento = ? WHERE id = ?;";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Materia prima modificada" : "Error al modificar la materia prima";
}

async function remove(id) {
    let stmt =
        "DELETE FROM " + config.db.database + ".materia_prima WHERE id = ?;";
    const result = await pool.query(stmt, id);
    return result.affectedRows
        ? "Materia prima eliminada"
        : "Error al eliminar materia prima";
}

module.exports = { get, create, update, remove };
