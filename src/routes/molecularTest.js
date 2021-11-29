const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn, isLoggedInAsPacient } = require('../lib/auth');

router.get('/', isLoggedIn, async (req, res) => {
    res.render('molecularTest/panel');
});