const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const mysql = require('mysql');
const database_config = require('./config/database.js');

const indexRouter = require('./routes/index');
const usersRouter = require('./routes/users');
const infoRouter = require('./routes/info');
const predRouter = require('./routes/pred');
const noFunctionRouter = require('./routes/noFunction');

const app = express();

// DB Connection test
const connection = mysql.createConnection(database_config);
connection.connect();
connection.query('SELECT * FROM user', (error, rows, fields)=> {
  if (error){
    console.log('✗ DB connection error. Please make sure DB is running.');
    console.log(error);
  }else {
    console.log('✓ DB connection success.');
  }
})
connection.end();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'assets')));
app.use('/build/', express.static(path.join(__dirname, 'node_modules/three/build')))
app.use('/jsm/', express.static(path.join(__dirname, 'node_modules/three/examples/jsm')))

app.use('/', indexRouter);
app.use('/info', infoRouter);
app.use('/users', usersRouter);
app.use('/pred', predRouter);
app.use('/noFunction', noFunctionRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error_user');
});

module.exports = app;
