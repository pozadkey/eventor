const express = require('express');
const mongoose = require('mongoose');
const localhost = '127.0.0.1';
const port = 3000 || process.env.PORT;
require('dotenv').config();
const router = require('./routes/routes');

const app = express();
const db = process.env.DB //ADD YOUR MONGODB URL

mongoose.connect(db, {useNewUrlParser: true, useUnifiedTopology: true }, () => {
    app.listen(port, (err, data) => {
        if (err) throw err
        console.log('server is listening to port ' + port);
    })
})

app.use(express.urlencoded({ extended: true }));
app.use(express.json())

app.use(router);
