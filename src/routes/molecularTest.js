const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn, isLoggedInAsPacient } = require('../lib/auth');

router.get('/', isLoggedInAsPacient, async (req, res) => {
    const data = await pool.query(`SELECT * FROM moleculartest WHERE IDPaciente = ?`, req.user.IDPaciente)
    res.render('molecularTest/panel', {data});
});
router.get('/resultados', isLoggedInAsPacient, async (req, res) => {
    const data = await pool.query(`SELECT * FROM moleculartest WHERE IDPaciente = ?`, req.user.IDPaciente)
    res.render('molecularTest/resultados', {data});
});

//MÉTODOS POST

router.post('/agendarPrueba', isLoggedInAsPacient, async (req, res) => {
    const { IDDoctor, fecha, hora } = req.body;
    const nuevaCita = {
        fecha: fecha,
        hora: hora,
        IDPaciente: req.user.IDPaciente
    };
    await pool.query('INSERT INTO moleculartest set ?', [nuevaCita]);
    const cita_ID = await pool.query('SELECT citas.IDCita FROM citas WHERE fecha = ?', fecha)
    const nuevaCitaPacienteDoctor = {
        IDDoctor: IDDoctor,
        IDCita : cita_ID[0].IDCita
    }
    console.log("HOOOOLA", nuevaCitaPacienteDoctor);
    
    await pool.query('INSERT INTO citasdoctores set ?', [nuevaCitaPacienteDoctor]);
    req.flash('success', 'Cita agendada correctamente');
    res.redirect('/concierge/citas');
});


module.exports = router;