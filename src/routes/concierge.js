const express = require('express');
const router = express.Router();
const passport = require('passport');
const pool = require('../database');
const { isLoggedInAsPacient } = require('../lib/auth');


router.get('/', isLoggedInAsPacient, async (req, res) => {
    if(req.user.IDCirculo)
    {
        const datosPaciente= await pool.query(`SELECT * 
        FROM paciente INNER JOIN circulopaciente ON circulopaciente.IDPaciente = paciente.IDPaciente INNER JOIN
        circulo ON circulopaciente.IDCirculo = circulo.IDCirculo WHERE circulopaciente.IDCirculo= ?`, req.user.IDCirculo);
        console.log(datosPaciente)
        let datos = {IDCirculo: datosPaciente[0].IDCirculo,
                    nombre:datosPaciente[0].nombre,
                    apellidoPaterno:datosPaciente[0].apellidoPaterno};
        console.log(datos)     
        res.render('concierge/panel', {datos});
    }
    else{
        const datosPaciente= await pool.query(`SELECT * 
        FROM paciente WHERE IDPaciente = ?`, req.user.IDPaciente)
        console.log(datosPaciente)
        res.render('concierge/panel', {datos: datosPaciente[0]});
    }

});

router.get('/agregarCirculo', isLoggedInAsPacient, async (req, res) => {
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
    const datosPaciente= await pool.query(`SELECT * 
    FROM paciente WHERE IDPaciente = ?`, id_Paciente)
    console.log(datosPaciente)
    res.render('concierge/agregarCirculo', {datos: datosPaciente[0]});
});

router.get('/gestionSeguro', isLoggedInAsPacient, async (req, res) => {
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
    const datosSeguro= await pool.query(`SELECT * 
    FROM aseguradora`)
    console.log(datosPaciente)
    res.render('concierge/gestionSeguro', {seguros: datosSeguro});
});
router.get('/citas', isLoggedInAsPacient, async (req, res) => {
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
    const citas = await pool.query(`SELECT * 
    FROM citas INNER JOIN citasdoctores
    ON citasdoctores.IDCita = citas.IDCita
    INNER JOIN doctores 
    on citasdoctores.IDDoctor = doctores.IDDoctor
    WHERE IDPaciente = ?`, [id_Paciente]);
    //console.log(citas);
    res.render('concierge/citas', { citas });

});

router.get('/nuevaCita', isLoggedInAsPacient, async (req, res) => {
    const doctores = await pool.query(`SELECT * 
    FROM doctores INNER JOIN especialidadesdoctores
    ON especialidadesdoctores.IDDoctor = doctores.IDDoctor
    INNER JOIN especialidades
    ON especialidadesdoctores.IDEspecialidad = especialidades.IDEspecialidad`);
    console.log(doctores);
    res.render('concierge/nuevaCita', {doctores});

});

router.get('/tratamiento', isLoggedInAsPacient, async (req, res) => {
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
    const tratamiento = await pool.query(`SELECT * 
    FROM tratamiento WHERE IDPaciente = ?` , [id_Paciente]);
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

});

router.get('/medicamentos', isLoggedInAsPacient, async (req, res) => {
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
    const medicamentos = await pool.query(`select medicamentos.IDMedicamento, medicamentos.nombreMedicamento, medicamentospacientes.indicaciones
    from medicamentos inner join medicamentospacientes
    on medicamentospacientes.IDMedicamento=medicamentos.IDMedicamento
    where medicamentospacientes.IDPaciente=?`, [id_Paciente]);
    res.render('concierge/medicamentos', { medicamentos });
});

router.get('/deleteCita/:id', isLoggedInAsPacient, async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM citas WHERE IDCita = ?', [id]);
    req.flash('success', 'Cita eliminada correctamente');
    res.redirect('/concierge/citas');
});

router.get('/editCita/:id', isLoggedInAsPacient, async (req, res) => {
    const { id } = req.params;
    const citas = await pool.query(`SELECT * FROM citas INNER JOIN citasdoctores
    ON citasdoctores.IDCita = citas.IDCita INNER JOIN doctores 
    ON citasdoctores.IDDoctor = doctores.IDDoctor WHERE citas.IDCita = ?`, [id]);
    const doctores = await pool.query(`SELECT * FROM doctores`);

    //const citas = null;
    //console.log(links);
    res.render('concierge/editCita', {cita: citas[0], doctores: doctores});
});



//MÉTODOS POST

router.post('/editCita/:id', isLoggedInAsPacient, async (req, res) => {
    console.log(req.params)
    const { id } = req.params;
    const { IDDoctor, fecha, hora } = req.body;
    const nuevaCita = {
        fecha: fecha,
        hora: hora,
        IDPaciente: req.user.IDPaciente
    };
    //console.log(nuevaCita, id);
    await pool.query('UPDATE citas set ? WHERE IDCita = ?', [nuevaCita, id]);
    req.flash('success', 'Cita actualizada');
    res.redirect('/concierge/citas');
});
router.post('/agregarCirculo', isLoggedInAsPacient, passport.authenticate('local.signupC', {
    successRedirect: '/profile',
    failureRedirect: '/agregarCirculo',
    failureFlash: true
  }));
router.post('/gestionSeguro', isLoggedInAsPacient, async (req, res) => {
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
    const { IDDoctor, IDAseguradora } = req.body;
    const nuevaCita = {
        IDAseguradora: IDAseguradora,
        IDPaciente: id_Paciente
    };
    const test = await pool.query('INSERT INTO aseguradorapaciente set ?', [nuevaCita]);
    
    
    req.flash('success', 'Reembolso procesado correctamente');
    res.redirect('/concierge/');
  
});

module.exports = router;