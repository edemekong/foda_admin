// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../models/result.dart';
import '../models/user.dart';
import '../services/authentication_service.dart';
import '../utils/common.dart';

class UserRepository {
  final _authService = AuthenicationService.instance;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  ValueNotifier<User?> currentUserNotifier = ValueNotifier<User?>(null);

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userStreamSubscriptions;

  StreamSubscription? _authStreamSubscription;

  String? get currentUserUID => _authService.auth.currentUser?.uid;

  set setCurrentUser(User? user) {
    currentUserNotifier.value = user;
    currentUserNotifier.notifyListeners();
  }

  UserRepository() {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authStreamSubscription?.cancel();
    _authStreamSubscription = null;

    _authStreamSubscription = _authService.authStates().listen((firebaseUser) {
      if (firebaseUser != null) {
        final String uid = firebaseUser.uid;
        getCurrentUser(uid);
        fodaPrint("CURRENT USER -> $uid");
      } else {
        fodaPrint("NO CURRENT USER");
      }
    });
  }

  Future<Either<ErrorHandler, User>> getCurrentUser(String uid) async {
    try {
      final userSnapshot = await usersCollection.doc(uid).get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final User user = User.fromMap(data);

        if (!user.isAdmin) {
          await logout();
          fodaPrint("user is not an admin");
          return const Left(ErrorHandler(message: "User is not an admin"));
        }

        setCurrentUser = user;

        listenToCurrentUser(user.uid);

        return Right(user);
      } else {
        return const Left(ErrorHandler(message: "User does not exist"));
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, User>> login(String email, String password) async {
    try {
      final logIn = await _authService.logIn(email, password);
      if (logIn.isRight) {
        final firebaseUser = logIn.right;
        final getUser = await getCurrentUser(firebaseUser.uid);
        if (getUser.isRight) {
          return Right(getUser.right);
        }

        return Left(getUser.left);
      } else {
        return Left(ErrorHandler(message: logIn.left.message.toString()));
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Stream<User?> listenToCurrentUser(String uid) async* {
    try {
      _userStreamSubscriptions?.cancel();
      _userStreamSubscriptions = null;

      final snapshots = usersCollection.doc(uid).snapshots();

      _userStreamSubscriptions = snapshots.listen((document) {
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;
          final user = User.fromMap(data);
          setCurrentUser = user;
        }
      });
    } catch (e) {
      fodaPrint(e);
    }

    yield currentUserNotifier.value;
  }

  Future<void> logout() async {
    setCurrentUser = null;
    await _authService.logout();
  }
}
