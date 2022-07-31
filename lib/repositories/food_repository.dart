// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';

import '../models/food.dart';
import '../models/result.dart';

class FoodRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<Either<ErrorHandler, bool>> addFood(Food food) async {
    try {
      await _firestore.collection("foods").doc(food.id).set(food.toMap());

      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }
}
