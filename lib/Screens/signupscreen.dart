// RegisterScreen.dart

// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/loginscreen.dart';
import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/CustomsForAuth/customtxtfield.dart';
import 'package:projectf/constant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String id = 'registerscreen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isPassword = true;
  DataBaseHandler dataBaseHandler = DataBaseHandler();

  Future<void> _register() async {
    String name = _usernameController.text;
    String password = _passwordController.text;
    String fName = _fNameController.text;
    String lName = _lNameController.text;
    String phoneNumber = _phoneNumberController.text;
    if (name == '' ||
        password == '' ||
        fName == '' ||
        lName == '' ||
        phoneNumber == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please Enter Your Details',
          ),
          duration: Duration(milliseconds: 500),
        ),
      );
    } else {
      Users users = Users(
        name: name,
        password: password,
        fName: fName,
        lName: lName,
        phoneNumber: phoneNumber,
      );

      await dataBaseHandler.save(users);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User $name registered successfully',
          ),
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white.withOpacity(.7);
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
            padding: EdgeInsets.symmetric(
              horizontal: (AppLayout.getWidth(context) / 2) / 3,
            ),
            height: AppLayout.getHeight(context) / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Register',
                      style: Styles.headlineStyle1
                          .copyWith(fontSize: 35, color: Colors.white),
                    ),
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
                          Controller: _fNameController,
                          labelText: 'First Name',
                          suffixIcon: null,
                          prefixIcon: Icon(Icons.person, color: color),
                        ),
                        const Gap(10),
                        CustomTxtField(
                          isobscureText: false,
                          Controller: _lNameController,
                          labelText: 'Last Name',
                          suffixIcon: null,
                          prefixIcon: Icon(
                            Icons.person,
                            color: color,
                          ),
                        ),
                        const Gap(10),
                        CustomTxtField(
                          isobscureText: false,
                          Controller: _usernameController,
                          labelText: 'Username',
                          suffixIcon: null,
                          prefixIcon: Icon(
                            Icons.mail,
                            color: color,
                          ),
                        ),
                        const Gap(10),
                        CustomTxtField(
                          isobscureText: false,
                          Controller: _phoneNumberController,
                          labelText: 'Phone Number',
                          suffixIcon: null,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: color,
                          ),
                        ),
                        const Gap(10),
                        CustomTxtField(
                          prefixIcon: Icon(Icons.lock, color: color),
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
                              color: Colors.white.withOpacity(.9),
                            ),
                          ),
                          isobscureText: isPassword,
                          Controller: _passwordController,
                          labelText: 'Password',
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Already have an account?',
                              style: Styles.headlineStyle3
                                  .copyWith(fontSize: 18, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                ' Login',
                                style: Styles.headlineStyle3.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 17, 22, 26),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Button(
                            color: const Color.fromARGB(255, 31, 56, 75),
                            onTap: () {
                              _register();
                            },
                            text: 'Register')
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
