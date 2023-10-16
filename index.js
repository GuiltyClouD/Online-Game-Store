var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var path = require('path');
var flash = require('connect-flash');

var connection = mysql.createConnection({
	host     : 'localhost',
	user     : 'root',
	password : 'tic2601',
	database : 'myproj',
	multipleStatements: true
});

connection.connect(function(err){
if(!err) {
    console.log("Database is connected!");
} else {
    console.log("Error while connecting with database");
}
});

const {
	promisify,
  } = require('util');
const { profile } = require('console');
  const queryAsync = promisify(connection.query).bind(connection);


var app = express();

app.use(session({
	key:'user_id',
	secret: 'secret',
	resave: false,
	saveUninitialized: false,
	cookie: {
		expires: 600000
	}
}));


app.use(function(req, res, next){
   res.locals.currentUser = req.session.user;
   next();
});

app.use(flash()); 

app.use((req, res, next) => {
  res.locals.flashMessages = req.flash();
  next();
});

app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use(express.static('assets'));

//Handling calling of login page
app.get('/login', function(req, res) {
	res.render('login');  
});

//Handling calling of register page
app.get('/reg', function(req, res) {
		res.render('register');
});

//Handling calling of home/landing page
app.get('/', isLoggedIn, function(req,res) {
	res.render('home'); 
});


//Handle calling of shopping cart directly 
app.get('/cart', isLoggedIn, function(req, res) {

	var game_data = {}; 

	connection.query('SELECT * FROM gamestore, shoppingcart WHERE shoppingcart.gameID = gamestore.gameID AND shoppingcart.customerID = '+req.session.user.customerID+'', 
		function(err, rows) {

		if(err) {
			throw err;
		} 

		else if(rows.length == 0) {
			req.flash('message_cart', 'Your shopping cart is currently empty');
				game_data = rows;
				res.render('purchase', {
				game_data: game_data
			});
		}

		else {
				game_data = rows;
				res.render('purchase', {
				game_data: game_data
			});
		}
	});
	
});

//Handling data posted from register page 
app.post('/reg', function(req, res) {
	var name = req.body.name;
	var email = req.body.email;
	var password = req.body.password;
	var DOB = req.body.DOB; 
	
	connection.query('SELECT * FROM customer WHERE email = ?', [email], function(err, result, fields) {
		if(result.length > 0) {
			req.flash('message_email', 'Email is already in use! Please register with a different one!');
			res.redirect('/reg');
		
		} else {
			connection.query('SELECT * FROM admin WHERE email = ?', [email], function(err, result, fields) {
				if(result.length > 0) {
					req.flash('message_email', 'Email is already in use! Please register with a different one!');
					res.redirect('/reg');
				} else {
					connection.query("INSERT INTO customer (name, email, password, DOB) VALUES ('"+name+"', '"+email+"', md5('"+password+"'), '"+DOB+"')", function(err, result, fields) {
						if(err) {
							res.send('Something wrong with the query!')
						} else {
							req.flash('message_success', 'Successful Registration! Please login to start your shopping experience!'); 
							res.redirect('/login'); 
					
						}
					}); 
				}
			});
		}
		
	});
});
	
//Handling login form data posted to /auth route
app.post('/auth', function(req, res) {
	var email = req.body.email;
	var password = req.body.password;
	if (email && password) {
		connection.query('SELECT * FROM customer WHERE email = ? AND password = md5(?)', [email, password], function(error, results, fields) {
			if (results.length > 0) {
				req.session.user = results[0]; 
				req.flash('message_auth', 'Welcome ' + req.session.user.name + '!');
				res.redirect('/home');
			} else {
				connection.query('SELECT * FROM admin WHERE email = ? AND password = ?', [email, password], function(error, results, fields){
					if (results.length > 0) {
						req.session.user = results[0];
						res.redirect('/adminhome');
					} else {
						req.flash('message_cred', 'Please login with correct credentials!');
						res.redirect("/login")
					}
				});
				
			}			
		});
	} 
});

