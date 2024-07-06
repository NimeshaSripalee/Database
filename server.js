const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const mysql = require('mysql2');

const app = express();
app.use(bodyParser.json());

// mysql connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'tdlj',
    database: 'fadb'
});

// connect to db
db.connect((err) => {
    if (err) {
        console.error('Error connecting to the database', err);
        return;
    }
    console.log('Connected to database');
});

// registration as generalpublic
app.post('/api/register/general-public', (req, res) => {
    const { username, email, password } = req.body;

    // log the incoming request body
    console.log('Received request body:', req.body);

    //check email, username, password are defined
    if (!username || !email || !password) {
        return res.status(400).send('Username, email, and password are required');
    }

    // hash password
    const hashedPassword = bcrypt.hashSync(password, 8);

    // insert into user table
    db.query(
        'INSERT INTO User (username, email, password, type_of_user) VALUES (?, ?, ?, "GeneralPublic")',
        [username, email, hashedPassword],
        (err, result) => {
            if (err) {
                console.error('Error inserting into User table', err);
                return res.status(500).send('Error registering user');
            } 
                
                

            const userId = result.insertId;

            // Insert into generalPublic table
            db.query('INSERT INTO GeneralPublic (user_ID) VALUES (?)', [userId],  (err) =>  {
                if (err) {
                    console.error('Error inserting into General public table', err);
                    return res.status(500).send('error registering user');
                }
                    
                res.status(200).send('registration successful as generalpublic');
            });
        }
    
    ); 

});

// registration as ambulance
app.post('/api/register/ambulance', (req, res) => {
    const { username, email, password } = req.body;

    // log the incoming request body
    console.log('Received request body:', req.body);

    //check email, username, password are defined
    if (!username || !email || !password) {
        return res.status(400).send('Username, email, and password are required');
    }

    // hash password
    const hashedPassword = bcrypt.hashSync(password, 8);

    // insert into user table
    db.query(
        'INSERT INTO User (username, email, password, type_of_user) VALUES (?, ?, ?, "Ambulance")',
        [username, email, hashedPassword],
        (err, result) => {
            if (err) {
                console.error('Error inserting into User table', err);
                return res.status(500).send('Error registering user');
            } 
                
                

            const userId = result.insertId;

            // Insert into ambulance table
            db.query('INSERT INTO Ambulance (user_ID) VALUES (?)', [userId],  (err) =>  {
                if (err) {
                    console.error('Error inserting into ambulance table', err);
                    return res.status(500).send('error registering user');
                }
                    
                res.status(200).send('registration successful as ambulance');
            });
        }
    
    ); 

});

// login 
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;

    // log incoming request 
    console.log('Received login request body:', req.body);

    // check email, password defined
    if (!username || !password) {
        return res.status(400).send('Username and password are required');

    }

    //find user by username or email
    db.query('SELECT * FROM  User WHERE username = ? OR email = ?', [username, username], (err, results) => {
        if (err) {
            console.error('Error fetching user from User table', err);
            return res.status(404).send('User not found');
        }

        if (results.length === 0) {
            return res.status(404).send('User not found');
        }

        const user = results[0];

        // compare password 
        const passwordIsValid = bcrypt.compareSync(password, user.password);
        
        if (!passwordIsValid) {
            return res.status(401).send('Invalid password');
        }

        //determine user type
        if (user.type_of_user === 'GeneralPublic') {
            res.status(200).send('login successful as  General public');
        }else if (user.type_of_user === 'Ambulance') {
            res.status(200).send('Login successful as Ambulance');
        } else {
            res.status(400).send('unknown user type');
        }
    });
});


// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});