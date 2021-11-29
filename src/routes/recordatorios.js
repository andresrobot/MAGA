const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn, isLoggedInAsPacient } = require('../lib/auth');

router.get('/', isLoggedInAsPacient, async (req, res) => {
    let id_Paciente= null;
    if (req.user.IDCirculo)
    {
        let Paciente= await pool.query(`SELECT * 
        FROM paciente INNER JOIN circulopaciente ON circulopaciente.IDPaciente = paciente.IDPaciente
        INNER JOIN circulo ON circulopaciente.IDCirculo = circulo.IDCirculo`)
        id_Paciente = Paciente[0].IDPaciente
    }
    else{
        id_Paciente = req.user.IDPaciente
    }
    const data = await pool.query(`SELECT * FROM moleculartest WHERE IDPaciente = ?`, id_Paciente)
    res.render('concierge/citas', {data});
});