//Handling logout route
app.get('/logout', (req, res) => {
    if (req.session.user) {
        req.session.destroy();
        res.redirect('/home');
    } else {
        res.redirect('/login');
    }
});

//Route to handle loading of game page to display individual games' details 
app.get('/game/:id', isLoggedIn, function(req,res) {

	var game_id = req.params.id;
	var game_data = {}; 

	connection.query('SELECT * FROM gamestore WHERE gameID = '+game_id+'', function(err, rows) {
		if(err) {
			throw err;
		} else {
			game_data = rows;
			res.render('game page', {
				game_data: game_data
			});
		}
	}); 

});

//Route to handle adding of game into shopping cart 
app.get('/purchase/:id', isLoggedIn, function(req, res) {

	var game_id = req.params.id;
	var game_data = {}; 

	connection.query('SELECT * FROM transactionhistory WHERE gameID = '+game_id+' AND customerID = '+req.session.user.customerID+'', function(err, results) {
		if(results.length > 0) {
			req.flash('message_bought', 'You had already bought this game in the past'); 
			res.redirect('/home');

		} else {
			connection.query('SELECT * FROM shoppingcart WHERE gameID = '+game_id+' AND customerID = '+req.session.user.customerID+'', function(err, rows) {
				if(rows.length > 0) {
					req.flash('message_shop', 'You had already added this game into the shopping cart');
					res.redirect('/home');
				}
				else {
					connection.query("INSERT INTO shoppingcart (customerID, gameID) VALUES ('"+req.session.user.customerID+"', '"+game_id+"')", function(err, result, fields) {
						if(err) {
							res.send('Something wrong with the query!')
						} else {
							connection.query('SELECT * FROM gamestore, shoppingcart WHERE shoppingcart.gameID = gamestore.gameID AND shoppingcart.customerID = '+req.session.user.customerID+'',
								function(err, rows) {
									if(err) {
										throw err;
									} else {
										game_data = rows;
											res.render('purchase', {
											game_data: game_data
										});
									}
							});
						}

					});
				}
			});

		}	 
		
	});

});

//Route to handle deleting game added to shopping cart 
app.post('/delete/:id', function(req, res) {

	var game_id = req.params.id;
	var game_data = {}; 

	connection.query('DELETE FROM shoppingcart WHERE gameID = '+game_id+'', function(err, results) {
		if(err) {
			throw err;
		} else {
			connection.query('SELECT * FROM gamestore, shoppingcart WHERE shoppingcart.gameID = gamestore.gameID', function(err, rows) {
				if(err) {
					throw err;
				} else {
					game_data = rows;
						res.render('purchase', {
						game_data: game_data
					});
				}
			});	
		}
	});

});

//Route to handle checking out of game(s)
app.post('/checkout', function(req, res) {

	var credit = req.body.creditCard;
	var add = req.body.address;
	var tele = req.body.telephone; 
	var formate_date="";
    var d = new Date();
    formate_date += d.getFullYear()+"/"+(d.getMonth()+1)+"/"+d.getDate(); 




	connection.query("UPDATE customer SET address = '"+add+"', telephone = '"+tele+"', creditCard = '"+credit+"' WHERE customerID = '"+req.session.user.customerID+"'",
		function(err, rows) {
			if(err) {
				throw err;
			} else {	
					console.log("Updating ok and user details updated in database");
					}
			});

	connection.query('SELECT * FROM customer WHERE customerID = '+req.session.user.customerID+'', function(err, result, fields) {
			if (result.length > 0) {
				req.session.user = result[0];
				console.log("User details updated!");
			}
	});
	
	connection.query("SELECT * FROM shoppingcart WHERE customerID = '"+req.session.user.customerID+"'", function(err, result) {
					if(err) {
						throw err;
					} else {
						for(var i=0; i < result.length; i++) {
							connection.query("INSERT INTO transactionhistory (customerID, gameID, PurchaseDate) VALUES('"+result[i].customerID+"', '"+result[i].gameID+"', '"+formate_date+"')",
								function(err, result, field) {
									if(err) {
										throw err;
									} else {
										console.log("Insertion Ok!") 
									}
							});
						}
					}
				});
		
	
	connection.query('DELETE FROM shoppingcart WHERE shoppingcart.customerID = '+req.session.user.customerID+'', function(err, results,field) {
		if(err) {
			throw err;
		} else {
			req.flash('message_checkout', 'Thanks for your purchase!');
				res.redirect('/home'); 
			}
	}); 
});

	
//Middleware to check if user is logged in
function isLoggedIn(req, res, next){
    if(req.session.user){
        return next();
    }	
    	req.flash('message_login', 'Please log in to view page!');
        res.redirect("/login");

};

