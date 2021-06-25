part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Future<SignInSignUpResult?> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserData user = UserData(
        id: result.user!.uid,
        email: result.user!.email,
        name: name,
      );

      await result.user!.sendEmailVerification();
      await UsersServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return SignInSignUpResult(message: "Email sudah digunakan");
      }
    } catch (e) {
      return SignInSignUpResult(
          message:
              "Terjadi masalah yang tidak diketahui. Pastikan Koneksi anda tidak bermasalah.");
    }
  }

  Future<SignInSignUpResult?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = _auth.currentUser;

      if (user != null) {
        await user.getIdToken();

        String? uidUser = result.user!.uid;

        ServicesReturnValue<UserData> resultUser =
            await UsersServices.getUser(uidUser);

        return SignInSignUpResult(user: resultUser.value);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return SignInSignUpResult(message: "Alamat email belum terdaftar");
      } else if (e.code == 'wrong-password') {
        return SignInSignUpResult(message: "Password yang anda masukan salah");
      }
    } catch (e) {
      return SignInSignUpResult(
          message:
              "Terjadi masalah yang tidak diketahui. Pastikan Koneksi anda tidak bermasalah.");
    }
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static bool checkVerifyUser() {
    User? user = _auth.currentUser;
    if (user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }
}

class SignInSignUpResult {
  UserData? user;
  String? message;

  SignInSignUpResult({this.user, this.message});
}
