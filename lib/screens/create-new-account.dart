import 'dart:ui';

import 'package:CTAMA/backend/authentication_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:CTAMA/widgets/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:CTAMA/screens/login-screen.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  var confirmPass;

  String password = '';
  String email = '';
  String error = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate1() {
    if (formkey.currentState.validate()) {
      print("validated");
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/register_bg.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400].withOpacity(
                                0.4,
                              ),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Color(0xff5663ff),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: 'Nom et prénom',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        validator: (input) => input.isEmpty
                            ? "veuillez saisir votre Nom et prénom"
                            : null,
                      ),
                      TextInputField(
                          icon: FontAwesomeIcons.envelope,
                          hint: 'Email',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          onSaved: (val) {
                            setState(() => email = val);
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Veuillez saisir une adresse mail"),
                            EmailValidator(
                                errorText:
                                    "Veuillez saisir une adresse mail valid"),
                          ])),
                      PasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: 'Mot de passe',
                        inputAction: TextInputAction.next,
                        validator: (String value) {
                          confirmPass = value;
                          if (value.isEmpty) {
                            return "Veuillez saisir un nouveau mot de passe ";
                          } else if (value.length < 6) {
                            return "Le mot de passe doit contenir au moins 6 caractères";
                          } else {
                            return null;
                          }
                        },
                      ),
                      PasswordInput(
                          icon: FontAwesomeIcons.lock,
                          hint: 'Confirmer mot de passe ',
                          inputAction: TextInputAction.done,
                          onSaved: (val) {
                            setState(() => password = val);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Veuillez ressaisir le nouveau mot de passe";
                            } else if (value != confirmPass) {
                              return "Password must be same as above";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          color: Colors.lightBlue[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: validate1,
                          child: Text("Creer un compte"),
                          textColor: Colors.white),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Déja inscrit?',
                            style: TextStyle(
                                fontSize: 22, color: Colors.white, height: 1.5),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              'Se connecter',
                              style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      height: 1.5)
                                  .copyWith(
                                      color: Color(0xff5663ff),
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
