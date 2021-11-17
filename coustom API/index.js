const express = require('express');
const mongoose = require('mongoose');
const dbConfig = require('./config/db.config');
const cors = require('cors')
const auth = require('./middlewares/auth');
const error = require('./middlewares/errors');

const unless = require('express-unless');

const app = express();

app.use(cors())
mongoose.Promise = global.Promise;
mongoose.connect(dbConfig.db,{
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(
    () => {
        console.log('Database connected');
    },
    (error) =>{
        console.log("Database can't be connected" +error);
    }
);

auth.authenticateToken.unless = unless;
app.use(
    auth.authenticateToken.unless({
        path:[
            {url:"/users/login",methods:["POST"]},
            {url:"/users/register",method:["POST"]},
        ],
    })
);

app.use(express.json());

app.use("/users",require("./routes/user.routes"));

app.use(error.errorHandler);

app.listen(process.env.port || 4000, function(){
    console.log("ready to go");
});