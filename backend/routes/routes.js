const express = require('express');
const router = express.Router();
const controllers = require('../controllers/controllers')

router.post('/add', controllers.addController);

router.post('/validate', controllers.validateController);

module.exports = router;