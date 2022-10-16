const pool = require("./db.service");
const helper = require("../utils/helper.util");
const config = require("../configs/db.config");

async function get(page = 1, id) {
    let stmt = "SELECT * FROM " + config.db.database + ".maquinas";

    if (typeof id != "undefined")
        stmt += " WHERE id = ?";

    const rows = await pool.query(stmt, id);
    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return { data, meta };
}

async function create(maquina) {
    const data = [
        maquina.capacidad_producto,
        maquina.estado_maquina,
        maquina.linea
    ];
    let stmt = "INSERT INTO " + config.db.database + ".maquinas (capacidad_producto, estado_maquina, linea) VALUES (?, ?, ?);";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Máquina creada" : "Error al crear máquina";
}

async function update(id, maquina) {
    const data = [
        maquina.capacidad_producto,
        maquina.estado_maquina,
        maquina.linea,
        id
    ];
    let stmt = "UPDATE " + config.db.database + ".maquinas SET capacidad_producto = ?, estado_maquina = ?, linea = ? WHERE id = ?;";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Máquina modificada" : "Error al modificar máquina";
}

async function remove(id) {
    let stmt = "DELETE FROM " + config.db.database + ".maquinas WHERE id = ?;";
    const result = await pool.query(stmt, id);
    return result.affectedRows ? "Máquina eliminada" : "Error al eliminar máquina";
}

module.exports = { get, create, update, remove };
