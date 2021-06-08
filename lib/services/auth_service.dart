import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<User> signUpUser({String email, String senha}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('Senha deve ter no mínimo 6 caracteres');
      } else if (e.code == 'email-already-in-use') {
        print("Email ja cadastrado");
      } else {
        print('Erro');
      }
    }

    return user;
  }

  static Future<User> signInUser({String email, String senha}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: senha);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      throw (e);
    }

    return user;
  }

  static Future<User> signOutUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await user.reload();
    User refreshUser = auth.currentUser;
    return refreshUser;
  }

  static User getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
