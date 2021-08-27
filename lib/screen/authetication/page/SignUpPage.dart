import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/common/Constants.dart';
import 'package:solo_shop_app_practice/models/HttpException.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/Auth.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/LoadingProvider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const String route = 'SignUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailNameController = TextEditingController();
  final passwordNameController = TextEditingController();
  final confirmPasswordNameController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LoadingProvider>(context,listen: false).setDefault();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text(
                'It Just Takes Less Than 2 Minutes To Create Your New Account.',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                controller: emailNameController,
                maxLength: 255,
                textInputAction: TextInputAction.next,
                decoration: Constants().getInputDecoration('Email'),
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Please Enter Email';

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                controller: passwordNameController,
                maxLength: 30,
                textInputAction: TextInputAction.next,
                decoration: Constants().getInputDecoration('Password'),
                validator: (value) => value == null || value.length < 6
                    ? 'Please Enter password with minimum 6 characters'
                    : null,
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                controller: confirmPasswordNameController,
                maxLength: 30,
                decoration: Constants().getInputDecoration('Confirm Password'),
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Please Enter Password Confirmation';
                  else if (value != passwordNameController.text)
                    return 'Password didn\'t match';
                  return null;
                },
                obscureText: true,
              ),
            ),
            Container(
              height: 75,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Consumer<LoadingProvider>(
                builder: (context, loadingProvider, child) {
                  return loadingProvider.getLoading()
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {},
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Loading...')
                              ]),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              loadingProvider.toggleLoading();
                              Future.delayed(Duration(seconds: 1), () {

                                  Provider.of<Auth>(context, listen: false)
                                      .signUp(emailNameController.text.trim(),
                                          passwordNameController.text.trim())
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Done')));
                                    loadingProvider.toggleLoading();
                                    Navigator.pop(context);
                                  }).onError((error, stackTrace){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error.toString())));
                                    loadingProvider.toggleLoading();
                                    Navigator.pop(context);
                                  });

                              });
                            }
                          },
                          child: Text('Sign Up'),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailNameController.dispose();
    passwordNameController.dispose();
    confirmPasswordNameController.dispose();
    super.dispose();
  }
}
