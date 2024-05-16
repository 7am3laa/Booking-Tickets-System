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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          backgroundColor: Colors.red,
          content: Text(
            'Please Enter Your Details',
            style: TextStyle(fontSize: 15),
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
          backgroundColor: Colors.green,
          content: Text(
            'User $name registered successfully',
            style: const TextStyle(fontSize: 15),
          ),
          duration: const Duration(milliseconds: 500),
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
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: AppLayout.getHeight(context) / 1.4,
              width: AppLayout.getWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Register',
                        style: Styles.headlineStyle1
                            .copyWith(fontSize: 35, color: color),
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
                  Column(
                    children: [
                      const Gap(20),
                      CustomTxtField(
                        keyboardType: TextInputType.name,
                        validatorMessage: 'Please Enter Your First Name',
                        isobscureText: false,
                        Controller: _fNameController,
                        labelText: 'First Name',
                        suffixIcon: null,
                        prefixIcon: Icon(Icons.person, color: color),
                      ),
                      const Gap(10),
                      CustomTxtField(
                        keyboardType: TextInputType.name,
                        validatorMessage: 'Please Enter Your Last Name',
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
                        keyboardType: TextInputType.emailAddress,
                        validatorMessage: 'Please Enter Your Username',
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
                        keyboardType: TextInputType.phone,
                        validatorMessage: 'Please Enter Your Phone Number',
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
                        keyboardType: TextInputType.visiblePassword,
                        validatorMessage: 'Please Enter Your Password',
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
                            color: color,
                          ),
                        ),
                        isobscureText: isPassword,
                        Controller: _passwordController,
                        labelText: 'Password',
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: Styles.headlineStyle3
                                .copyWith(fontSize: 18, color: color),
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
                                color: Colors.blue,
                              ),
                            ),
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
                            _register();
                          },
                          text: 'Register')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
