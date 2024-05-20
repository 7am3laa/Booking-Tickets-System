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
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocProvider(
          create: (context) => UserCubit(),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Center(
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
                                      image: AssetImage(
                                          'assets/images/logo.png'))),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Gap(20),
                            CustomTxtField(
                              onSaved: (newValue) {
                                _fName = newValue!;
                              },
                              keyboardType: TextInputType.name,
                              validatorMessage: 'Please Enter Your First Name',
                              isobscureText: false,
                              labelText: 'First Name',
                              suffixIcon: null,
                              prefixIcon: Icon(Icons.person, color: color),
                            ),
                            const Gap(10),
                            CustomTxtField(
                              onSaved: (newValue) {
                                _lName = newValue!;
                              },
                              keyboardType: TextInputType.name,
                              validatorMessage: 'Please Enter Your Last Name',
                              isobscureText: false,
                              labelText: 'Last Name',
                              suffixIcon: null,
                              prefixIcon: Icon(
                                Icons.person,
                                color: color,
                              ),
                            ),
                            const Gap(10),
                            CustomTxtField(
                              onSaved: (newValue) {
                                _userName = newValue!;
                              },
                              keyboardType: TextInputType.emailAddress,
                              validatorMessage: 'Please Enter Your Username',
                              isobscureText: false,
                              labelText: 'Email or Username',
                              suffixIcon: null,
                              prefixIcon: Icon(
                                Icons.mail,
                                color: color,
                              ),
                            ),
                            const Gap(10),
                            CustomTxtField(
                              onSaved: (newValue) {
                                _phoneNumber = newValue!;
                              },
                              keyboardType: TextInputType.phone,
                              validatorMessage:
                                  'Please Enter Your Phone Number',
                              isobscureText: false,
                              labelText: 'Phone Number',
                              suffixIcon: null,
                              prefixIcon: Icon(
                                Icons.phone,
                                color: color,
                              ),
                            ),
                            const Gap(10),
                            CustomTxtField(
                              onSaved: (newValue) {
                                _passWord = newValue!;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              validatorMessage: 'Please Enter Your Password',
                              prefixIcon: Icon(Icons.lock, color: color),
                              suffixIcon: InkWell(
                                onTap: () {
                                  BlocProvider.of<UserCubit>(context)
                                      .showPassword();
                                },
                                child: Icon(
                                  context.read<UserCubit>().isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: color,
                                ),
                              ),
                              isobscureText:
                                  context.read<UserCubit>().isPasswordVisible,
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
                                    _formKey.currentState!.save();

                                    BlocProvider.of<UserCubit>(context).addUser(
                                        _fName,
                                        _lName,
                                        _userName,
                                        _phoneNumber,
                                        _passWord);

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
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
    );
  }
}
