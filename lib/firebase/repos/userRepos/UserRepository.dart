import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/firebase/repos/usermodel/usermodel.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserRepository {
  final _db  = FirebaseFirestore.instance;
  createUser(UserModel user) async {
    await _db.collection("users").add(user.toJson());
  }
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
     home : Scaffold(
       floatingActionButton: FloatingActionButton(
         onPressed: () async{
           UserRepository user = UserRepository();
           await user.createUser(UserModel(email: 'combuomxinh@gmail.com', password: 'deobiet'));
           try {
             UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                 email: "thanhdepzai37@gmail.com",
                 password: "prolaa2nh007"
             );
           } on FirebaseAuthException catch (e) {
             if (e.code == 'user-not-found') {
               print('No user found for that email.');
             } else if (e.code == 'wrong-password') {
               print('Wrong password provided for that user.');
             }
           }
         },
       ),
     )
  ));

}