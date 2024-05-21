// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:projectf/Cubits/User-cubit/user-cubit.dart';
import 'package:projectf/Cubits/User-cubit/user-state.dart';
import 'package:projectf/Screens/loginscreen.dart';
import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/CustomsForAuth/customtxtfield.dart';
import 'package:projectf/constant.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static const String id = 'registerscreen';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _userName = '';

  String _fName = '';

  String _lName = '';

  String _passWord = '';

  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    Color txtColor = const Color.fromARGB(238, 9, 7, 98);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -650,
              right: -20,
              child: Transform.rotate(
                angle: 2,
                child: Container(
                  width: AppLayout.getWidth(context),
                  height: AppLayout.getHeight(context),
                  color: const Color.fromARGB(238, 9, 7, 98),
                ),
              ),
            ),
            Positioned(
              bottom: -650,
              left: -20,
              child: Transform.rotate(
                angle: 2,
                child: Container(
                  width: AppLayout.getWidth(context),
                  height: AppLayout.getHeight(context),
                  color: const Color.fromARGB(238, 9, 7, 98),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: BlocProvider(
                create: (context) => UserCubit(),
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return Center(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: AppLayout.getHeight(context) / 1.5,
                          width: AppLayout.getWidth(context) / 1.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Register',
                                    style: Styles.headlineStyle1.copyWith(
                                        fontSize: 35, color: txtColor),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: AssetImage(
                                                'assets/images/logo.png'))),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Gap(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTxtField(
                                          onSaved: (newValue) {
                                            _fName = newValue!;
                                          },
                                          keyboardType: TextInputType.name,
                                          validatorMessage:
                                              'Enter Your First Name',
                                          isobscureText: false,
                                          labelText: 'First Name',
                                          suffixIcon: null,
                                          prefixIcon: Icon(Icons.person,
                                              color: txtColor),
                                        ),
                                      ),
                                      const Gap(5),
                                      Expanded(
                                        child: CustomTxtField(
                                          onSaved: (newValue) {
                                            _lName = newValue!;
                                          },
                                          keyboardType: TextInputType.name,
                                          validatorMessage:
                                              'Enter Your Last Name',
                                          isobscureText: false,
                                          labelText: 'Last Name',
                                          suffixIcon: null,
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: txtColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(5),
                                  CustomTxtField(
                                    onSaved: (newValue) {
                                      _userName = newValue!;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    validatorMessage: 'Enter Your Username',
                                    isobscureText: false,
                                    labelText: 'Email or Username',
                                    suffixIcon: null,
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: txtColor,
                                    ),
                                  ),
                                  const Gap(5),
                                  CustomTxtField(
                                    onSaved: (newValue) {
                                      _phoneNumber = newValue!;
                                    },
                                    keyboardType: TextInputType.phone,
                                    validatorMessage: 'Enter Your Phone Number',
                                    isobscureText: false,
                                    labelText: 'Phone Number',
                                    suffixIcon: null,
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: txtColor,
                                    ),
                                  ),
                                  const Gap(5),
                                  CustomTxtField(
                                    onSaved: (newValue) {
                                      _passWord = newValue!;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    validatorMessage: 'Enter Your Password',
                                    prefixIcon:
                                        Icon(Icons.lock, color: txtColor),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        BlocProvider.of<UserCubit>(context)
                                            .showPassword();
                                      },
                                      child: Icon(
                                        context
                                                .read<UserCubit>()
                                                .isPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.remove_red_eye_outlined,
                                        color: txtColor,
                                      ),
                                    ),
                                    isobscureText: context
                                        .read<UserCubit>()
                                        .isPasswordVisible,
                                    labelText: 'Password',
                                  ),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: Styles.headlineStyle3.copyWith(
                                            fontSize: 18, color: txtColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
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
                                  const Gap(10),
                                  Button(
                                      width: 1.5,
                                      textColor: Colors.white,
                                      color:
                                          const Color.fromARGB(238, 9, 7, 98),
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          BlocProvider.of<UserCubit>(context)
                                              .addUser(
                                                  _fName,
                                                  _lName,
                                                  _userName,
                                                  _phoneNumber,
                                                  _passWord);

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      text: 'Register')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
