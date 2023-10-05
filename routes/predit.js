const express = require('express');
const router = express.Router();
const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const DOMParser = require('dom-parser');

router.get('/', function(req, res) {
   res.render('predit');
});

module.exports = router;