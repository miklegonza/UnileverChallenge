const pool = require("./db.service");
const helper = require("../utils/helper.util");
const config = require("../configs/db.config");

async function get(page = 1, id) {
    let stmt = "SELECT * FROM " + config.db.database + ".mantenimiento";

    if (typeof id != "undefined")
        stmt += " WHERE id = ?";

    const rows = await pool.query(stmt, id);
    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return { data, meta };
}

async function create(mantenimiento) {
    const data = [
        mantenimiento.fecha,
        mantenimiento.duracion,
        mantenimiento.maquina
    ];
    let stmt = "INSERT INTO " + config.db.database + ".mantenimiento (fecha, duracion, maquina) VALUES (?, ?, ?)";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Mantenimiento creado" : "Error al crear mantenimiento";
}

async function update(id, mantenimiento) {
    const data = [
        mantenimiento.fecha,
        mantenimiento.duracion,
        mantenimiento.maquina,
        id
    ];
    let stmt = "UPDATE " + config.db.database + ".mantenimiento SET fecha = ?, duracion = ?, maquina = ? WHERE id = ?;";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Mantenimiento modificado" : "Error al modificar mantenimiento";
}

async function remove(id) {
    let stmt = "DELETE FROM " + config.db.database + ".mantenimiento WHERE id = ?;";
    const result = await pool.query(stmt, id);
    return result.affectedRows ? "Mantenimiento eliminado" : "Error al eliminar mantenimiento";
}

module.exports = { get, create, update, remove };
