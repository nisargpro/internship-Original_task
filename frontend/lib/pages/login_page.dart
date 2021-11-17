import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/Model/login_model.dart';
import 'package:flutter_task/api%20service/api_service.dart';
import 'package:flutter_task/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallprocess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
@override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: HexColor("#283B71"),
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: _loginUI(context),
        ),
        inAsyncCall: isAPIcallprocess,
        opacity: 0.3,
        key: UniqueKey(),
      )
      ),
    );
  }
  Widget _loginUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( 
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/ 4.5,
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
                begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.white,
                Colors.white
              ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100)
              )
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20,bottom: 30,top: 50),
            child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 25,color: Colors.white
            ),),
          ),
          FormHelper.inputFieldWidget(context,
              const Icon(Icons.person),
              'username',
              'username',
              (onValidateVal){
            if (onValidateVal.isEmpty){
              return "Username can't be empty";
            }
            return null;
              }, (onSavedVal){
            username = onSavedVal;
              },
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context,
              const Icon(Icons.person),
              "password",
              "password",
                  (onValidateVal){
                if (onValidateVal.isEmpty){
                  return "Password can't be empty";
                }
                return null;
              }, (onSavedVal){
                password = onSavedVal;
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  hidePassword = !hidePassword;
                });
              },color: Colors.white.withOpacity(0.7), icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility))
            ),
          ),
          SizedBox(height: 25,),
          Center(
            child: FormHelper.submitButton("Login", (){
              if(validateAndSave()){
                setState(() {
                  isAPIcallprocess = true;
                });
                LoginRequestModel model = LoginRequestModel(username: username!, password: password!);
               APIService.login(model).then((response){
                 setState(() {
                   isAPIcallprocess = false;
                 });
                 if(response){
                   Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                 }
                 else{
                   FormHelper.showSimpleAlertDialog(context, Config.appName, "Invalid Username/Password !", "ok", (){
                     Navigator.pop(context);
                   });
                 }
               });
              }
            },
            btnColor: HexColor("#283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          SizedBox(height: 30,),
          Center(child: Text("OR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),)),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25,top: 10),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Don't have an account?"),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                        Navigator.pushNamed(context, "/register");
                        },
                    )
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }
  }
}
