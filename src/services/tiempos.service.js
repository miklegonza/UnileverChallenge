const pool = require("./db.service");
const helper = require("../utils/helper.util");
const config = require("../configs/db.config");

async function get(page = 1, id) {

    let stmt = "SELECT id, nombre, tiempo_produccion, tiempo_limpieza, linea FROM " + config.db.database + ".producto WHERE id = ?";
    let stmt2 = "SELECT id, capacidad_producto FROM " + config.db.database + ".maquinas WHERE linea = ?";

    const rows = await pool.query(stmt, id);
    const rows2 = await pool.query(stmt2, rows[0].linea);

    let data = {
        id_producto: rows[0].id,
        tiempo_produccion: rows[0].tiempo_produccion + ' por lote',
        tiempo_limpieza: rows[0].tiempo_limpieza,
        linea: rows[0].linea,
        id_maquina: rows2[0].id,
        capacidad_produccion: rows2[0].capacidad_producto + ' lotes',
    };
    let tiempo_produccion = (rows[0].tiempo_produccion + rows[0].tiempo_limpieza) / rows2[0].capacidad_producto;
    let analysis = {
        producto: rows[0].nombre,
        maquina: rows2[0].id,
        tiempo_produccion: tiempo_produccion + " horas por lote"
    };
    const meta = { page };

    return { data, analysis, meta };
}

module.exports = { get };
