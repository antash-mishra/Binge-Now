const express = require('express');
const path = require('path');

const router = express.Router();

router.get('/', (req, res) => {
    console.log(path.join('../views/index.html'));
    res.sendFile(path.join('/home/antash/binge-backend-js/views/index.html'));

});

router.get('/register.html', (req, res) => {
    res.sendFile(path.join('/home/antash/binge-backend-js/views/register.html'));
});

router.get('/index.html', (req, res) => {
    res.sendFile(path.join('/home/antash/binge-backend-js/views/index.html'));
});

router.get('/Home.html', (req,res) => {
    console.log(typeof req.session.username);
    res.sendFile('/home/antash/binge-backend-js/views/Home.html')
})

router.get('/movie.html', (req,res) => {
    res.sendFile('/home/antash/binge-backend-js/views/movie.html')
})

router.get('/watched.html', (req,res) => {
    res.sendFile('/home/antash/binge-backend-js/views/watched.html')
})

router.get('/signIn.html', (req,res) => {
    res.sendFile('/home/antash/binge-backend-js/views/signIn.html')
})

router.get('/moviesList.html', (req, res) => {
    res.sendFile('/home/antash/binge-backend-js/views/moviesList.html')  
})

router.get('/sereisList.html', (req, res) => {
    res.sendFile('/home/antash/binge-backend-js/views/sereisList.html')  
})

router.get('/watchedMovieList.html', (req, res) => {
    res.sendFile('/home/antash/binge-backend-js/views/watchedMovieList.html')  
})

router.get('/watchedSeriesList.html', (req, res) => {
    res.sendFile('/home/antash/binge-backend-js/views/watchedSeriesList.html')  
})

router.get('/seriesReviews.html', (req, res) => {
    res.sendFile('/home/antash/binge-backend-js/views/seriesReviews.html')  
})

router.get('/movieReviews.html', (req, res) => {
    res.sendFile('/home/antash/binge-backend-js/views/movieReviews.html')  
})

module.exports = router;
