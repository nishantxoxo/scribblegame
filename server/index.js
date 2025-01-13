const express = require("express")
var http = require("http")
const db = require("./url")


const app = express()
const PORT = process.env.PORT || 8000

var server = http.createServer(app)
const mongoose = require('mongoose')
const Room = require('./models/room')
const getWord = require('./api/getWord')
var io = require("socket.io")(server)

app.use(express.json())  // convert all to json


//connect to our database

mongoose.connect(db).then(() => {
    console.log("connection succesful")
}).catch((e) => {
    console.log(e)
})


io.on('connection', (socket)=>{
    console.log("connected")
    socket.on('create-game', async ({nickname, roomName, occupancy, maxRounds}) => {
        try {
            const existingRoom =  await Room.findOne({roomName})
            if (existingRoom){
                socket.emit('notCorrectGame', 'room with that name already exists')
                return
            }
            let room = new Room()
            const word = getWord()
            room.word = word;
            room.name = roomName;
            room.occupancy =occupancy;
            room.maxRounds =maxRounds;
            

            let player = {
                socketID: socket.id,
                nickname,
                isPartyLeader: true
            }
            room.players.push(player)
            room = await room.save()
            socket.join(room)
            io.to(roomName).emit('updateRoom', room)
        } catch (error) {
            console.log(error)
        }
    })
})

server.listen(PORT, "0.0.0.0",()=> {
    console.log("server started")
} )