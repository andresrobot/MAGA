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
    const data = await pool.query(`SELECT * FROM servicios`)
    res.render('controlCare/servicios', {data});
});
router.post('/servicios', isLoggedInAsPacient, async (req, res) => {
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
    const { IDServicio, fecha, hora } = req.body;
    const nuevaCita = {
        fecha: fecha,
        hora: hora,
        IDPaciente: id_Paciente
    };
    const test = await pool.query('INSERT INTO citas set ?', [nuevaCita]);
    //console.log(test)
    const nuevaCitaPacienteServicio = {
        IDServicio: IDServicio,
        IDCita : test.insertId
    }
    console.log("HOOOOLA", nuevaCitaPacienteServicio);
    
    await pool.query('INSERT INTO citasservicios set ?', [nuevaCitaPacienteServicio]);
    req.flash('success', 'Cita agendada correctamente');
    res.redirect('/concierge/citas');
});
module.exports = router;