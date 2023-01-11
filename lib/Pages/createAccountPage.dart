import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAcountPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const CreateAcountPage({super.key, required this.onClickedSignIn});

  @override
  State<CreateAcountPage> createState() => _CreateAcountPageState();
}

class _CreateAcountPageState extends State<CreateAcountPage> {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameEditingController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          // reverse: true,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Color(0xFF12172B),
                      fontSize: 25,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'to continue',
                  style: TextStyle(
                      color: Color(0xFF12172B),
                      fontSize: 12,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.w500),
                ),
                //name
                const SizedBox(height: 20),
                Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Name cannot be empty");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                nameEditingController.text = value!;
                              },
                              textCapitalization: TextCapitalization.words,
                              controller: nameEditingController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Bharath',
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B)),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF32B7E1), width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B))),
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                  color: Color(0xFF12172B),
                                  fontSize: 12,
                                  fontFamily: 'raleway',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2),
                            ),
                          ),
                          //mobile number
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: TextFormField(
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{10,}$');
                                if (value!.isEmpty) {
                                  return ("Please enter a valid number");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Please enter valid number(Min. 10 Character)");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                numberController.text = value!;
                              },
                              controller: numberController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: '9530847184',
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B)),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF32B7E1), width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Mobile Number',
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B))),
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                  color: Color(0xFF12172B),
                                  fontSize: 12,
                                  fontFamily: 'raleway',
                                  letterSpacing: 2),
                            ),
                          ),
                          // Email Controller
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: TextFormField(
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a Valid email'
                                  : null,
                              onSaved: (value) {
                                emailController.text = value!;
                              },
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: '@gmail',
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B)),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF32B7E1), width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B))),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  color: Color(0xFF12172B),
                                  fontSize: 12,
                                  fontFamily: 'raleway',
                                  letterSpacing: 2),
                            ),
                          ),
                          // Password Controller
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: TextFormField(
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return ("Password is required to Login");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Please enter valid password(Min. 6 Character)");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                passwordController.text = value!;
                              },
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B)),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF32B7E1), width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B))),
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  color: Color(0xFF12172B),
                                  fontSize: 12,
                                  fontFamily: 'raleway',
                                  letterSpacing: 2),
                              obscureText: true,
                            ),
                          ),
                          // Confirm Password
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: TextFormField(
                              validator: (value) {
                                if (confirmPasswordController.text !=
                                    passwordController.text) {
                                  return ('Password didn\'t match');
                                }
                                return null;
                              },
                              onSaved: (value) {
                                confirmPasswordController.text = value!;
                              },
                              controller: confirmPasswordController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B)),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF32B7E1), width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'raleway',
                                      color: Color(0xFF12172B))),
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                  color: Color(0xFF12172B),
                                  fontSize: 12,
                                  fontFamily: 'raleway',
                                  letterSpacing: 2),
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 40),
                          FloatingActionButton(
                            onPressed: () {
                              signUp(emailController.text,
                                  passwordController.text);
                            },
                            backgroundColor: const Color(0xff32B7E1),
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color(0xFF12172B),
                              size: 40,
                            ),
                          )
                        ]))
              ],
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => userCreated(UserMode(
              name: nameEditingController.text,
              email: emailController.text,
              phone: int.parse(numberController.text))))
          // .then((value) => {postDetailFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future userCreated(UserMode user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}

class UserMode {
  String id;
  final String name;
  final int phone;
  final String email;

  UserMode(
      {this.id = '',
      required this.name,
      required this.email,
      required this.phone});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };
  static UserMode fromJson(Map<String, dynamic> json) =>
      UserMode(name: json['name'], email: json['email'], phone: json['phone'],id: json['id']);
}
