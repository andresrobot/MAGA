const express = require('express');
const router = express.Router();

const passport = require('passport');
const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');

const pool = require('../database');
// SIGNUP
router.get('/signup', isNotLoggedIn, (req, res) => {
  res.render('auth/signup');
});

router.post('/signup', passport.authenticate('local.signup', {
  successRedirect: '/profile',
  failureRedirect: '/signup',
  failureFlash: true
}));

// SINGIN
router.get('/signin', isNotLoggedIn, (req, res) => {
  res.render('auth/signin');
});



router.post('/signin', (req, res, next) => {
  req.check('username', 'Username is Required').notEmpty();
  req.check('password', 'Password is Required').notEmpty();
  const errors = req.validationErrors();
  if (errors.length > 0) {
    req.flash('message', errors[0].msg);
    res.redirect('/signin');
  }
  passport.authenticate('local.signin', {
    successRedirect: '/profile',
    failureRedirect: '/signin',
    failureFlash: true
  })(req, res, next);
});

router.get('/logout', isLoggedIn, (req, res) => {
  req.logOut();
  res.redirect('/');
});

router.get('/profile', isLoggedIn, async (req, res) => {
  if (req.user.IDPaciente){
    const data = await pool.query(`SELECT * FROM paciente WHERE IDPaciente = ?`, req.user.IDPaciente)
    res.render('profile', {data: data[0]});
  }
  else if(req.user.IDDoctor)
  {
  const data = await pool.query(`SELECT * FROM doctores WHERE IDDoctor = ?`, req.user.IDDoctor);
    res.render('profile', {data: data[0]})
  }
  else if(req.user.IDAseguradora)
  {
    const data = await pool.query(`SELECT * FROM aseguradora WHERE IDAseguradora = ?`, req.user.IDAseguradora);
    res.render('profile', {data: data[0]})
  }
  else if (req.user.IDCirculo){
    const data = await pool.query(`SELECT * FROM circulo WHERE IDCirculo = ?`, req.user.IDCirculo);
    console.log(data[0].IDCirculo)
    res.render('profile', {data: data[0]})
  }
});

module.exports = router;
