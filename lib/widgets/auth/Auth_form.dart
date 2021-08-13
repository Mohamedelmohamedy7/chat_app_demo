import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/widgets/userimagepicker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Auth_form extends StatefulWidget {
  final void Function(String email, String password, String username,
      File image, bool isLogin, BuildContext ctx) submitFn;
  bool isloading;

  Auth_form(this.submitFn, this.isloading);

  @override
  _Auth_formState createState() => _Auth_formState();
}

class _Auth_formState extends State<Auth_form> {
  final _formkey = GlobalKey<FormState>();
  bool _isLogin = true;
  String? _email;
  String? _password;
  String? _username;
  File? _userimagefilepick;

  void imagepicked(File imagepackeer) {
    this._userimagefilepick = imagepackeer;
  }

  void _submait() {
    final isvalid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isLogin) _username = "";
    _userimagefilepick = File(
        "https://m7et.com/wp-content/uploads/2020/04/69d1a788bc2b9dc45340a3d5343f9c75.jpg");
    if (!_isLogin && _userimagefilepick == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please pack a photo"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isvalid) {
      _formkey.currentState!.save();
      widget.submitFn(_email!.trim(), _password!.trim(), _username!.trim(),
          _userimagefilepick!, _isLogin, context);
    }
  }

  bool? isvisable = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/back4.jpg"), fit: BoxFit.cover),
      ),
      child: Center(
        child: Card(
          margin: EdgeInsets.fromLTRB(25, 60, 25, 0),
          elevation: 12,
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLogin
                      ? SizedBox(
                          height: 15,
                        )
                      : SizedBox(height: 15),
                  Text(
                    "${_isLogin ? "LOGIN" : "SIGNUP"}",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  _isLogin
                      ? SizedBox(
                          height: 15,
                        )
                      : SizedBox(height: 10),

                  if (!_isLogin) userImagepicgker(imagepicked),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    key: ValueKey("email"),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.green)),
                        fillColor: Colors.green[200],
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        hintText: "Enter Your E-mail",
                        hintStyle: TextStyle(color: Colors.white)),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "please enter an Email ";
                      } else if (!val.contains("@")) {
                        return "please enter a valid Email";
                      }
                        return null;
                    },
                    onSaved: (val) {
                      _email = val!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      autocorrect: true,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.words,
                      key: ValueKey("username"),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          fillColor: Colors.green[200],
                          filled: true,
                          hintText: "Enter Your user name",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.green)),
                          prefixIcon: Icon(Icons.person, color: Colors.white)),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return "please enter a valid user name";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _username = val!;
                      },
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    key: ValueKey("password"),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    obscureText: isvisable!,
                    decoration: InputDecoration(
                        fillColor: Colors.green[200],
                        filled: true,
                        suffixIcon: IconButton(
                          icon: isvisable!
                              ? Icon(Icons.visibility_off,color:Colors.white)
                              : Icon(Icons.visibility,color:Colors.white),
                          onPressed: () {
                        //    FocusScope.of(context).unfocus();
                            setState(() {
                              isvisable = !isvisable!;
                              FocusScope.of(context).unfocus();

                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.green)),
                        prefixIcon: Icon(Icons.lock_outline_rounded,
                            color: Colors.white),
                        hintText: "Enter Your Password",
                        hintStyle: TextStyle(color: Colors.white)),
                    validator: (val) {
                      if (val!.isEmpty  ) {
                        return "please enter a valid password";
                      } else if( val.length < 7){
                        return "Password is too Short";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _password = val;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    RaisedButton(
                      onPressed: () {
                        print(_isLogin);
                        _submait();
                      },
                      child: _isLogin
                          ? Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text("Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  if (!widget.isloading)
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: _isLogin
                            ? Text(
                                "Do You want to Create Account ? ",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              )
                            : Text(
                                " Login Instead ?",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              )),
                  // FlatButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
