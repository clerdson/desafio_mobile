import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mariocart/main.dart';

class MyController extends GetxController {
  final _num = 0.obs;
  get num => this._num.value;
  set num(value) => this._num.value = value;
    final FirebaseAuth _auth = FirebaseAuth.instance;
 // Example code for registration.
 register(TextEditingController email,TextEditingController pass) async {
   
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: pass.text,
    ))
        .user;
       
 
  Get.snackbar('usuario cadastrado', 'Cadastrado ${user.email}');
  
        

  }
 

  
 signInWithEmailAndPassword(TextEditingController email,TextEditingController pass ) async {
 
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      ))
          .user;
      Get.snackbar(
        "Logado",
        "seu login acabou entrar com ${user.email}",
      );

   
    
    } catch (e) {
 

      Get.snackbar(
        "Logado",
        "seu login acabou entrar com error",
      );
     

     
    
  }
  }

  increment() {
    this.num++;
    
  }
  decrement() {
    this.num--;
  }
sendAnalyticsEvent() async {
    await FirebaseAnalytics().logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true,
      },
    );
    print('logEvent succeeded');
  }

   login() async {
    await FirebaseAnalytics().logSignUp(
      signUpMethod: 'test sign up method',
    );
  print('okok');
  }
}
 // Example code of how to sign in with email and password.


