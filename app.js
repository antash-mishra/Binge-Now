const express = require('express');
const session = require('express-session');
const app = express();
const path = require('path');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const dotenv = require('dotenv');
const { response, request } = require('express');
const mysql = require('mysql');
const { constants } = require('buffer');



dotenv.config({path: './.env'});

const db = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USERNAME,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    port: process.env.DB_PORT
});

app.use(express.urlencoded({ extended : false}));
app.use(express.static('public'));
app.use(cookieParser());
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));

const dbService = require('./dbService');

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended : false}));


//define routes
app.use('/', require('./routes/pages.js'));
app.use('/auth', require('./routes/auth.js'));
app.use('/add', require('./routes/auth.js'));

//create
//app.post('/add_movies', (request, response) => {
//        
//});

//read 
//app.get("/get_movies", (request, response) => {
//    const db = dbService.getDbServiceInstance();
//    console.log('test');
// });

app.get('/moviesList', (req,res, error) => {
    db.query("select title,genre from Movies where movie_id in (select movie_id from user_watchlist_movie where username = ?)",[req.session.username], (err, result) => {
        if (err) throw err;
        console.log(result);
        res.send(result);
    });
});

app.get('/sereisList', (req,res, error) => {
    db.query("select title,genre from Series where series_id in (select series_id from user_watchlist_series where username = ?)",[req.session.username], (err, result) => {
        if (err) throw err;
        console.log(result);
        res.send(result);
    });
});

app.get('/watchedMovieList', (req,res, error) => {
    db.query("SELECT m.title, m.genre, w.date from Movies m, watched_movie w WHERE w.movie_id = m.movie_id AND w.username = ?",[req.session.username], (err, result) => {
        if (err) throw err;
        console.log(result);
        res.send(result);
    });
});

app.get('/watchedSeriesList', (req,res, error) => {
    db.query("SELECT m.title, m.genre, w.date, w.season from Series m, watched_series w WHERE w.series_id = m.series_id AND w.username = ?",[req.session.username], (err, result) => {
        if (err) throw err;
        console.log(result);
        res.send(result);
    });
});

app.get('/seriesReview', (req,res, error) => {
    db.query("call procedure_review_series()", (err, result) => {
        if (err) throw err;
        console.log(result);
        res.send(result);
    });
});

app.get('/movieReview', (req,res, error) => {
    db.query("call procedure_review_movie()", (err, result) => {
        if (err) throw err;
        console.log('review movies');
        console.log(result);
        res.send(result);
    });
});

app.listen(process.env.PORT, () => console.log('App is running'));




