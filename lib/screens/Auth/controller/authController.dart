import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  RxBool isLoginLoading = false.obs;
  RxBool isSignUpLoading = false.obs;
  RxBool isLogOutLoading = false.obs;
  RxString errorMessage = "".obs;

// User creation
  Future<User?> createUser(String email, String password) async {
    isSignUpLoading.value = true;
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isSignUpLoading.value = false;
      return userCredential.user;
    } catch (e) {
      isSignUpLoading.value = false;
      log('Error during registration: $e');

      return null;
    }
  }

// Login
  Future<User?> loginWithEmail(String email, String password) async {
    isLoginLoading.value = true;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoginLoading.value = false;
      return userCredential.user;
    } catch (e) {
      log('Error during login: $e');
      isLoginLoading.value = false;
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    isLogOutLoading.value = true;
    await _auth.signOut();
    isLogOutLoading.value = false;
  }
}
