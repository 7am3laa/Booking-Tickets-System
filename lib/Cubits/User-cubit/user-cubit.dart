// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/Cubits/User-cubit/user-state.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(LoadingUserState());
  DataBaseHandler dataBaseHandler = DataBaseHandler();
  bool isPasswordVisible = true;
  Users? loggedInuser;
  getUser(username, password) async {
    try {
      emit(LoadingUserState());
      List<Users> userList = await dataBaseHandler.getUsers(username);
      if (userList.isNotEmpty) {
        for (Users user in userList) {
          if (username == user.name && password == user.password) {
            loggedInuser = user;
            emit(LoadedUserState(user));
          }
        }
      } else {
        emit(EmptyUserState());
      }
    } catch (e) {
      emit(ErrorUserState('$e'));
    }
  }

  deleteUser(username) async {
    try {
      await dataBaseHandler.deleteUser(username);
    } catch (e) {
      emit(ErrorUserState('$e'));
    }
  }

  adduser(String fName, String lName, String userName, String phone,
      String passWord) async {
    Users user = Users(
      fName: fName,
      lName: lName,
      name: userName,
      phoneNumber: phone,
      password: passWord,
    );
    await dataBaseHandler.save(user);
  }

  updateUser(String fName, String lName, String userName, String phone,
      String passWord) async {
    Users users = Users(
      fName: fName,
      lName: lName,
      name: userName,
      phoneNumber: phone,
      password: passWord,
    );

    dataBaseHandler.updateUser(users);
    emit(LoadedUserState(users));
  }

  showPassword() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityState(isPasswordVisible));
  }
}
