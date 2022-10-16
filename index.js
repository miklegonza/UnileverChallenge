const express = require('express');

const formulaRouter = require('./src/routes/formula.route');
const lineasRouter = require('./src/routes/lineas.route');
const mantenimientoRouter = require('./src/routes/mantenimiento.route');
const maquinasRouter = require('./src/routes/maquinas.route');
const materiaPrimaRouter = require('./src/routes/materia-prima.route');
const productoRouter = require('./src/routes/producto.route');
const pruebasRouter = require('./src/routes/pruebas.route');
const registroRouter = require('./src/routes/registro.route');
const turnosRouter = require('./src/routes/turnos.route');


require('dotenv').config();
const app = express();
const PORT = process.env.PORT || 5000;

// Middelwares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//app.use('/formula', formulaRouter);
app.use('/lineas', lineasRouter);
app.use('/mantenimiento', mantenimientoRouter);
app.use('/maquinas', maquinasRouter);
app.use('/materia-prima', materiaPrimaRouter);
//app.use('/producto', productoRouter);
app.use('/pruebas', pruebasRouter);
app.use('/registro', registroRouter);
app.use('/turnos', turnosRouter);


app.use((req, res, next) => {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

app.use((err, req, res, next) => {
    const statusCode = err.statusCode || 500;
    console.error(err.message, err.stack);
    res.status(statusCode).json({ message: err.message });
    return;
});

// Prueba 
app.get('/', (req, res) => {
    res.status(200).json({ message: 'Hello world' })
});

//server
app.listen(PORT, () => console.log('Server on port: ', PORT));