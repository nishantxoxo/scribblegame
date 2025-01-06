const express = require("express")
var http = require("http")
const db = require("./url")


const app = express()
const PORT = process.env.PORT || 8000

var server = http.createServer(app)
const mongoose = require('mongoose')

var io = require("socket.io")(server)

app.use(express.json())  // convert all to json


//connect to our database

mongoose.connect(db).then(() => {
    console.log("connection succesful")
}).catch((e) => {
    console.log(e)
})

server.listen(PORT, "0.0.0.0",()=> {
    console.log("server started")
} )