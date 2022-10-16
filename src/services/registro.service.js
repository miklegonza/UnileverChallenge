/**
 * El .service.js se encarga de toda la lógica de negocio y la interacción con la base de datos
 */

 const pool = require("./db.service");
 const helper = require("../utils/helper.util");
 const config = require("../configs/db.config");
 
 async function get(page = 1, username) {
     let stmt = "SELECT * FROM " + config.db.database + ".registro";
 
     if (typeof username != "undefined")
         stmt += " WHERE id = ?";
 
     const rows = await pool.query(stmt, username);
     const data = helper.emptyOrRows(rows);
     const meta = { page };
 
     return { data, meta };
 }
 
 async function create(registro) {
     const data = [
         registro.fecha,
         registro.cantidad_solicitada,
         registro.cantidad_cumplida,
     ];
     let stmt = "INSERT INTO " + config.db.database + ".registro (fecha,cantidad_solicitada,cantidad_cumplida) VALUES (?,?,?)";
     const result = await pool.query(stmt, data);
     return result.affectedRows ? "Registro creado" : "Error al crear registro";
 }
 
 async function update(id, registro) {
     const data = [
         registro.fecha,
         registro.cantidad_solicitada,
         registro.cantidad_cumplida,
         id
     ];
     let stmt = "UPDATE " + config.db.database + ".registro SET fecha = ?, cantidad_solicitada = ?, cantidad_cumplida = ? WHERE id = ?;";
     const result = await pool.query(stmt, data);
     return result.affectedRows ? "Registro modificado" : "Error al modificar registro";
 }
 
 async function remove(id) {
     let stmt = "DELETE FROM " + config.db.database + ".registro WHERE id = ?;";
     const result = await pool.query(stmt, id);
     return result.affectedRows ? "Registro eliminado" : "Error al eliminar registro";
 }
 
 module.exports = { get, create, update, remove };
 