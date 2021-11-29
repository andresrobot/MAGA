const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedInAsDoctor } = require('../lib/auth');

router.get('/', isLoggedInAsDoctor, async (req, res) => {
    const paciente = await pool.query(`SELECT * FROM paciente`)
    res.render('pacientes/lista', {paciente});
});
router.get('/tratamiento/:id', isLoggedInAsDoctor, async (req, res) => {
    const { id } = req.params;
    const tratamiento = await pool.query(`SELECT * 
    FROM tratamiento WHERE IDPaciente = ?` , [id]);
    console.log(tratamiento);
    if (!tratamiento[0])
        res.redirect('/');
    else{

    
    const medicamentos = await pool.query(`select medicamentos.IDMedicamento, medicamentos.nombreMedicamento, medicamentostratamiento.indicaciones
    from medicamentos inner join medicamentostratamiento
    on medicamentostratamiento.IDMedicamento=medicamentos.IDMedicamento
    where medicamentostratamiento.IDTratamiento=?`, [tratamiento[0].IDTratamiento]);
    const doctores = await pool.query(`select *
    from doctores inner join tratamientodoctores
    on tratamientodoctores.IDDoctor=doctores.IDDoctor
    where tratamientodoctores.IDTratamiento=?`, [tratamiento[0].IDTratamiento]);
    console.log(medicamentos)
    console.log(doctores);
    console.log(tratamiento);
    res.render('concierge/tratamiento', {tratamiento, medicamentos, doctores});
    }
});
router.get('/editarTratamiento/:id', isLoggedInAsDoctor, async (req, res) => {
    const { id } = req.params;
    const tratamiento = await pool.query(`SELECT * 
    FROM tratamiento WHERE IDTratamiento = ?` , [id]);
    console.log(tratamiento);
    if (!tratamiento[0])
        res.redirect('/');
    else{


    res.render('pacientes/editarTratamiento', {tratamiento});
    }
});
router.post('/editarTratamiento/:id', isLoggedInAsDoctor, async (req, res) => {
    console.log(req.params)
    const { id } = req.params;
    const { indicaciones} = req.body;
    const nuevaCita = {
        indicaciones: indicaciones,
        IDTratamiento: id
    };
    //console.log(nuevaCita, id);
    await pool.query('UPDATE tratamiento set ? WHERE IDTratamiento = ?', [nuevaCita, id]);
    req.flash('success', 'Tratamiento actualizado');
    res.redirect('/pacientes');
});

module.exports = router;