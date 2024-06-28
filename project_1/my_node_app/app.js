
const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => {
    res.send('Hello, world... This is my simple web application for  my capstone project!')
})

app.listen(port, () => {
    console.log("Listening for request at port " + port)
})