app.get('/profile', isLoggedIn, function(req, res) {

	var game_data = {}; 

	connection.query('SELECT * FROM customer WHERE customerID = '+req.session.user.customerID+'', 
		function(err, rows) {

		if(err) {
			throw err;
		} 

		else {
				game_data = rows;
				res.render('profile', {
				game_data: game_data
			});
		}
	});
	
});


app.post('/UPprofile', function(req, res) {

	var name = req.body.name;
	var add = req.body.address;
	var tele = req.body.telephone; 
	var credit = req.body.creditCard;

	connection.query("UPDATE customer SET address = '"+add+"', telephone = '"+tele+"', creditCard = '"+credit+"', name = '"+name+"' WHERE customerID = '"+req.session.user.customerID+"'",
		function(err, rows) {
			if(err) {
				throw err;
			} else {
					req.flash('profile updated');	
					console.log("Updating ok and user details updated in database");
					}
			});
	connection.query('SELECT * FROM customer WHERE customerID = '+req.session.user.customerID+'', function(err, result, fields) {
		if (result.length > 0) {
			req.session.user = result[0];
			console.log("User details updated!");
			req.flash('Profile updated');
			res.redirect('/profile');
		}
	});
	
});


app.post('/UPpass', function(req, res) {

	var opass = req.body.cPassword;
	var npass = req.body.nPassword;
	var cnpass = req.body.cnPassword;

	connection.query("SELECT * FROM customer WHERE password = md5('"+opass+"') AND customerID = '"+req.session.user.customerID+"'", function(error, results, fields) {
		if (results.length > 0) {
			connection.query("UPDATE customer SET password = md5('"+cnpass+"') WHERE customerID = "+req.session.user.customerID+"", function(err, results, fields) {
				if(err) {
					throw err;
				}else{
					req.flash('message_pass', 'Password Updated');
					console.log("Password updated");
					res.redirect('profile');
				}
			});
		}else {
			req.flash('message_pass', 'Current password incorrect');
			res.redirect('profile');
			}
	});
});

//show all games to allow for editing
app.get('/allgames', isLoggedIn, async (req, res) => {
	var game_data = {}; 
	const genreSQL = 'SELECT DISTINCT gameGenre FROM gamegenre ORDER BY gameGenre ASC';

	if (req.query.search)
	{
	  gameSQL=`SELECT * FROM gamestore WHERE gamestore.gameTitle Like '%${req.query.search}%' group by gameTitle`
	} 
	else if (req.query.Genre)
	  {
		gameSQL = `SELECT * FROM gamestore INNER JOIN gamegenre ON gamestore.gameID=gamegenre.gameID WHERE gamegenre.gameGenre = '${req.query.Genre}'`
	  } 
	else
	{
	  gameSQL = 'SELECT * FROM gamestore';
	}
	  game_data = await queryAsync(gameSQL);
	  genres = await queryAsync(genreSQL);	
	  res.render('allgames', 
	  {
	  game_data: game_data,
	  genres:genres
	});
		
});

