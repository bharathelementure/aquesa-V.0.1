// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

File? file;
String selectedImagepath = "";

selectImageGallery() async {
  XFile? xfile = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 100);
  file = File(xfile!.path);
  if (file != null) {
    return file!.path;
  } else {
    return '';
  }
}

selectImageCamera() async {
  XFile? xfile = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 100);
  file = File(xfile!.path);
  if (file != null) {
    return file!.path;
  } else {
    return '';
  }
}

Future pickoptionalImage(context) {
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
                          selectedImagepath = await selectImageGallery();
                          if (selectedImagepath != '') {
                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(msg: 'Image not selected !');
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
                          selectedImagepath = await selectImageCamera();
                          if (selectedImagepath != '') {
                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(msg: 'Image not selected !');
                          }
                        },
                        child: const Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Icon(Icons.linked_camera, size: 50),
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
