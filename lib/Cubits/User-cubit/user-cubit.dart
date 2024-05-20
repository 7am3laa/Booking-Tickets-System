import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/Cubits/User-cubit/user-state.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(LoadingUserState());
  DataBaseHandler dataBaseHandler = DataBaseHandler();
  bool isPasswordVisible = true;
  Users? loggedInuser;
  bool isValid = false;

   getUser(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      emit(ErrorUserState('Please enter username and password'));
      return;
    }

    try {
      List<Users> userList = await dataBaseHandler.getUsers();
      if (userList.isNotEmpty) {
        for (Users user in userList) {
          if (username == user.name && password == user.password) {
            loggedInuser = user;
            isValid = true;
            emit(LoadedUserState(user));
            return;
          } else if (username == user.name && password != user.password) {
            emit(ErrorUserState('Invalid password'));
            return;
          }
        }
        emit(ErrorUserState('Invalid username'));
      } else {
        emit(EmptyUserState());
      }
    } catch (e) {
      emit(ErrorUserState('$e'));
    }
  }

  void showPassword() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityState(isPasswordVisible));
  }

   deleteUser(String username) async {
    try {
      await dataBaseHandler.deleteUser(username);
    } catch (e) {
      emit(ErrorUserState('$e'));
    }
  }

   addUser(String fName, String lName, String userName, String phone,
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
    Users user = Users(
      fName: fName,
      lName: lName,
      name: userName,
      phoneNumber: phone,
      password: passWord,
    );

    dataBaseHandler.updateUser(user);
    emit(LoadedUserState(user));
  }
}
