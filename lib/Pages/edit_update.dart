// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otp_auth/Screens/home.dart';
import 'package:otp_auth/controllers/save_localy.dart';
import 'package:otp_auth/models/userModels.dart';
import 'package:path/path.dart';

class EditUpdate extends StatefulWidget {
  const EditUpdate({super.key});

  @override
  State<EditUpdate> createState() => _EditUpdateState();
}

class _EditUpdateState extends State<EditUpdate> {
  // late UserMode reuse;

  // camera
  File? file;
  String selectedImagePath = "";

  final emailController = TextEditingController();
  final nameEditingController = TextEditingController();
  final numberController = TextEditingController();
  final curr = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
            child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Edit Profile',
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
              const SizedBox(height: 20),
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(curr?.uid)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      'Something went wrong',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ));
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text(
                      'Document Does Not Exists',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> dataread =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final namedit =
                        TextEditingController(text: dataread['displayName']);
                    final phonedit = TextEditingController(
                        text: dataread['phoneNumber'].toString());
                    final emailedit =
                        TextEditingController(text: dataread['email']);
                    // final profileedit = Image.network(dataread['photoURL']);
                    // LocalStorage
                    FirebaseDatabase.instance.setPersistenceEnabled(true);
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ProfileController
                          Stack(children: [
                            // ProfileWidget(
                            //     profileimage: dataread['profileimage'],
                            //     isEdit: true,
                            //     onClicked: () {
                            //       selectImage(context);
                            //     }),
                            GestureDetector(
                              onTap: () {
                                selectImage(context);
                                setState(() {});
                              },
                              child: SizedBox(
                                width: 130,
                                height: 130,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: file == null
                                        ? InkWell(
                                            onTap: () {
                                              selectImage(context);
                                              setState(() {});
                                            },
                                            child: Image.network(
                                              '${dataread['photoURL']}',
                                              scale: 30,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return const Icon(
                                                  Icons.account_circle_rounded,
                                                  size: 125,
                                                  color: Color(0xFF4483D0),
                                                );
                                              },
                                            )
                                            /*CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${dataread['profileimage']}'),
                                            radius: 80,
                                            onBackgroundImageError:
                                                (exception, stackTrace) {
                                              const Icon(
                                                Icons.account_circle_rounded,
                                                size: 60,
                                              );
                                            },
                                          )*/
                                            )
                                        : Image.file(
                                            file!,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )),
                              ),
                            ),
                            Positioned(
                              bottom: -15,
                              right: -10,
                              child: IconButton(
                                  onPressed: () {
                                    selectImage(context);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.linked_camera_rounded,
                                    size: 25,
                                    color: Colors.black,
                                  )),
                            ),
                          ]),
                          const SizedBox(height: 10),
                          // Namecontroller
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
                              controller: namedit,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Name',
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
                              controller: phonedit,
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
                              controller: emailedit,
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
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 150,
                            height: 47,
                            child: ElevatedButton(
                                onPressed: () async {
                                  saveUserOffline(UserMode.fromjson(dataread));
                                  updateProfile(context);
                                  final String editname = namedit.text;
                                  final int editphone =
                                      int.parse(phonedit.text);
                                  // final String editemail = emailedit.text;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(curr?.uid)
                                      .update({
                                        'displayName': editname,
                                        'phoneNumber': editphone,
                                        // 'email': editemail
                                      })
                                      .then((value) => Fluttertoast.showToast(
                                          msg: 'Updated successfully'))
                                      .catchError((e) =>
                                          Fluttertoast.showToast(msg: e));
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  if (mounted) return;
                                  Navigator.pop(context);
                                  var navi = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Graph()));
                                  if (navi == true || navi == null) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/graph',
                                            (Route<dynamic> route) => false);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    padding: const EdgeInsets.all(0)),
                                child: Ink(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF6FADE0),
                                          Color(0xFF4483D0)
                                        ]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 140, minHeight: 47),
                                        alignment: Alignment.center,
                                        child: Text(
                                          namedit.text.isEmpty
                                              ? 'Save'
                                              : 'Update',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 14,
                                              fontFamily: 'inter',
                                              fontWeight: FontWeight.w600),
                                        )))),
                          )
                        ]);
                  }
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'raleway',
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              )
            ]))));
  }

  selectImageFromGallery() async {
    XFile? xfile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    // print("file" + xfile!.path);
    file = File(xfile!.path);
    // setState(() {});
    if (file != null) {
      // print(file!.path);
      return file!.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? xfile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    // print("file" + xfile!.path);
    file = File(xfile!.path);
    // setState(() {});
    if (file != null) {
      // uploadImage(context);
      // print(file!.path);
      return file!.path;
    } else {
      return '';
    }
  }

  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = {};
    if (file != null) {
      String url = await uploadImage();
      map['photoURL'] = url;
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
    Navigator.pop(context);
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profileimage")
        .child(
            "${FirebaseAuth.instance.currentUser!.uid}_${basename(file!.path)}")
        .putFile(file!);
    return taskSnapshot.ref.getDownloadURL();
  }

  Future selectImage(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text('Select Image From !'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            if (selectedImagePath != '') {
                              Navigator.of(context).pop();
                              setState(() {});
                            } else {
                              Fluttertoast.showToast(msg: 'No image selected!');
                            }
                          },
                          child: const Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Icon(Icons.image_outlined, size: 50),
                                  Text('Gallery')
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_path:-');
                            if (selectedImagePath != '') {
                              Navigator.of(context).pop();
                              setState(() {});
                            } else {
                              Fluttertoast.showToast(msg: 'No image selected!');
                            }
                          },
                          child: const Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.linked_camera_outlined,
                                    size: 50,
                                  ),
                                  Text('Camera')
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
