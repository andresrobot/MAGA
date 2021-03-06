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
    res.render('molecularTest/panel', {data});
});
router.get('/resultados', isLoggedInAsPacient, async (req, res) => {
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
    res.render('molecularTest/resultados', {data});
});

router.get('/agendarPrueba', isLoggedInAsPacient, async (req, res) => {
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
    const data = await pool.query(`SELECT * FROM doctores 
    INNER JOIN especialidadesdoctores on especialidadesdoctores.IDDoctor= doctores.IDDoctor 
    INNER JOIN especialidades on especialidadesdoctores.IDEspecialidad= especialidades.IDEspecialidad WHERE especialidades.nombre = ?`, "PRUEBA GEN??MICA")
    res.render('molecularTest/agendarPrueba', {data});
});

//M??TODOS POST

router.post('/agendarPrueba', isLoggedInAsPacient, async (req, res) => {
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
    const { IDDoctor, fecha, hora } = req.body;
    const nuevaCita = {
        fecha: fecha,
        hora: hora,
        IDPaciente: id_Paciente
    };
    await pool.query('INSERT INTO citas set ?', [nuevaCita]);
    const cita_ID = await pool.query('SELECT citas.IDCita FROM citas WHERE fecha = ?', fecha)
    const nuevaCitaPacienteDoctor = {
        IDDoctor: IDDoctor,
        IDCita : cita_ID[0].IDCita
    }
    console.log("HOOOOLA", nuevaCitaPacienteDoctor);
    //const nueva
    await pool.query('INSERT INTO citasdoctores set ?', [nuevaCitaPacienteDoctor]);
    req.flash('success', 'Prueba agendada correctamente');
    res.redirect('/concierge/citas');
});


module.exports = router;