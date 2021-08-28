const express = require('express');
const mongoose = require('mongoose');

const FreshSchema = mongoose.Schema({
    code: {
        type: String,
        required: true
    }
});

const UsedSchema = mongoose.Schema({
    code: {
        type: String,
        reqyired: true
    }
})

const FreshModel = mongoose.model('fresh', FreshSchema);
const UsedModel = mongoose.model('used', UsedSchema)

module.exports = { FreshModel, UsedModel};