import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
        child: Image.asset('assets/image/login.png'),
        radius: 50,
        backgroundColor: Colors.white
    );
    final user = TextFormField(
      autofocus: true,
      initialValue: '',
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
      ),
    );
    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.all(20),
      ),
    );
  final login = ElevatedButton(

    onPressed: () {

    },
    child: Text('Login'),

    );
  final forgetPassword = TextButton(
      onPressed: () {} ,
      child: Text('Forget password'),
  );
  final signIn = TextButton(
      child : Text('Sign in',
        style: TextStyle(
            color : Colors.red
        ),),
      onPressed: () {},
    );
  return Center(
    child: ListView(
      padding: EdgeInsets.only(left : 24, right : 24),
      shrinkWrap: true,
      children: <Widget>[
        logo,
        SizedBox(height: 30,),
        user,
        SizedBox(height: 5,),
        password,
        SizedBox(height: 15,),
        login,
        SizedBox(height: 5,),
        forgetPassword,
        SizedBox(height: 5,),
        signIn


      ],
    ),
  );
  }

}