//page to show game editable fields
app.get('/editgames/:id', isLoggedIn, function(req,res) {

	var game_id = req.params.id;
	var game_data = {};
	var game_data2 = {}; 

	connection.query('SELECT gameGenre FROM gamegenre WHERE gameID = '+game_id+'', function(err, rows) {
		if (err) {
			throw err;
		} else {
			game_data2 = rows;
		}
	})
	
	connection.query('SELECT * FROM gamestore WHERE gameID = '+game_id+'', function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data = rows;
			res.render('editgames', {
			game_data: game_data,
			game_data2: game_data2
			});
		}
	});
});

//update database
app.post('/edit/:id', function(req,res) {

	var game_id = req.params.id;

	var game_title = req.body.title;
	var game_description = req.body.description;
	var game_price = req.body.price;
	var game_date = req.body.date;
	var game_image = req.body.image;
	var game_genre = req.body.genre; 

	var game_string = game_genre.split(", ");

	var game_data = {};
	connection.query("UPDATE gamestore SET gameTitle = '"+game_title+"', gameDescription = '"+game_description+"', price = '"+game_price+"', releaseDate = '"+game_date+"', gameImage = '"+game_image+"' WHERE gameID = '"+game_id+"'",
	function(err, rows) {	
			if(err) {
					res.send('Something wrong with the query!')
				}
			else {
					console.log("Updated game data!");
				}
	});

	connection.query("Delete FROM gamegenre WHERE gameID = '"+game_id+"'", function(err, results) {
		if(err) {
			throw err;
		} else {
			console.log("Deletion of gamegenre ok")
		}
	});

	for(var i=0; i < game_string.length; i++) { 
	connection.query("INSERT INTO gamegenre (gameID, gameGenre) VALUES ('"+game_id+"', '"+game_string[i]+"') ON DUPLICATE KEY UPDATE gameID = gameID, gameGenre = gameGenre",
			function(err, result, field) {
				if(err) {
					throw err;
				} else {
					console.log("Insertion into gamegenre ok")
				}
		});
	}

	 connection.query('SELECT * FROM gamestore', function(err, rows) {
	 	if(err) {
	 		throw err;
	 	}
	 	else {
	 		game_data = rows;
	 		res.render('allgames', {
	 		game_data: game_data
	 		});
	 	}
	 });
	
});

app.get('/adminhome', isLoggedIn, function(req,res) {

	var game_data_sum30 = {};
	var game_data_total_sold30 = {};
	var game_data_total_games30 = {};
	var game_data_sum90 = {};
	var game_data_total_sold90 = {};
	var game_data_total_games90 = {};
	var game_data_sum180 = {};
	var game_data_total_sold180 = {};
	var game_data_total_games180 = {};
	var game_data_sumALL = {};
	var game_data_total_soldALL = {};
	var game_data_total_gamesALL = {};
	
	connection.query('SELECT gamestore.price FROM gamestore INNER JOIN transactionhistory ON gamestore.gameID = transactionhistory.gameID WHERE DATEDIFF(NOW(), transactionhistory.PurchaseDate) <= 30', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_sum30 = rows;
		}
	});

	connection.query('SELECT gameID FROM transactionhistory WHERE DATEDIFF(NOW(), PurchaseDate) <= 30', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_sold30 = rows;
		}
	});

	connection.query('SELECT gameID FROM gamestore WHERE DATEDIFF(NOW(), releaseDate) <= 30', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_games30 = rows;
		}
	});

	connection.query('SELECT gamestore.price FROM gamestore INNER JOIN transactionhistory ON gamestore.gameID = transactionhistory.gameID WHERE DATEDIFF(NOW(), transactionhistory.PurchaseDate) <= 90', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_sum90 = rows;
		}
	});

	connection.query('SELECT gameID FROM transactionhistory WHERE DATEDIFF(NOW(), PurchaseDate) <= 90', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_sold90 = rows;
		}
	});

	connection.query('SELECT gameID FROM gamestore WHERE DATEDIFF(NOW(), releaseDate) <= 90', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_games90 = rows;
		}
	});

	connection.query('SELECT gamestore.price FROM gamestore INNER JOIN transactionhistory ON gamestore.gameID = transactionhistory.gameID WHERE DATEDIFF(NOW(), transactionhistory.PurchaseDate) <= 180', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_sum180 = rows;
		}
	});

	connection.query('SELECT gameID FROM transactionhistory WHERE DATEDIFF(NOW(), PurchaseDate) <= 180', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_sold180 = rows;
		}
	});

	connection.query('SELECT gameID FROM gamestore WHERE DATEDIFF(NOW(), releaseDate) <= 180', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_games180 = rows;
		}
	});

	connection.query('SELECT gamestore.price FROM gamestore INNER JOIN transactionhistory ON gamestore.gameID = transactionhistory.gameID', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_sumALL = rows;
		}
	});

	connection.query('SELECT gameID FROM transactionhistory', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_soldALL = rows;
		}
	});

	connection.query('SELECT gameID FROM gamestore', 
	function(err, rows) {
		if(err) {
			throw err;
		}
		else {
			game_data_total_gamesALL = rows;
			res.render('adminhome', {
				game_data_sum30: game_data_sum30,
				game_data_total_sold30: game_data_total_sold30,
				game_data_total_games30: game_data_total_games30,
				game_data_sum90: game_data_sum90,
				game_data_total_sold90: game_data_total_sold90,
				game_data_total_games90: game_data_total_games90,
				game_data_sum180: game_data_sum180,
				game_data_total_sold180: game_data_total_sold180,
				game_data_total_games180: game_data_total_games180,
				game_data_sumALL: game_data_sumALL,
				game_data_total_soldALL: game_data_total_soldALL,
				game_data_total_gamesALL: game_data_total_gamesALL
				});
		}
	});

});


