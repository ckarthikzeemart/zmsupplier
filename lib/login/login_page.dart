import 'package:flutter/material.dart';
import 'package:zm_supplier/home/home_page.dart';
import 'package:zm_supplier/model/authentication.dart';
import 'package:zm_supplier/utils/constants.dart';

import '../utils/color.dart';
import '../utils/color.dart';
import '../utils/color.dart';
import '../utils/color.dart';
import 'package:zm_supplier/services/authenticationApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _obscureText = true;
bool _btnEnabled = false;
String _email, _password;

GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    loadSharedPrefs() async {
      try {
        LoginResponse user = LoginResponse.fromJson(
            await sharedPref.readData(Constants.loginInfo));
        setState(() {
          print(user.user.userId);
          print(user.user.email);
        });
      } catch (Excepetion) {
        // do something
      }
    }

    void loginApiCalling() {
      Authentication login = new Authentication();

      login.authenticate(_email, _password).then((value) async {
        if (value != null) {
          //SharedPreferences userInfo = await SharedPreferences.getInstance();

          //save user data
          sharedPref.saveData(Constants.loginInfo, value);

          loadSharedPrefs();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    }

    void validator() {
      if (formKeyEmail.currentState.validate() && _password.length > 3) {
        print('validated');
        loginApiCalling();
      } else {
        print('not validated');
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.56,
                // child: Container(child: Image.asset('assets/img_welcome_salmon.png', fit: BoxFit.fill,)),

                child: Stack(
                  children: <Widget>[
                    FadeInImage(
                      placeholder: AssetImage("assets/images/blackdot.png"),
                      image: AssetImage("assets/images/img_welcome_salmon.png"),
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 23, top: 35),
                      child: Image.asset('assets/images/ZM_logo_white.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60, top: 40),
                      child: Text(
                        "Supplier",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: formKeyEmail,
                  child: TextFormField(
                    // validator: (input) => input.isValidEmail() ? null : "please enter a valid email",

                    onChanged: (input) => _email = input,
                    //  controller: emailController,
                    style: TextStyle(fontSize: 20, height: 1),
                    //cursorColor: Color(0xff999999),

                    decoration: InputDecoration(
                        errorStyle:
                            TextStyle(height: 0, color: Colors.transparent),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: greyText,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: greyText,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonBlue))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  child: TextFormField(
                    key: formKeyPassword,

                    // controller: passwordController,
                    onChanged: (input) => _password = input,

                    // validator: (input) => input.isValidEmail() ? null : "Check your email",

                    obscureText: _obscureText,
                    // obscureText: true,

                    style: TextStyle(fontSize: 20, height: 1),

                    //  cursorColor: Color(0xff999999),
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: _toggle,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility_rounded,
                            size: 22.0,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Password',
                        //  suffixIcon: Icon(Icons.visibility_off),
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: greyText,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: greyText,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonBlue))),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    print('forgot tapped');
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontSize: 14,
                              color: buttonBlue,
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 48.0,
                  child: GestureDetector(
                    onTap: validator,
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Color(0xFFF05A22),
                        //   style: BorderStyle.solid,
                        //   width: 1.0,
                        // ),
                        color: lightGreen.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.white,
                                // fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
