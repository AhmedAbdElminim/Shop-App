import 'dart:io';

import 'package:e_commerce_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Register_States.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
/*
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());
  static RegisterCubit get(context) => BlocProvider.of(context);

  File? userImage;
  var picker = ImagePicker();
  Future<void> getUserProfileImageFromGallery(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userImage = File(pickedFile.path);
      Navigator.pop(context);
      emit(RegisterPickedImageSuccessState());
    } else {
      emit(RegisterPickedImageSuccessState());
    }
  }

  Future<void> getUserProfileImageFromCamera(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      userImage = File(pickedFile.path);
      emit(RegisterPickedImageSuccessState());
      Navigator.pop(context);
    } else {
      emit(RegisterPickedImageSuccessState());
    }
  }

  void RemoveUserImage(context) {
    userImage = null;
    Navigator.pop(context);
    emit(RegisterRemoveUserImageSuccessState());
  }

  void showDailogForPickedImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Choose option',
          style: TextStyle(color: Colors.purple),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).splashColor,
                onTap: () {
                  getUserProfileImageFromCamera(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Camera',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).splashColor,
                onTap: () {
                  getUserProfileImageFromGallery(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).splashColor,
                onTap: () {
                  RemoveUserImage(context);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.remove,
                          size: 15,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Remove',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).then((value) {
      emit(RegisterShowDialogImageSuccessState());
    });
  }

  void RegisterUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String image,
  }) {
    emit(RegisterUserLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createNewUser(
          uId: value.user!.uid, email: email, phone: phone, name: name,image: image);
      emit(RegisterUserSuccessState());
    }).catchError((error) {
      //print('the error in register is ${error.toString()}');
      emit(RegisterUserErrorState(error.toString()));
    });
  }

  void createNewUser({
    required String email,
    required String uId,
    required String name,
    required String phone,
    required String image,
  }) {
    UserModel model = UserModel(
      email,
      name,
      phone,
      uId,
      image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      print('the error in create is ${error.toString()}');
      emit(RegisterCreateUserErrorState());
    });
  }
  bool isSecure=true;
  void securePassword(){
    isSecure=!isSecure;
    emit(RegisterSecurePasswordState());
  }
  void uploadUserImage({
    required String email,
    required String name,
    required String phone,
    required String password,

}){
    emit(RegisterUploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(userImage!.path).pathSegments.last}')
        .putFile(userImage!).then((value) {
          value.ref.getDownloadURL().then((value) {
            RegisterUser(email: email,name: name,phone: phone,image: value,password:password );
            emit(RegisterUploadImageSuccessState());
          }).catchError((error){});
          emit(RegisterUploadImageSuccessState());
    }).catchError((error){
      emit(RegisterUploadImageErrorState(error.toString()));
    });
  }

}
*/