//new home page logic
app.get('/home',isLoggedIn, async (req, res) => {
	const genreSQL = 'SELECT DISTINCT gameGenre FROM gamegenre ORDER BY gameGenre ASC';
	const imageSQL = 'SELECT DISTINCT gameImage FROM gamestore';
	let gameSQL = `SELECT * FROM gamestore INNER JOIN gamegenre ON gamestore.gameID=gamegenre.gameID`;
	const newgameSQL=`select * from gamestore where period_diff(date_format(now() , '%Y%m') , date_format(releaseDate, '%Y%m')) =1 ORDER BY releaseDate DESC LIMIT 5`;
	const topsellergamesSQL ='SELECT count_table.count_number, gamestore.* FROM (SELECT gameID,COUNT(*) AS count_number FROM transactionhistory GROUP BY gameID ORDER BY count_number DESC ) AS count_table INNER JOIN gamestore ON gamestore.gameID = count_table.gameID LIMIT 5';
	const upcomingSQL='SELECT * FROM gamestore WHERE releaseDate > CURDATE() ORDER BY releaseDate ASC LIMIT 5';
	let genres = {};
	let games = {};  
	let images = {};
	let newgames={};
	let upcominggames={};
	let topsellergames={};
  
	try {	  
	  if (req.query.search)
	  {
		gameSQL=`SELECT gamestore.*, gameTitle FROM gamestore INNER JOIN gamegenre ON gamestore.gameID=gamegenre.gameID WHERE gamestore.gameTitle Like '%${req.query.search}%' group by gameTitle` ;
		genres = await queryAsync(genreSQL);
		games = await queryAsync(gameSQL);
		res.render
		('search',
		{
			games:games,
			genres:genres
		}
		)
	  } 
	  else if (req.query.Genre)
	  {
		gameSQL = `SELECT * FROM gamestore INNER JOIN gamegenre ON gamestore.gameID=gamegenre.gameID WHERE gamegenre.gameGenre ='${req.query.Genre}'`
		genres = await queryAsync(genreSQL);
		games = await queryAsync(gameSQL);
		res.render
		('search',
		{
			games:games,
			genres:genres
	    }
	  	)
	  } 
	  else if (req.query.search && req.query.Genre)
	  {
		gameSQL = `SELECT gamestore.*, gameTitle FROM gamestore INNER JOIN gamegenre ON gamestore.gameID=gamegenre.gameID WHERE gamestore.gameTitle Like '%${req.query.search}%' group by gameTitle AND gamegenre.gameGenre = '${req.query.Genre}'`;
		genres = await queryAsync(genreSQL);
		games = await queryAsync(gameSQL);
		res.render
		('search',
		{
			games:games,
			genres:genres
		})
	  } 

	  genres = await queryAsync(genreSQL);
	  images = await queryAsync(imageSQL);
	  games = await queryAsync(gameSQL);
	  newgames=await queryAsync(newgameSQL);
	  upcominggames=await queryAsync(upcomingSQL);
	  topsellergames=await queryAsync(topsellergamesSQL);	
	  res.render('home', {
		upcominggames:upcominggames,
		newgames:newgames,
		genres: genres,
		images: images,
		games: games,
		topsellergames:topsellergames

	  });
	} catch (err) {
	  console.log('SQL error', err);
	  res.status(500).send('Something went wrong');
	}
  });

  
  //new games page 
