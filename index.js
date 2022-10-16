const express = require('express');
const router = require('./src/routes/producto.route')

require('dotenv').config();
const app = express();
const PORT = process.env.PORT || 5000;

// Middelwares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/prod', router);

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
