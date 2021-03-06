module.exports = {
    isLoggedIn (req, res, next) {
        if (req.isAuthenticated()) {
            return next();
        }
        return res.redirect('/signin');
    },
    isLoggedInAsPacient (req, res, next) {
        //console.log(req.user.IDPaciente)
        if ((req.isAuthenticated() && req.user.IDPaciente != null) ||(req.isAuthenticated() && req.user.IDCirculo != null) ) {
            return next();
        }
        return res.redirect('/signin');
    },
    isLoggedInAsDoctor (req, res, next) {
        //console.log(req.user.IDPaciente)
        if ((req.isAuthenticated() && req.user.IDDoctor != null)) {
            return next();
        }
        return res.redirect('/signin');
    },
    isNotLoggedIn (req, res, next) {
        if(!req.isAuthenticated()) {
            return next();
        }
        return res.redirect('/profile')
    }
};