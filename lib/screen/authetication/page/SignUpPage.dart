import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/common/Constants.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/AlternativeAuthenticationClass.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/LoadingProvider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const String route='SignUpPage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userNameController=TextEditingController();
  final emailNameController=TextEditingController();
  final phoneNameController=TextEditingController();
  final passwordNameController=TextEditingController();
  final confirmPasswordNameController=TextEditingController();
  GlobalKey<FormState> key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create:(context)=> LoadingProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Form(
          key: key,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child:Text('It Just Takes Less Than 2 Minutes To Create Your New Account.',textAlign: TextAlign.center,) ,
              ),

              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  maxLength: 30,
                  controller: userNameController,
                  textInputAction: TextInputAction.next,
                  decoration: Constants().getInputDecoration('Username'),
                  validator: (value)=>value==null || value.length<1?'Please Enter Username':null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: emailNameController,
                  maxLength: 255,
                  textInputAction: TextInputAction.next,
                  decoration: Constants().getInputDecoration('Email'),
                  validator: (value){
                    if (value==null || value.length<1) return 'Please Enter Email';

                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: phoneNameController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: Constants().getInputDecoration('Phone'),
                  validator: (value)=>value==null || value.length<10?'Please Enter 10 digit Phone number':null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: passwordNameController,
                  maxLength: 30,
                  textInputAction: TextInputAction.next,
                  decoration: Constants().getInputDecoration('Password'),
                  validator: (value)=>value==null || value.length<8?'Please Enter password with minimum 8 characters':null,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: confirmPasswordNameController,
                  maxLength: 30,
                  decoration: Constants().getInputDecoration('Confirm Password'),
                  validator: (value){
                    if (value==null || value.length<1) return 'Please Enter Password Confirmation';
                    else if (value!=passwordNameController.text) return 'Password didn\'t match';
                   return null;
                  },
                  obscureText: true,
                ),
              ),
              Container(
                height: 75,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
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
                          Provider.of<AuthenticationClass>(context).signUp(email:emailNameController.text.trim(), password: passwordNameController.text.trim()
                            ,username: userNameController.text.trim(),phone: phoneNameController.text.trim()).then((value){
                            if (value=='Done'){
                              Navigator.pop(context);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                            Provider.of<LoadingProvider>(context,listen: false).toggleLoading();

                          }

                          );

                        });



                      }
                    },
                    child:Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    userNameController.dispose();
    emailNameController.dispose();
    phoneNameController.dispose();
    passwordNameController.dispose();
    confirmPasswordNameController.dispose();
    super.dispose();
  }
}
