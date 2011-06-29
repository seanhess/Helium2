

var express = require('express')
var path = require('path')
var hbs = require('hbs')

var app = express.createServer()

app.set('views', path.join(__dirname, 'views'));
app.set("view engine", "hbs");
app.set('view options', {layout: false}); 
app.register(".hml", hbs);   

app.get("*.hml", function(req, res, next) {
    res.contentType("text/xml")
    next()
})

app.get('/:name.hml', function(req, res) {
    var template = req.param('name') + ".hml"
    res.render(template, {message:"woot"})
})

app.listen(3021)
