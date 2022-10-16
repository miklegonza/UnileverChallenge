const pool = require("./db.service");
const helper = require("../utils/helper.util");
const config = require("../configs/db.config");


async function get (page =1, username) {
    let stmt = "SELECT * FROM " + config.db.database + ".turnos";

    if (typeof username != "undefined")
    stmt += "WHERE id = ?";

    const rows = await pool.query(stmt, username);
    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return { data, meta };
}

async function create(turno) {
    const data = [
        turno.operario,
        turno.horario
    ];
    let stmt = "INSERT INTO " + config.db.database + ".turnos (operario, horario) VALUES (?, ?)";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Turno creado": "Error al crear el turno";

}

async function update(id, turno) {
    const data = [
        turno.operario,
        turno.horario,
        id
    ];
    let stmt = "UPDATE " + config.db.database + ".turnos SET operario = ?, horario = ? WHERE id = ?;";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Turno modificado": "Error al modificar turno";
}


async function remove(id) {
    let stmt = "DELETE FROM " + config.db.database + ".turnos WHERE id = ?;";
    const result = await pool.query(stmt, id);
    return result.affectedRows ? "Turno eliminado": "No se pudo eliminar el turno";
}

module.exports = { get, create, update, remove };