app.get('/new%20games',isLoggedIn,async (req, res) => {
	const genreSQL = 'SELECT DISTINCT gameGenre FROM gamegenre ORDER BY gameGenre ASC';
	let newgameSQL=`SELECT * from gamestore where period_diff(date_format(now() , '%Y%m') , date_format(releaseDate, '%Y%m')) =1 ORDER BY releaseDate DESC`;
	
	if (req.query.search){
		newgameSQL=`select * from gamestore where period_diff(date_format(now() , '%Y%m') , date_format(releaseDate, '%Y%m')) =1 and gamestore.gameTitle Like '%${req.query.search}%'`;
	}
	else if(req.query.Genre)
	{
		newgameSQL=`SELECT * FROM gamestore INNER JOIN gamegenre ON gamestore.gameID=gamegenre.gameID where period_diff(date_format(now() , '%Y%m') , date_format(gamestore.releaseDate, '%Y%m')) =1 AND gamegenre.gameGenre ='${req.query.Genre}'`
	}
	try {
		games = await queryAsync(newgameSQL)	
		genres = await queryAsync(genreSQL);
		res.render('new games', {
		  games: games,
		  genres: genres
		});
	  } catch (err) {
		console.log('SQL error', err);
		res.status(500).send('Something went wrong');
	  }
	  
});

//upcoming page
app.get('/upcoming',isLoggedIn,async (req, res) => {
	const genreSQL = 'SELECT DISTINCT gameGenre FROM gamegenre ORDER BY gameGenre ASC';
	let upcomingSQL = 'SELECT * FROM gamestore WHERE releaseDate > CURDATE() ORDER BY releaseDate ASC';
	if (req.query.search){
		upcomingSQL=`SELECT * FROM gamestore WHERE releaseDate > CURDATE() and gamestore.gameTitle Like '%${req.query.search}%'`;
	}
	else if(req.query.Genre)
	{
		upcomingSQL=`SELECT * FROM gamestore INNER JOIN gamegenre ON gamestore.gameID=gamegenre.gameID where releaseDate > CURDATE() AND gamegenre.gameGenre ='${req.query.Genre}'`
	}
	let games = {};  
	try {
		games = await queryAsync(upcomingSQL)
		genres = await queryAsync(genreSQL);	
		res.render('upcoming', {
		  games: games,
		  genres: genres
		});
	  } catch (err) {
		console.log('SQL error', err);
		res.status(500).send('Something went wrong');
	  }
});

