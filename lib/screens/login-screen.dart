import 'package:CTAMA/backend/authentication_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:CTAMA/screens/create-new-account.dart';
import 'package:CTAMA/widgets/widgets.dart';
import 'package:CTAMA/screens/forgot-password.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void validate() {
    if (formkey.currentState.validate()) {
      context.read<AuthenticationService>().signIn(
          email: emailController.text.trim,
          password: passwordController.text.trim());
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/login_bg.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      'CTAMA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextInputField(
                        icon: FontAwesomeIcons.envelope,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Veuillez saisir une adresse mail"),
                          EmailValidator(
                              errorText:
                                  "Veuillez saisir une adresse mail valide"),
                        ])),
                    PasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: 'Mot De Passe',
                        inputAction: TextInputAction.done,
                        validator: MinLengthValidator(6,
                            errorText: "6 characters au minimum ")),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword())),
                      child: Text(
                        'Mot de passe oublié?',
                        style: TextStyle(
                            fontSize: 22, color: Colors.white, height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RaisedButton(
                      onPressed: validate,
                      child: Text("Se Connecter"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateNewAccount())),
                  child: Container(
                    child: Text(
                      'Creer un nouveau compte',
                      style: TextStyle(
                          fontSize: 22, color: Colors.white, height: 1.5),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.white))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
