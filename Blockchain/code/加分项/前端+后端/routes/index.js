var express = require('express');
var http = require('http');
var validator = require('../public/javascripts/validator');

module.exports = function(db) {
	var router = express.Router();
	var url = require('url');
	var path = require('path');
	var querystring = require('querystring');
	var userController = require('../modules/userController')(db);
	// database collections
	var users = db.collection('users');
	var usr = db.collection('user');
	var nde = db.collection('node');
	var contr = db.collection('contract');
	var config = db.collection('configure');
	var transac = db.collection('transaction');

	// 从登录页跳转登录后展示页
	router.get('/', function(req, res, next) {
		console.log(req.session.user);
		// req.session.user是当前用户
		// username 是通过url发送req的用户
		var username = querystring.parse(url.parse(req.url).query).username;
		console.log(username);
		// 当前没有已登录用户
		if (!req.session.user) {
			res.redirect('/signin');
		}
		// 当前用户存在时无论是否username是否存在都跳转到当前用户详情页
		else if ((username && username == req.session.user.username) || (!username && req.session.user)) {
			res.redirect('/detail');
		}
		// 用户存在但不是当前用户，跳转到当前用户详情页并给出错误提示
		else if (username && username != req.session.user.username) {
			res.render('detail', { title: '详情',user: req.session.user, error: '只能够访问自己的数据'});
		}
		// 否则跳回登录页
		else {
			res.redirect('/signin');
		}
	});

	// GET 登录 page
	router.get('/signin', function(req, res, next) {
		// 当前用户不为空，显示其详情页
		if (req.session.user) {
			res.redirect('/detail');
		}
		// 否则显示登录页
		else {
			res.render('signin', { title: '登录'});
		}
	});

	// POST 登录 page
	router.post('/signin', function(req, res, next) {
		var user = req.body;
		// 根据用户姓名及其密码寻找用户
		userController.findUser(req.body.username, req.body.password)
				.then(function(user) {
					// 删除密码，增加安全性
					delete user.password;
					// 成功登陆，跳转至详情页面
					req.session.user = user;
					req.session.cookie.maxAge = 600000;
					res.redirect('/detail');
				}).catch(function(error) {
					// 登录失败，重新填写信息
					res.render('signin', { title: '登录',error: '错误的用户名或者密码'});
				});
	});

	// GET 注册 page
	router.get('/regist', function(req, res, next) {
	  res.render('signup', { title: '注册', user: {} });
	});

	// POST 注册 page
	router.post('/regist', function(req, res, next) {
		var user = req.body;
	  userController.validateUser(user).then(function() {
	  	// 删除密码增加安全性
	  	delete user.password;
	  	delete user.repeatpassword;
	  	// 注册成功，将该用户标记为当前用户
	  	req.session.user = user;
	  	req.session.cookie.maxAge = 600000;
	  	res.redirect('/detail');
	  	console.log("注册用户成功");
	  }).catch(function(error) {
	  	console.log("this is user", user);
	  	delete user.password;
	  	delete user.repeatpassword;
	  	res.render('signup', { title: '注册', user: user, error: error});
	  	console.log(error);
	  })
	});

	// 处理 登出 page
	router.get('/signout', function(req, res, next) {
		if (req.session.user)
			delete req.session.user;
		res.redirect('/signin');
		console.log("登出");
	});
	
	// GET 详情 page
	router.get('/detail', function(req, res, next) {
	  // 当前用户不为空，则展示用户信息
	  if (req.session.user) {
	  	console.log("展示当前用户");
	  	console.log(req.session.user);
	  	res.render('detail', { title: '详情', user: req.session.user});
	  }
	  // 否则跳转至注册页面
	  else {
		  console.log("当前用户不存在");
	  	  res.redirect('/signin');
	  }
	});

	// detail索引页面
	// 用户管理
	router.get('/user', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			usr.find().toArray().then(usrlist => {
					console.log(usrlist);
					res.render('user', {title: '用户管理', user: req.session.user, list: usrlist});
				});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// 提交新建用户表单
	router.post('/user', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			// 向数据库中增加表项
			let information = req.body;
			usr.insert(information);
			console.log(information);
			// 获取用户列表
			usr.find().toArray().then(usrlist => {
				console.log(usrlist);
				res.render('user', {title: '用户管理', user: req.session.user, list: usrlist});
			});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	
	// 节点管理
	router.get('/node', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			nde.find().toArray().then(ndelist => {
					console.log(ndelist);
					res.render('node', {title: '节点管理', user: req.session.user, list: ndelist});
				});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// 提交新建节点表单
	router.post('/node', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			// 向数据库中增加表项
			let information = req.body;
			nde.insert(information);
			// 获取节点列表
			nde.find().toArray().then(ndelist => {
				console.log(ndelist);
				res.render('node', {title: '节点管理', user: req.session.user, list: ndelist});
			});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});

	// 智能合约管理
	router.get('/contract', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			contr.find().toArray().then(contrlist => {
					console.log(contrlist);
					res.render('contract', {title: '智能合约管理', user: req.session.user, list: contrlist});
				});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});

	// 交易管理
	router.get('/transaction', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			// api 获取交易列表
			// update db according to api's data
			transac.find().toArray().then(transaclist => {
					console.log(transaclist);
					res.render('transaction', {title: '交易管理', user: req.session.user, list: transaclist});
				});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});

	// 配置管理
	router.get('/configure', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			config.find().toArray().then(configlist => {
					console.log(configlist);
					res.render('configure', {title: '配置管理', user: req.session.user, list: configlist});
				});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// 提交修改配置表单
	router.post('/configure', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			// 向数据库中增加表项
			let information = req.body;
			config.insert(information);
			// 获取节点列表
			config.find().toArray().then(configlist => {
				console.log(configlist);
				res.render('configure', {title: '配置管理', user: req.session.user, list: configlist});
			});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});

	// send transaction
	router.get('/sendtransac', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('sendtransac', {title: '交易类型', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});

	// addAmount
	router.get('/addAmount', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('addAmount', {title: 'addAmount', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// addAmount params post
	router.post('/addAmount', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
		console.log(req.body);
		let userpublickey = req.body['user'];
		console.log(userpublickey);
		let Amount = req.body['Amount'];
		console.log(Amount);
		let params = [];
		params.push(Amount);
		console.log(params);

		let post_data = {"contractName":"Test9", 
							"funcName": "addAmount", 
							"funcParam": params, 
							"user": userpublickey, 
							"useAes": false, 
							"contractAddress":"0x21bea809e2ce80c84c6e132fd2e9106d84e3531d",
							"groupId": 1};

		let content = JSON.stringify(post_data);
		
		let options = {
			host: '127.0.0.1',
			port: 5002,
			path: '/WeBASE-Front/trans/handle',
			method: 'POST',
			headers:{
			'Content-Type':'application/json',
			'Content-Length':content.length
			}
		};
		
		let data = '';
		let httpreq = http.request(options, function(ret) {
		console.log("statusCode: ", ret.statusCode);
		console.log("headers: ", ret.headers);
		ret.on('data', function(chunk){
			data += chunk;
		});
		ret.on('end', function(){
			res.render('result', {title: '调用结果', obj: data});
			console.log("\n--->>\nresult:",data);
		});
		});
		httpreq.write(content);
		httpreq.end();
		} // 否则跳转至注册页面
		else {
		console.log("当前用户不存在");
		res.redirect('/signin');
		}
	}); 

	// getAmount
	router.get('/getAmount', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('getAmount', {title: 'getAmount', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// getAmount params post
	router.post('/getAmount', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
		console.log(req.body);
		let userpublickey = req.body['user'];
		console.log(userpublickey);
		let params = [];
		console.log(params);

		let post_data = {"contractName":"Test9", 
							"funcName": "getAmount", 
							"funcParam": params, 
							"user": userpublickey, 
							"useAes": false, 
							"contractAddress":"0x21bea809e2ce80c84c6e132fd2e9106d84e3531d",
							"groupId": 1};

		let content = JSON.stringify(post_data);
		
		let options = {
			host: '127.0.0.1',
			port: 5002,
			path: '/WeBASE-Front/trans/handle',
			method: 'POST',
			headers:{
			'Content-Type':'application/json',
			'Content-Length':content.length
			}
		};
		
		let data = '';
		let httpreq = http.request(options, function(ret) {
			console.log("statusCode: ", ret.statusCode);
			console.log("headers: ", ret.headers);
			ret.on('data', function(chunk){
			data += chunk;
			});
			ret.on('end', function(){
			res.render('result', {title: '调用结果', obj: data});
			console.log("\n--->>\nresult:",data);
			});
			});
			httpreq.write(content);
			httpreq.end();
		} // 否则跳转至注册页面
		else {
		console.log("当前用户不存在");
		res.redirect('/signin');
		}
	}); 

	// addOrganization
	router.get('/addOrganization', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('addOrganization', {title: 'addOrganization', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// addOrganization params post
	router.post('/addOrganization', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
		  console.log(req.body);
		  let userpublickey = req.body['user'];
		  console.log(userpublickey);
			let creditLevel = req.body['creditLevel'];
			console.log(creditLevel);
			let params = [];
			params.push(creditLevel);
			console.log(params);
	  
		  let post_data = {"contractName":"Test9", 
							"funcName": "addOrganization", 
							"funcParam": params, 
							"user": userpublickey, 
							"useAes": false, 
							"contractAddress":"0x21bea809e2ce80c84c6e132fd2e9106d84e3531d",
							"groupId": 1};
	  
		  let content = JSON.stringify(post_data);
		   
		  let options = {
			  host: '127.0.0.1',
			  port: 5002,
			  path: '/WeBASE-Front/trans/handle',
			  method: 'POST',
			  headers:{
			  'Content-Type':'application/json',
			  'Content-Length':content.length
			  }
		  };
		  
		  let data = '';
		  let httpreq = http.request(options, function(ret) {
			console.log("statusCode: ", ret.statusCode);
			console.log("headers: ", ret.headers);
			ret.on('data', function(chunk){
			   data += chunk;
			});
			ret.on('end', function(){
			  res.render('result', {title: '调用结果', obj: data});
			  console.log("\n--->>\nresult:",data);
			});
			});
			httpreq.write(content);
			httpreq.end();
		} // 否则跳转至注册页面
		else {
		  console.log("当前用户不存在");
		  res.redirect('/signin');
		}
	  }); 
	  
	// finance
	router.get('/finance', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('finance', {title: 'finance', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// finance params post
	router.post('/finance', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			console.log(req.body);
			let userpublickey = req.body['user'];
			console.log(userpublickey);
			let Amount = req.body['Amount'];
			console.log(Amount);
			let params = [];
			params.push(Amount);
			console.log(params);

			let post_data = {"contractName":"Test9", 
							"funcName": "finance", 
							"funcParam": params, 
							"user": userpublickey, 
							"useAes": false, 
							"contractAddress":"0x21bea809e2ce80c84c6e132fd2e9106d84e3531d",
							"groupId": 1};

			let content = JSON.stringify(post_data);
			
			let options = {
				host: '127.0.0.1',
				port: 5002,
				path: '/WeBASE-Front/trans/handle',
				method: 'POST',
				headers:{
				'Content-Type':'application/json',
				'Content-Length':content.length
				}
			};
			
			let data = '';
			let httpreq = http.request(options, function(ret) {
				console.log("statusCode: ", ret.statusCode);
				console.log("headers: ", ret.headers);
				ret.on('data', function(chunk){
					data += chunk;
				});
				ret.on('end', function(){
				res.render('result', {title: '调用结果', obj: data});
				console.log("\n--->>\nresult:",data);
				});
				});
				httpreq.write(content);
				httpreq.end();
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	}); 	

	// transfer
	router.get('/transfer', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('transfer', {title: 'transfer', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// transfer params post
	router.post('/transfer', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			console.log(req.body);
			let userpublickey = req.body['user'];
			console.log(userpublickey);
			let debtorA = req.body['debtorA'];
			console.log(debtorA);
			let debtorB = req.body['debtorB'];
			console.log(debtorB);
			let params = [];
			params.push(debtorA);
			params.push(debtorB);
			console.log(params);

			let post_data = {"contractName":"Test9", 
							"funcName": "transfer", 
							"funcParam": params, 
							"user": userpublickey, 
							"useAes": false, 
							"contractAddress":"0x21bea809e2ce80c84c6e132fd2e9106d84e3531d",
							"groupId": 1};

			let content = JSON.stringify(post_data);
			
			let options = {
				host: '127.0.0.1',
				port: 5002,
				path: '/WeBASE-Front/trans/handle',
				method: 'POST',
				headers:{
				'Content-Type':'application/json',
				'Content-Length':content.length
				}
			};
			
			let data = '';
			let httpreq = http.request(options, function(ret) {
				console.log("statusCode: ", ret.statusCode);
				console.log("headers: ", ret.headers);
				ret.on('data', function(chunk){
					data += chunk;
				});
				ret.on('end', function(){
				res.render('result', {title: '调用结果', obj: data});
				console.log("\n--->>\nresult:",data);
				});
				});
				httpreq.write(content);
				httpreq.end();
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	}); 

	// payback
	router.get('/payback', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('payback', {title: 'payback', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// payback params post
	router.post('/payback', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			console.log(req.body);
			let userpublickey = req.body['user'];
			console.log(userpublickey);
			let debtor = req.body['debtor'];
			console.log(debtor);
			let params = [];
			params.push(debtor);
			console.log(params);

			let post_data = {"contractName":"Test9", 
							"funcName": "payback", 
							"funcParam": params, 
							"user": userpublickey, 
							"useAes": false, 
							"contractAddress":"0x21bea809e2ce80c84c6e132fd2e9106d84e3531d",
							"groupId": 1};

			let content = JSON.stringify(post_data);
			
			let options = {
				host: '127.0.0.1',
				port: 5002,
				path: '/WeBASE-Front/trans/handle',
				method: 'POST',
				headers:{
				'Content-Type':'application/json',
				'Content-Length':content.length
				}
			};
			
			let data = '';
			let httpreq = http.request(options, function(ret) {
				console.log("statusCode: ", ret.statusCode);
				console.log("headers: ", ret.headers);
				ret.on('data', function(chunk){
					data += chunk;
				});
				ret.on('end', function(){
				res.render('result', {title: '调用结果', obj: data});
				console.log("\n--->>\nresult:",data);
				});
				});
				
				httpreq.write(content);
				httpreq.end();
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	}); 

	// signature
	router.get('/signature', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
				res.render('signature', {title: 'signature', user: req.session.user});
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	});
	// signature params post
	router.post('/signature', function(req, res, next) {
		// 当前用户不为空，则展示用户信息
		if (req.session.user) {
			console.log(req.body);
			let userpublickey = req.body['user'];
			console.log(userpublickey);
			let debtor = req.body['debtor'];
			console.log(debtor);
			let Amount = req.body['Amount'];
			console.log(Amount);			
			let params = [];
			params.push(debtor);
			params.push(Amount);			
			console.log(params);

			let post_data = {"contractName":"Test9", 
							"funcName": "signature", 
							"funcParam": params, 
							"user": userpublickey, 
							"useAes": false, 
							"contractAddress":"0x21bea809e2ce80c84c6e132fd2e9106d84e3531d",
							"groupId": 1};

			let content = JSON.stringify(post_data);
			
			let options = {
				host: '127.0.0.1',
				port: 5002,
				path: '/WeBASE-Front/trans/handle',
				method: 'POST',
				headers:{
				'Content-Type':'application/json',
				'Content-Length':content.length
				}
			};
			
			let data = '';
			let httpreq = http.request(options, function(ret) {
				console.log("statusCode: ", ret.statusCode);
				console.log("headers: ", ret.headers);
				ret.on('data', function(chunk){
					data += chunk;
				});
				ret.on('end', function(){
				res.render('result', {title: '调用结果', obj: data});
				console.log("\n--->>\nresult:",data);
				});
				});
				
				httpreq.write(content);
				httpreq.end();
		} // 否则跳转至注册页面
		else {
			console.log("当前用户不存在");
			res.redirect('/signin');
		}
	}); 

	return router;
}
