const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/', isLoggedIn, async (req, res) => {
    res.render('concierge/panel');
});

router.get('/citas', isLoggedIn, async (req, res) => {
    const citas = await pool.query(`SELECT * 
    FROM citas INNER JOIN citasdoctores
    ON citasdoctores.IDCita = citas.IDCita
    INNER JOIN doctores 
    on citasdoctores.IDDoctor = doctores.IDDoctor
    WHERE IDPaciente = ?`, [req.user.id]);
    console.log(citas);
    res.render('concierge/citas', { citas });

});

router.get('/nuevaCita', isLoggedIn, async (req, res) => {
    res.render('concierge/nuevaCita');

});

router.get('/medicamentos', isLoggedIn, async (req, res) => {
    const medicamentos = await pool.query(`select medicamentos.IDMedicamento, medicamentos.nombreMedicamento, medicamentospacientes.indicaciones
    from medicamentos inner join medicamentospacientes
    on medicamentospacientes.IDMedicamento=medicamentos.IDMedicamento
    where medicamentospacientes.IDPaciente=?`, [req.user.id]);
    res.render('concierge/medicamentos', { medicamentos });

});

router.get('/deleteCita/:id', async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM citas WHERE IDCita = ?', [id]);
    req.flash('success', 'Cita eliminada correctamente');
    res.redirect('/concierge/citas');
});

router.get('/editCita/:id', async (req, res) => {
    const { id } = req.params;
    const citas = await pool.query('SELECT * FROM citas WHERE IDCita = ?', [id]);
    //const citas = null;
    //console.log(links);
    res.render('concierge/editCita', {cita: citas[0]});
});



//MÉTODOS POST

router.post('/editCita/:id', async (req, res) => {
    const { id } = req.params;
    const { IDDoctor, fecha } = req.body;
    const nuevaCita = {
        fecha: fecha,
        IDPaciente: req.user.id
    };
    console.log(nuevaCita);
    await pool.query('UPDATE citas set ? WHERE IDPaciente = ?', [nuevaCita, id]);
    req.flash('success', 'Cita actualizada');
    res.redirect('/concierge/citas');
});

router.post('/nuevaCita', async (req, res) => {
    const { IDDoctor, fecha, hora } = req.body;
    const nuevaCita = {
        fecha: fecha,
        hora: hora,
        IDPaciente: req.user.id
    };
    console.log(nuevaCita);
    await pool.query('INSERT INTO citas set ?', [nuevaCita]);
    req.flash('success', 'Cita agendada correctamente');
    res.redirect('/concierge/citas');
});
module.exports = router;