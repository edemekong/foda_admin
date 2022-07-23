// ignore_for_file: avoid_print

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/result.dart';

class AuthenicationService {
  AuthenicationService._();

  static AuthenicationService? _instance;

  static AuthenicationService get instance {
    _instance ??= AuthenicationService._();
    return _instance!;
  }

  final auth = FirebaseAuth.instance;

  Future<bool> isEmailInUse(String email) async {
    if (!email.contains("@") || email.split(".").length < 2) {
      print("Invalid Email");
      return false;
    }

    try {
      List<String> users = await auth.fetchSignInMethodsForEmail(email.trim());
      if (users.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Either<ErrorHandler, User>> logIn(String email, String password) async {
    try {
      final emailInUse = await isEmailInUse(email);
      if (!emailInUse) return const Left(ErrorHandler(message: "This user does not exist or email badly formatted"));

      final UserCredential authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return Right(authResult.user!);
      }

      return const Left(ErrorHandler(message: "Unable to login user"));
    } on FirebaseAuthException catch (error) {
      return Left(ErrorHandler(message: error.message.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Stream<User?> authStates() {
    return auth.authStateChanges();
  }
}
