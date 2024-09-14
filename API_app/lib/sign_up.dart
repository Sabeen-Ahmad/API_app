import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();//assigned to text fields in Flutter forms so the app can retrieve the entered data.
  TextEditingController passwordController = TextEditingController();
  void login(String email,password) async {
    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        body:{
          'email':email,
          'password':password,
        }
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);// The program then accesses the 'token' field from the decoded data and prints it.
        print('account created successfully');
      }
      else{
        print('failed');
      }
    }
    catch(e){
      print(e.toString());//This catch block ensures that if any error occurs during the process (e.g., network failure, invalid URL), it catches the exception and prints the error message.
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Sign up')
      ),
          body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
TextFormField(
  controller: emailController,
  decoration:InputDecoration(
    hintText: 'Email',
  )
),
              SizedBox(height: 20,),
              TextFormField(
                  controller: passwordController,
                  decoration:InputDecoration(
                    hintText: 'password',
                  )
              ),
              SizedBox(height:40,),
              GestureDetector(
                onTap:(){
                  login(emailController.text.toString(),passwordController.text.toString());
                },
                child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 22),
                child: Container(
                  height:40,
                  decoration:BoxDecoration(
                    color:Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Center(
                    child:Text('Sign up'),
                  )
                ),
              )

              )],
    )
    );
  }
}
//The code defines a simple function that sends a user's email and password to an API endpoint for account creation or registration.
// If the API call succeeds (with a status code of 200), it prints the token returned by the server and a success message. Otherwise, it prints 'failed'.
// Any errors during the process are caught and logged to the console.