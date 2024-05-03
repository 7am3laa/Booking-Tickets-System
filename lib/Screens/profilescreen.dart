// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/loginscreen.dart';
import 'package:projectf/Widgets/CustomsForAuth/edit.dart';
import 'package:projectf/constant.dart';
import 'package:projectf/changetheme.dart';

class ProfileScreen extends StatefulWidget {
  final Users? user;

  const ProfileScreen({Key? key, this.user}) : super(key: key);
  static const String id = 'profilescreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DataBaseHandler dataBaseHandler = DataBaseHandler();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Styles.headlineStyle2.copyWith(color: color),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 4),
                        ),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo.png'),
                          radius: 75,
                        ),
                      ),
                      const Gap(20),
                      Text(
                        '${widget.user?.fName} ${widget.user?.lName}',
                        style: Styles.headlineStyle2
                            .copyWith(fontSize: 25, color: color),
                      ),
                      Text(
                        '+(2${widget.user?.phoneNumber})',
                        style: Styles.headlineStyle3.copyWith(color: color),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -20,
                    right: 95,
                    top: 10,
                    child: InkWell(
                      onTap: () {
                        _EditProfileScreen(context, widget.user!);
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          border: Border.all(color: Colors.green, width: 4),
                        ),
                        child: Icon(Icons.edit,
                            color: theme.brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                            size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                top: BorderSide(color: color, width: 4),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChangeTheme.of(context)!.data?.isDark == true
                          ? Text(
                              'Light Mode',
                              style:
                                  Styles.headlineStyle3.copyWith(color: color),
                            )
                          : Text(
                              'Dark Mode',
                              style:
                                  Styles.headlineStyle3.copyWith(color: color),
                            ),
                      InkWell(
                        onTap: () {
                          ChangeTheme.of(context)?.data?.toggleTheme();
                          setState(() {});
                        },
                        child: ChangeTheme.of(context)!.data?.isDark == true
                            ? const Icon(
                                Icons.light_mode_outlined,
                                size: 30,
                              )
                            : const Icon(
                                Icons.dark_mode_outlined,
                                size: 30,
                              ),
                      ),
                    ],
                  ),
                ),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Password',
                          style: Styles.headlineStyle3.copyWith(color: color),
                        ),
                        InkWell(
                            onTap: () {
                              _changePassword(context, widget.user!);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: color,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                ),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Logout',
                          style: Styles.headlineStyle3.copyWith(color: color),
                        ),
                        InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                ),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delete Account',
                          style: Styles.headlineStyle3.copyWith(color: color),
                        ),
                        InkWell(
                            onTap: () async {
                              await dataBaseHandler
                                  .deleteUser('${widget.user?.name}');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(25),
        ],
      ),
    );
  }

  void _EditProfileScreen(BuildContext context, Users users) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.black : Colors.white;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.41,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(5),
                EditInfo(
                  enabled: false,
                  isobscureText: false,
                  controller: TextEditingController(text: users.name),
                  text: 'User Name',
                  onChanged: (value) {
                    users.name = value;
                  },
                ),
                const Gap(15),
                EditInfo(
                  enabled: true,
                  isobscureText: false,
                  controller: TextEditingController(text: users.fName),
                  text: 'First Name',
                  onChanged: (value) {
                    users.fName = value;
                  },
                ),
                const Gap(15),
                EditInfo(
                  enabled: true,
                  isobscureText: false,
                  controller: TextEditingController(text: users.lName),
                  text: 'Last Name',
                  onChanged: (value) {
                    users.lName = value;
                  },
                ),
                const Gap(15),
                EditInfo(
                  enabled: true,
                  isobscureText: false,
                  controller: TextEditingController(text: users.phoneNumber),
                  text: 'Phone Number',
                  onChanged: (value) {
                    users.lName = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: Styles.headlineStyle2.copyWith(color: color),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: InkWell(
                      onTap: () async {
                        await dataBaseHandler.updateUser(users);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Save',
                          style: Styles.headlineStyle2.copyWith(color: color),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _changePassword(BuildContext context, Users users) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.black : Colors.white;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  EditInfo(
                    enabled: true,
                    isobscureText: false,
                    controller: TextEditingController(text: users.password),
                    text: 'New Password',
                    onChanged: (value) {
                      setState(() {
                        value;
                        users.password = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: Styles.headlineStyle2.copyWith(color: color),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: InkWell(
                      onTap: () async {
                        await dataBaseHandler.updateUser(users);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Save',
                          style: Styles.headlineStyle2.copyWith(color: color),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
