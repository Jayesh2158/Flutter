import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/module/secureStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  registerUser(BuildContext context) async {
    if(imagePath == null){
      return Fluttertoast.showToast(
          msg: "Select image",
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    }
    if (_formKey.currentState.validate()){
      var register = SecureData(
          name: name.text,
          email: email.text,
          password: password.text,
          photo:imagePath,
          mobile: mobile.text);
      var check = await register.checkEmail(email.text);
      if (check != null) {
        return Fluttertoast.showToast(
            msg: "Email already taken",
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
      await register.saveData();
      Navigator.pop(context);
    }

  }

  final ImagePicker _picker = ImagePicker();
  var imagePath;

  getImageFromGallery()async{
    var image = await _picker.pickImage(source:ImageSource.gallery);
    if(image != null){
      final imagePermanent = await saveImagePermanently(image.path);
      imagePath = imagePermanent.path;
      print(imagePath.runtimeType);
    }
  }
  saveImagePermanently(String imagePath)async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 25,
            letterSpacing: 2,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Name',
                      style: TextStyle(
                        color: Colors.grey[900],
                        letterSpacing: 2,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'User name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.deepPurple,
                        ),
                        hintText: 'Name',
                      ),
                      controller: name,
                    ),
                    SizedBox(height: 14),
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
                          return 'User email cannot be empty';
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
                      controller: email,
                    ),
                    SizedBox(height: 14),
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
                      decoration: InputDecoration(
                        hintText: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.deepPurple,
                        ),
                      ),
                      controller: password,
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Enter Mobile No.',
                      style: TextStyle(
                        color: Colors.grey[900],
                        letterSpacing: 2,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Mobile no. cannot be empty";
                        } else if (value.length < 10) {
                          return "Mobile no. should be atleast 10";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Mobile No.',
                        icon: Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                        ),
                      ),
                      controller: mobile,
                    ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        Text(
                          'Select image from',
                          style: TextStyle(
                            color: Colors.grey[900],
                            letterSpacing: 2,
                          ),
                        ),
                        TextButton(
                            onPressed: ()=>getImageFromGallery(),
                            child: Text(
                              'Gallery',
                              style: TextStyle(color: Colors.deepPurple),
                            )),
                        //imagePath != null ?? Text(imagePath),
                      ],
                    ),

                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => registerUser(context),
                            child: Container(
                              height: 40,
                              width: 150,
                              color: Colors.deepPurple,
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset('assets/signup.jpg'),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
