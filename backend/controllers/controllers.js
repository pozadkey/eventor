const express = require('express');
const mongoose = require('mongoose');
const model = require('../models/models')

module.exports.addController = (req, res) => {
   var ticketCode = req.body.code

   model.FreshModel.findOne({code: ticketCode}).then(result => {
       if (result == null) {
        const addCode = new model.FreshModel({
            code: ticketCode
        });

        addCode.save().then(result => {
            res.status(201).send(`${result.code.toUpperCase()} was added successfully!`)
            console.log(result);
        })
        .catch(error => {
            res.status(500).send(`Sorry, an unknown error occurred.`)
        })
       }
       else {
           res.status(200).send(`Error! ${result.code.toUpperCase()} already exists.`)
       }
   })
}

module.exports.validateController = (req, res) => {
    var ticketCode = req.body.code;

    model.UsedModel.findOne({code: ticketCode}).then(result => {
        if (result == null){
            model.FreshModel.findOne({code: ticketCode}).then(data => {
                if (data == null){
                    res.status(404).send(`Error! ${ticketCode.toUpperCase()} is invalid.`)
                }
                else {
                    model.UsedModel.insertMany([data]).then(data => {
                        res.status(201).send(`${data[0].code.toUpperCase()} is valid!`);
                    })
                }
            })
        }
        else {
            res.status(200).send(`Sorry, ${result.code.toUpperCase()} has been used.`);
        }
    })
}