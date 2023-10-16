import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}
class SignUpState extends State<SignUp> {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassWord = TextEditingController();
  final TextEditingController _controllerPassWordAuth = TextEditingController();
  late var emailString;
  late  var passwordString;
  @override
  void initState() {
    super.initState();
    // _controllerEmail.addListener(() {
    //   emailString = _controllerEmail.text;
    // });
    // _controllerPassWord.addListener(() {
    //   passwordString = _controllerPassWord.text;
    // });

  }
  @override
  void dispose() {
    _controllerPassWord.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final logoSignUp = CircleAvatar(
      radius : 50,
      backgroundColor: Colors.white,
      child: Image.asset('assets/image/sign-up-here.png'),
    );
    final email  = TextFormField(
      controller: _controllerEmail,
      autofocus: false,
      obscureText: false,
      decoration: InputDecoration(
        hintText: 'Email...',
        contentPadding: EdgeInsets.all(20),
        border : OutlineInputBorder(
          borderRadius: BorderRadius.circular(30)
        )
      ),
    );
    final password = TextFormField(
      controller: _controllerPassWord,      autofocus: false,
      obscureText: false,
      decoration: InputDecoration(
        hintText: 'Password...',
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30)
        )
      ),
    );
    final passwordAuth = TextFormField(
      controller : _controllerPassWordAuth,
      autofocus: false,
      obscureText: false,
      decoration: InputDecoration(
          hintText: 'Confirm Password...',
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ),
    );
    final button = TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          textStyle: TextStyle(fontSize: 17,
          color: Colors.white)
        ),
        child: const Text('Create an account'),
        onPressed: () {
          if (_controllerPassWord.text != _controllerPassWordAuth.text) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password không trùng nhau, vui lòng nhập lại')));
          } else {
            FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                email: _controllerEmail.text,
                password: _controllerPassWord.text)
                .then((value) {
              Navigator.pop(context);
            }).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error ${error.toString()}')));
            });
          }
          }
    );
    RichText already = RichText(
        text:  TextSpan(
          style: TextStyle(
            color : Colors.black
          ),
          children: <TextSpan> [
            TextSpan(
              text: 'Already have an account?',
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              recognizer:  TapGestureRecognizer()..onTap = () {Navigator.pop(context);}
            )

          ]
        )

    );

    void click() {
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body : Stack(
          children: [
              Container(
                color: Colors.tealAccent,
              ),
              Center(
                child: ListView(
                  padding: EdgeInsets.only(left : 30, right : 30),
                  shrinkWrap: true,
                   children: <Widget>[
                     // SizedBox(height: 200,),
                     logoSignUp,
                     const SizedBox(height: 30,),
                     email,
                     const SizedBox(height: 10,),
                     password,
                     const SizedBox(height: 10,),
                     passwordAuth,
                     const SizedBox(height: 30,),
                     button,
                     const SizedBox(height : 10),
                     Center(child: already),
                   ],
                ),
              )

          ],
      )
    );
  }

}