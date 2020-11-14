import 'dart:io';
import 'dart:ui';

import 'package:chat/widgets/clipcontainer.dart';
import 'package:flutter/material.dart';
import 'package:chat/models/user.dart';
import 'package:chat/models/crud.dart';
import 'package:chat/models/authentication.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.loginCallback})
      : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback loginCallback;
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register, reset }

class _LoginPageState extends State<LoginPage> {
  static final _formKey = new GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  CrudMethods crudObj = new CrudMethods();
  String _email;
  String _fullnames;
  DateTime dob;
  String _gender;
  File picture;
  // bool admin;
  // double offset = 0;
  String _authHint = '';
  FormType _formType = FormType.login;
  String _password;
  DateTime selectedDate = DateTime(
      DateTime.now().year - 10, DateTime.now().month, DateTime.now().day);
  // String _errorMessage;

  // bool _isLoginForm;
  bool _isLoading = false;
  Color dobColor = Colors.white30;
  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() {
        _isLoading = true;
      });
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.signUp(_email, _password);
        setState(() {
          _isLoading = false;
        });
        if (_formType == FormType.register) {
          UserData userData = new UserData(
            fullnames: _fullnames,
            email: _email,
            phone: "",
            gender: _gender,
            picture:
                "https://firebasestorage.googleapis.com/v0/b/enroute-25815.appspot.com/o/restaurant-red-beans-coffee.jpg?alt=media&token=a75145f8-1351-4335-bc75-432849dac887",
            // admin: false,
          );
          crudObj.createOrUpdateUserData(userData.getDataMap());
        }

        if (userId == null) {
          print("EMAIL NOT VERIFIED");
          setState(() {
            _authHint = 'Check your email for a verify link';
            _isLoading = false;
            _formType = FormType.login;
          });
        } else {
          _isLoading = false;
          _authHint = '';
          widget.loginCallback();
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          switch (e.code) {
            case "invalid-email":
              _authHint = "Your email address appears to be malformed.";
              break;
            case "email-already-exists":
              _authHint = "Email address already used in a different account.";
              break;
            case "invalid-password":
              _authHint = "Your password is wrong.";
              break;
            case "user-not-found":
              _authHint = "User with this email doesn't exist.";
              break;
            default:
              _authHint = "An undefined Error happened.";
          }
        });
        print(e.code);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }

  void moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _authHint = '';
    });
  }

  void moveToReset() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.reset;
      _authHint = '';
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        key: new Key('email'),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
          filled: true,
          fillColor: Colors.green.withOpacity(0.75),
          labelText: 'Email',
          labelStyle: TextStyle(fontStyle: FontStyle.italic),
          prefixIcon: new Icon(
            Icons.mail,
            color: Colors.green,
          ),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Enter a valid email';
          }
          return null;
        },
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        key: new Key('namefield'),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
          filled: true,
          fillColor: Colors.green.withOpacity(0.75),
          labelText: 'Full Name',
          labelStyle: TextStyle(fontStyle: FontStyle.italic),
          prefixIcon: new Icon(
            Icons.perm_identity,
            color: Colors.green,
          ),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter your Name';
          }
          return null;
        },
        onSaved: (value) => _fullnames = value,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        key: new Key('password'),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
          filled: true,
          fillColor: Colors.green.withOpacity(0.75),
          labelText: 'Password',
          labelStyle: TextStyle(fontStyle: FontStyle.italic),
          prefixIcon: new Icon(
            Icons.lock,
            color: Colors.green,
          ),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
        ),
        controller: _passwordTextController,
        obscureText: true,
        validator: (String value) {
          if (value.isEmpty || value.length < 6) {
            return 'Enter a minimum of 6 characters';
          }
          return null;
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _builConfirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
          filled: true,
          fillColor: Colors.green.withOpacity(0.75),
          labelText: 'Confirm Password',
          labelStyle: TextStyle(fontStyle: FontStyle.italic),
          prefixIcon: new Icon(
            Icons.lock,
            color: Colors.green,
          ),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15.0),
            borderSide: new BorderSide(),
          ),
        ),
        obscureText: true,
        validator: (String value) {
          if (_passwordTextController.text != value) {
            return 'Passwords don\'t correspond';
          }
          return null;
        },
      ),
    );
  }

  Widget submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            RaisedButton(
              key: new Key('login'),
              onPressed: validateAndSubmit,
            ),
            SizedBox(height: 10.0),
            FlatButton(
                key: new Key('reset-account'),
                child: Text(
                  "Reset Password",
                ),
                onPressed: moveToReset),
            // SizedBox(height: 10),
            FlatButton(
                key: new Key('need-account'),
                child: Text("Create a New Account"),
                onPressed: moveToRegister),
            SizedBox(height: 20.0),
          ],
        );
      case FormType.reset:
        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            RaisedButton(
                key: new Key('reset'),
                // text: 'Reset Password',
                // height: 44.0,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    widget.auth.resetPassword(_email);
                    setState(() {
                      _authHint = 'Check your email';
                      _formType = FormType.login;
                    });
                  }
                }),
            SizedBox(height: 20.0),
            FlatButton(
                key: new Key('need-login'),
                child: Text("Already Have an Account ? Login"),
                onPressed: moveToLogin),
            SizedBox(height: 20.0),
          ],
        );
      default:
        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            RaisedButton(
              key: new Key('register'),
              // text: 'Sign Up',
              // height: 44.0,
              onPressed: validateAndSubmit,
            ),
            SizedBox(height: 20.0),
            FlatButton(
                key: new Key('need-login'),
                child: Text("Already Have an Account ? Login"),
                onPressed: moveToLogin),
            SizedBox(height: 20.0),
          ],
        );
    }
  }

  Widget _showCircularProgress() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _showLogo() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          height: 150,
          width: 150,
          color: Colors.transparent,
          child: Hero(
            tag: 'hero',
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 10.0),
              child: Image.asset(
                'assets/icons/icon.png',
                // width: 50,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ));
  }

  Widget hintText() {
    return Container(
        //height: 80.0,
        padding: const EdgeInsets.all(10.0),
        child: Text(_authHint,
            key: new Key('hint'),
            //style: kAlertTextStyle,
            textAlign: TextAlign.center));
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showLogo(),
            hintText(),
            _formType == FormType.register
                ? _buildNameField()
                : Container(height: 0.0),
            SizedBox(
              height: 10.0,
            ),
            _buildEmailField(),
            SizedBox(
              height: 10.0,
            ),
            _formType != FormType.reset ? _buildPasswordField() : Container(),
            SizedBox(
              height: 10.0,
            ),
            _formType == FormType.register
                ? _builConfirmPasswordTextField()
                : Container(),
            SizedBox(
              height: 10.0,
            ),
            // _formType == FormType.register ? _showDatePicker() : Container(),
            SizedBox(
              height: 10.0,
            ),
            _isLoading == false
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: submitWidgets(),
                  )
                : _showCircularProgress(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Container(
        padding: EdgeInsets.only(top: 20),
        height: orientation == Orientation.portrait ? size.height : size.width,
        width: size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0.2),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: ClipContainer(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
