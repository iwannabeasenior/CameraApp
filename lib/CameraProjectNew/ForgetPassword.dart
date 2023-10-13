import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgetPasswordState();
  }
}
class ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
      final controller = TextEditingController();
      final sendToEmail = TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.all(20),
        ),
        controller: controller,
      );

      final button = ElevatedButton(
          onPressed: () async{
            try {
              await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Reset Email Sent')));
            } on FirebaseAuthException catch(e) {
              print(e);
            }
          },
          child: Text('Reset Password'));
      return Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
        ),
        body : Container(

          child: ListView(
            shrinkWrap: true,
            children: [
                SizedBox(height: 150,),
                const Center(child: Text('Receive an email to reset password',
                style: TextStyle(fontSize: 32),)),
                SizedBox(height: 30,),
                sendToEmail,
                SizedBox(height: 10,),
                button,
            ],
          ),
        )
      );
  }

}