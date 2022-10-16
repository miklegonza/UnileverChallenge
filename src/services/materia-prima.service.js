/**
 * El .service.js se encarga de toda la lógica de negocio y la interacción con la base de datos
 */

 const pool = require("./db.service");
 const helper = require("../utils/helper.util");
 const config = require("../configs/db.config");
 
 async function get(page = 1, username) {
     let stmt = "SELECT * FROM " + config.db.database + ".table";
 
     if (typeof username != "undefined")
         stmt += " WHERE usuario = ?";
 
     const rows = await pool.query(stmt, username);
     const data = helper.emptyOrRows(rows);
     const meta = { page };
 
     return { data, meta };
 }
 
 async function create(object) {
     const data = [
         object.value1,
         object.value2
     ];
     let stmt = "INSERT INTO " + config.db.database + ".table (columns) VALUES (?)";
     const result = await pool.query(stmt, data);
     return result.affectedRows ? "Registro creado" : "Error al crear registro";
 }
 
 async function update(id, object) {
     const data = [
         object.value1,
         object.value2,
         id
     ];
     let stmt = "UPDATE " + config.db.database + ".table SET column = ? WHERE id = ?;";
     const result = await pool.query(stmt, data);
     return result.affectedRows ? "Registro modificado" : "Error al modificar registro";
 }
 
 async function remove(id) {
     let stmt = "DELETE FROM " + config.db.database + ".table WHERE id = ?;";
     const result = await pool.query(stmt, id);
     return result.affectedRows ? "Registro eliminado" : "Error al eliminar registro";
 }
 
 module.exports = { get, create, update, remove };
 