
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/common/Constants.dart';
import 'package:solo_shop_app_practice/models/HttpException.dart';
import 'package:solo_shop_app_practice/screen/authetication/page/SignUpPage.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/AlternativeAuthenticationClass.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/LoadingProvider.dart';


class SignInPage extends StatefulWidget {
  static const String route='SignInPage';
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usernameController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key=GlobalKey<FormState>();
    Firebase.initializeApp();
    return ChangeNotifierProvider(
      create: (context)=>LoadingProvider(),
      child: Scaffold(

        body: Center(
          child: SingleChildScrollView(

            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child:Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(backgroundImage: AssetImage('images/logo.jpg'),),
                    ),
                  ),
                  Text('Sign In',style: TextStyle(fontSize: 40),),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: usernameController,
                      maxLength: 30,
                      textInputAction: TextInputAction.next,
                      decoration: Constants().getInputDecoration('Email'),
                      validator: (value)=>value==null || value.length<1?'Please Enter Email':null,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: passwordController,
                      maxLength: 30,
                      decoration: Constants().getInputDecoration('Password',passwordMode:false),
                      obscureText: true,
                      validator: (value)=>value==null || value.length<1?'Please Enter Password':null,




                    ),
                  ),

                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Provider.of<LoadingProvider>(context).getLoading()?
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: (){
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 10,),
                            Text('Loading...')
                          ]),
                    ):ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: (){

                            if(key.currentState!.validate()){
                              Provider.of<LoadingProvider>(context,listen: false).toggleLoading();
                              Future.delayed(Duration(seconds: 1),(){
                                Provider.of<AuthenticationClass>(context).signIn(email:usernameController.text.trim(), password: passwordController.text.trim())
                                    .then((value){
                                  if (value=='Done'){

                                  }

                                  // try{
                                  //   //do login by provider
                                  //
                                  // } on HttpException catch(error){
                                  //  print error
                                  //switch (error.toString()) case if error .toString().containsEMAIL_EXISTS/INVALID_EMAIL/WEAK_PASSWORD/EMAIL_NOT_FOUND/INVALID_PASSWORD ->
                                  // } catch (error){could not authenticate, please try again later}
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                                  }


                                  Provider.of<LoadingProvider>(context,listen: false).toggleLoading();

                                });

                              });

                            }
                          },




                        child:Text('Sign In'),
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SignUpPage.route);
                      },
                      child: Text('Go to Sign Up')
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void submitAuthForm(String email,String password,String username,bool isLogin){

  }
}
