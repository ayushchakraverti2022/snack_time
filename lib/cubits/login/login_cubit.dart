import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  void userLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoggedInState());
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailState("User does not exists."));
      }else if(e.code == 'wrong-password'){
         emit(LoginFailState("Incorrect password."));
      }else {
        emit(LoginFailState("The supplied auth credential is incorrect, malformed or has expired."));
      }
    }
  }
}
