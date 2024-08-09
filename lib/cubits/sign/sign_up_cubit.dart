import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  void registration(String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userLogin(email, password, name);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        emit(AccountAlreadyExists());
      }
    }
  }

  void userLogin(String email, String password, String name) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      updateDatbase(email, name);
    } on FirebaseException catch (e) {}
  }

  void updateDatbase(String email, String name) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/${uid}");

      await ref.set({"name": name, "email": email});
      emit(SignedUpState());
    } on FirebaseException catch (e) {}
  }
}
