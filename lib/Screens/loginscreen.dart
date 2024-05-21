// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:projectf/Cubits/User-cubit/user-cubit.dart';
import 'package:projectf/Cubits/User-cubit/user-state.dart';
import 'package:projectf/Screens/signupscreen.dart';
import 'package:projectf/Screens/splashscreen.dart';
import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/CustomsForAuth/customtxtfield.dart';
import 'package:projectf/constant.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String id = 'loginscreen';
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _userName = '';
  String _passWord = '';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is ErrorUserState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                    style: Styles.headlineStyle3.copyWith(color: Colors.white),
                  ),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            } else if (state is LoadedUserState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
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
                          onSaved: (newValue) {
                            _userName = newValue!;
                          },
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
                            _passWord = newValue!;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          validatorMessage: 'Please enter password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: color,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              context.read<UserCubit>().showPassword();
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
                            Text('Don\'t have an account?',
                                style: Styles.headlineStyle3
                                    .copyWith(color: color)),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
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
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await context
                                  .read<UserCubit>()
                                  .getUser(_userName, _passWord);
                              _userName = '';
                              _passWord = '';
                            }
                          },
                          text: 'Login',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
