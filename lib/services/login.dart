import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_ui/module/secureStorage.dart';
import 'package:login_ui/services/home.dart';
import 'package:login_ui/services/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  loginUser(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      var data = SecureData();
      var validUser = await data.checkEmail(emailId.text);
      if (validUser == null) {
        return Fluttertoast.showToast(
            msg: "Invalid User", gravity: ToastGravity.CENTER, fontSize: 16.0);
      }
      var jsonData = jsonDecode(validUser);
      print(jsonData);
      if (password.text == jsonData['password']) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Home(name: jsonData['name'], image: jsonData['photo']),
            ));

      } else {
        Fluttertoast.showToast(
            msg: "Password not match",
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    }
  }

  var emailId = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Welcome user',
          style: TextStyle(
            fontSize: 25,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            //color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Enter Email',
                      style: TextStyle(
                        color: Colors.grey[900],
                        letterSpacing: 2,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Field should not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.deepPurple,
                        ),
                        hintText: 'Your Email',
                        //border:InputBorder.none,
                      ),
                      controller: emailId,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Enter Password',
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password cannot be empty";
                        } else if ((value.length) < 8) {
                          return "Password length should be atleast 8";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.deepPurple,
                        ),
                      ),
                      controller: password,
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: InkWell(
                            onTap: () => loginUser(context),
                            child: Container(
                              height: 40,
                              width: 150,
                              color: Colors.deepPurple,
                              child: Center(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(width: 4),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SignUp();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Image.asset('assets/login.jpg'),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
