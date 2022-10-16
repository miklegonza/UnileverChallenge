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

async function create(object) {
    const data = [
        object.id,
        object.operario,
        object.horario
    ];
    let stmt = "INSERT INTO " + config.db.database + ".turnos (id, operario, horario) VALUES (?,?,?)";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Registro creado": "Error al crear el registro";

}

async function update(id, object) {
    const data = [
        object.id,
        object.operario,
        object.horario
    ];
    let stmt = "UPDATE" + config.db.database + ".turnos SET column = ? WHERE id = ?;";
    const result = await pool.query(stmt, data);
    return result.affectedRows ? "Registro modificado": "Error al modificar registro";
}


async function remove(id) {
    let stmt = "DELETE FROM " + config.db.database + ".turnos WHERE id = ?;";
    const result = await pool.query(stmt, id);
    return result.affectedRows ? "Registro eliminado": "No se pudo eliminar el registro";
}

module.exports = { get, create, update, remove };