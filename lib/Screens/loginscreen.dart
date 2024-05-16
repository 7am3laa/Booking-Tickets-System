// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/signupscreen.dart';
import 'package:projectf/Screens/splashscreen.dart';
import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/CustomsForAuth/customtxtfield.dart';
import 'package:projectf/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DataBaseHandler dataBaseHandler = DataBaseHandler();
  bool isPassword = true;
  late int index;

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    List<Users> usersList = await dataBaseHandler.getUsers();

    bool isValidUser = false;
    Users? loggedInUser;

    for (Users user in usersList) {
      if (username == user.name && password == user.password) {
        isValidUser = true;
        loggedInUser = user;
        break;
      } else if (username == user.name && password != user.password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Invalid password',
              style: TextStyle(fontSize: 15),
            ),
            duration: Duration(milliseconds: 500),
          ),
        );
        return;
      } else if (username == "" && password == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Please enter username and password',
              style: TextStyle(fontSize: 15),
            ),
            duration: Duration(milliseconds: 500),
          ),
        );
        return;
      }
    }
    if (isValidUser) {
      _usernameController.clear();
      _passwordController.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(user: loggedInUser!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Invalid username',
            style: TextStyle(fontSize: 15),
          ),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: AppLayout.getWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Login',
                        style: Styles.headlineStyle1
                            .copyWith(fontSize: 35, color: color)),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('assets/images/logo.png'))),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Gap(20),
                    CustomTxtField(
                      keyboardType: TextInputType.emailAddress,
                      validatorMessage: 'Please enter username',
                      isobscureText: false,
                      Controller: _usernameController,
                      labelText: 'Email or Username',
                      suffixIcon: null,
                      prefixIcon: Icon(
                        Icons.mail,
                        color: color,
                      ),
                    ),
                    const Gap(10),
                    CustomTxtField(
                        keyboardType: TextInputType.visiblePassword,
                        validatorMessage: 'Please enter password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: color,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          child: Icon(
                            isPassword
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            color: color,
                          ),
                        ),
                        isobscureText: isPassword,
                        Controller: _passwordController,
                        labelText: 'Password'),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?',
                            style:
                                Styles.headlineStyle3.copyWith(color: color)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(' Register',
                              style: Styles.headlineStyle3.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              )),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Button(
                      width: 1.5,
                      textColor: theme.brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                      color: color,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {});
                        }
                        _login();
                      },
                      text: 'Login',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
