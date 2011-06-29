

var express = require('express')
var path = require('path')
var hbs = require('hbs')

var app = express.createServer()

app.set('views', path.join(__dirname, 'views'));
app.set("view engine", "hbs");
app.set('view options', {layout: false}); 
app.register(".hml", hbs);   

app.get("*", function(req, res, next) {
    res.contentType("text/xml")
    next()
})

app.get('/main', function(req, res) {
    res.render("main.hml", {message:"woot"})
})

app.listen(3021)
