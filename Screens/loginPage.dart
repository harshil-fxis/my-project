import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login1/Screens/bottomnav.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// email : eve.holt@reqres.in

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login page"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.brown.shade50,
          ),
          height: 250,
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  hintText: "password",
                ),
              ),
              GestureDetector(
                onTap: (){
                  loginData(emailcontroller.text.toString(), passwordcontroller.text.toString());
                },
                child: Container(
                  height: 40,
                  color: Colors.teal.shade200,
                  child: Center(child: Text("Login",style: TextStyle(fontSize: 20),)),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
  void loginData(String email,String password) async{
    try{
      Response response = await post(Uri.parse("https://reqres.in/api/login"),
          body: {
            'email': email,
            'password': password,
          }
          );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        showmessage("Account Successfully Created !");
        Navigator.push(context, MaterialPageRoute(builder: (context) => bottomnav()));
      }else{
        showmessage("Please enter valid email and password !");
      }
    }catch(e){
      print(e.toString());
    }
  }
  void showmessage(message){
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}