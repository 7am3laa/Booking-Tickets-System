// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/mainscreen.dart';
import 'package:projectf/Screens/signupscreen.dart';
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
            content: Text('Invalid password'),
            duration: Duration(milliseconds: 500),
          ),
        );
        return;
      } else if (username == "" && password == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter username and password'),
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
          builder: (context) => MainScreen(user: loggedInUser!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 33, 90, 160),
              Color.fromARGB(255, 62, 92, 101)
            ],
          ),
        ),
        child: Center(
          child: Container(
            height: AppLayout.getHeight(context) / 2,
            padding: EdgeInsets.symmetric(
                horizontal: (AppLayout.getWidth(context) / 2) / 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Login',
                        style: Styles.headlineStyle1
                            .copyWith(fontSize: 35, color: Colors.white)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Gap(20),
                        CustomTxtField(
                          isobscureText: false,
                          Controller: _usernameController,
                          labelText: 'Username',
                          icon: null,
                        ),
                        const Gap(10),
                        CustomTxtField(
                            icon: InkWell(
                              onTap: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                              child: Icon(
                                isPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye_outlined,
                                color: Colors.black,
                              ),
                            ),
                            isobscureText: isPassword,
                            Controller: _passwordController,
                            labelText: 'Password'),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Don\'t have an account?',
                                style: Styles.headlineStyle3
                                    .copyWith(color: Colors.white)),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(' Register',
                                  style: Styles.headlineStyle3.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 17, 22, 26),
                                  )),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Button(
                          color: const Color.fromARGB(255, 31, 56, 75),
                          onTap: () {
                            _login();
                          },
                          text: 'Login',
                        ),
                      ],
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
