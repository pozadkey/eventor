const express = require('express');
const mongoose = require('mongoose');
const PORT = process.env.PORT;
require('dotenv').config();
const router = require('./routes/routes');

const app = express();
const db = process.env.DB //ADD YOUR MONGODB URL

mongoose.connect(db, {useNewUrlParser: true, useUnifiedTopology: true }, () => {
    app.listen(PORT, (err, data) => {
        if (err) throw err
        console.log('server is listening to port ' + PORT);
    })
})

app.use(express.urlencoded({ extended: true }));
app.use(express.json())

app.use(router);
