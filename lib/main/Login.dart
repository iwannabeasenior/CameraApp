
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/main/Camera.dart';
import 'package:untitled/main/ForgetPassword.dart';
import 'package:untitled/font/eye_icon.dart';
import 'SignUp.dart';
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}
class LoginState extends State<Login> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  late bool obscure = true;
  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: Image.asset('assets/image/login.png')
    );
    final user = TextFormField(
      controller: controllerEmail,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              controllerEmail.clear();
            },
            icon : Icon(Icons.clear)
          ),
          hintText: 'Enter your email',
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
      ),
    );
    final password = TextFormField(

      controller: controllerPassword,
      autofocus: false,
      obscureText: obscure,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              if (obscure) {
                obscure = false;
              } else {
                obscure = true;
              }
            });
          },
          icon : Icon(obscure ? Eye.eye : Eye.eye_slash)
        ),
        hintText: 'Enter your password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.all(20),
      ),
    );
    final login = ElevatedButton(

        onPressed: () async {
          FirebaseAuth.instance.signInWithEmailAndPassword(
              email: controllerEmail.text,
              password: controllerPassword.text)
              .then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Home();
            }));
          })
              .onError((error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error ${error.toString()}')));
          });
        },
      child: const Text('Login'),

    );
    final forgetPassword = TextButton(
      onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ForgetPassword();
              }));
      },
      child: const Text('Forgot password'),
    );
    final signUp = TextButton(
      child : const Text('Sign up',
        style: TextStyle(
            color : Colors.red
        ),),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
      },
    );
    return Center(
      child: ListView(
        padding: EdgeInsets.only(left : 30, right : 30),
        shrinkWrap: true,
        children: <Widget>[
          logo,
          const SizedBox(height: 30,),
          user,
          const SizedBox(height: 5,),
          password,
          const SizedBox(height: 15,),
          login,
          const SizedBox(height: 5,),
          forgetPassword,
          const SizedBox(height: 5,),
          signUp
        ],
      ),
    );
  }

}