//topseller page
app.get('/top%20seller',isLoggedIn,async (req, res) =>{
	const genreSQL = 'SELECT DISTINCT gameGenre FROM gamegenre ORDER BY gameGenre ASC';
	let topsellerSQL = 'select count_table.count_number, gamestore.* from (SELECT gameID,COUNT(*) as count_number FROM transactionhistory GROUP BY gameID ORDER BY count_number DESC ) as count_table inner join gamestore on gamestore.gameID = count_table.gameID;';
	if (req.query.search){
		topsellerSQL=`select count_table.count_number, gamestore.* from (SELECT gameID,COUNT(*) as count_number FROM transactionhistory GROUP BY gameID ORDER BY count_number DESC ) as count_table inner join gamestore on gamestore.gameID = count_table.gameID and gamestore.gameTitle Like '%${req.query.search}%'`;
	}
	else if(req.query.Genre)
	{
		topsellerSQL=`select count_table.count_number, gamestore.* from (SELECT gameID,COUNT(*) as count_number FROM transactionhistory GROUP BY gameID ORDER BY count_number DESC ) as count_table inner join gamestore on gamestore.gameID = count_table.gameID inner join gamegenre on gamegenre.gameID=count_table.gameID and gamegenre.gameGenre ='${req.query.Genre}'`;
	}
	let games = {};  
	try {
		games = await queryAsync(topsellerSQL)	
		genres = await queryAsync(genreSQL);
		res.render('top seller', {
		  games: games,
		  genres:genres
		});
	  } catch (err) {
		console.log('SQL error', err);
		res.status(500).send('Something went wrong');
	  }
});

app.get('/library', isLoggedIn, function(req, res) {

	var game_data = {}; 

	connection.query("SELECT * FROM transactionhistory, gamestore WHERE transactionhistory.customerID = '"+req.session.user.customerID+"' AND transactionhistory.gameID = gamestore.gameID"  , function(err, result) {
		if(err) {
			throw err;
		} else {
			game_data = result; 
			res.render('library', {
				game_data: game_data
			})
		}
	});
})

app.get('/addgames', isLoggedIn, function(req, res) {

	res.render('addgames');

});

app.post('/addgames', function(req, res) {

	var gameImage = req.body.gameImage;
	var gameTitle = req.body.gameTitle;
	var gameDesc = req.body.gameDesc; 
	var Price = req.body.Price;
	var Genre = req.body.Genre;
	var ReleaseDate = req.body.ReleaseDate;
	var game_id = {}; 
	var game_data = {}; 
	var string = ''; 

	var game_string = Genre.split(", ");

	
	connection.query("INSERT INTO gamestore (gameTitle, gameDescription, price, releaseDate, gameImage) VALUES ('"+gameTitle+"', '"+gameDesc+"', "+Price+", '"+ReleaseDate+"', '"+gameImage+"')", 
		function(err, result, fields) {
			
			if(err) {
				throw err;
			} else {
				console.log("Insertion into gamestore ok") 
			}
	});

	connection.query('SELECT MAX(gameID) FROM gamestore', function(err, result) {
		if (err) {
			throw err;
		} else {
			var string = JSON.stringify(result);
			string = string.replace("]", '') 
			string = string.replace("[", '') 
			string = string.replace("{", '') 
			string = string.replace("}", '') 
			string = string.replace(":", '') 
			string = string.replace("MAX", '') 
			string = string.replace("gameID", '') 
			string = string.replace('(', '') 
			string = string.replace(")", '') 
			string = string.replace('"', '')
    		string = string.replace('"', '')

    		for (var i=0; i < game_string.length; i++) {
				connection.query("INSERT INTO gamegenre (gameID, gameGenre) VALUES ('"+string+"', '"+game_string[i]+"') ON DUPLICATE KEY UPDATE gameID = gameID, gameGenre = gameGenre",
					function(err, result, field) {
						if(err) {
							throw err;
						} else {
							console.log("Insertion into gamegenre table ok");
						}
				});
			}  
		}
	});

	connection.query('SELECT * FROM gamestore', function(err, rows){
		if (err) {
			throw err;
		} else {
			game_data = rows;
			res.render('allgames', {
				game_data: game_data
			})
		}
	})
	
});













































app.listen(3000);
