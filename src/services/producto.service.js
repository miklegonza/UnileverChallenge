/**
 * El .service.js se encarga de toda la lógica de negocio y la interacción con la base de datos
 */

 const pool = require("./db.service");
 const helper = require("../utils/helper.util");
 const config = require("../configs/db.config");
 
 async function get(page = 1, id) {
     let stmt = "SELECT * FROM " + config.db.database + ".producto";
 
     if (typeof id != "undefined")
         stmt += " WHERE id = ?";
 
     const rows = await pool.query(stmt, id);
     const data = helper.emptyOrRows(rows);
     const meta = { page };
 
     return { data, meta };
 }
 
 async function create(object) {
     const data = [
         object.nombre,
         object.tiempo_produccion,
         object.tiempo_limpieza,
         object.fecha_vencimiento,
         object.registro,
         object.linea
     ];
     let stmt = "INSERT INTO " + config.db.database + ".producto (nombre, tiempo_produccion, tiempo_limpieza, fecha_vencimiento, registro, linea) VALUES (?,?,?,?,?,?)";
     const result = await pool.query(stmt, data);
     return result.affectedRows ? "Registro creado" : "Error al crear registro";
 }
 
 async function update(id, object) {
     const data = [
        object.nombre,
        object.tiempo_produccion,
        object.tiempo_limpieza, 
        object.fecha_vencimiento,
        object.registro,
        object.linea,
        id
     ];
     let stmt = "UPDATE " + config.db.database + ".producto SET nombre = ?, tiempo_produccion = ?, tiempo_limpieza = ?, fecha_vencimiento = ?, registro = ?, linea = ? WHERE id = ?;";
     const result = await pool.query(stmt, data);
     return result.affectedRows ? "Registro modificado" : "Error al modificar registro";
 }
 
 async function remove(id) {
     let stmt = "DELETE FROM " + config.db.database + ".producto WHERE id = ?;";
     const result = await pool.query(stmt, id);
     return result.affectedRows ? "Registro eliminado" : "Error al eliminar registro";
 }
 
 module.exports = { get, create, update, remove };
 