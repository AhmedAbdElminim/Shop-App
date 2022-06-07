import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'UploadProductStates.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadProductCubit extends Cubit<UploadProductStates> {
  UploadProductCubit() : super(UploadProductInitialStates());
  static UploadProductCubit get(context) => BlocProvider.of(context);
  var productTitleController = TextEditingController();
  var productPriceController = TextEditingController();
  var productCategoryController = TextEditingController();
  var productBrandController = TextEditingController();
  var productDescriptionController = TextEditingController();
  var productQuantityController = TextEditingController();
  void selectCategoryItem(String value) {
    productCategoryController.text = value;
    emit(UploadProductSelectCategoryState());
  }

  void selectBrandItem(String value) {
    productBrandController.text = value;
    emit(UploadProductSelectBrandState());
  }

  File? productImage;
  var picker = ImagePicker();
  Future<void> getProductImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);

      emit(UploadProductImageSuccessesState());
    } else {
      emit(UploadProductImageSuccessesState());
    }
  }

  Future<void> getProductImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);

      emit(UploadProductImageSuccessesState());
    } else {
      emit(UploadProductImageSuccessesState());
    }
  }

  void RemoveProductImage() {
    productImage = null;

    emit(UploadProductRemoveImageSuccessesState());
  }

  //-----------------------------------------------------------------//
  void uploadNewProduct({
    required String id,
    required String title,
    required double price,
    bool? ispopular,
    required int quantity,
    required String description,
    String? image,
    required String productCategoryName,
    required String brand,
  }) {
    ProductModel productModel = ProductModel(
        id: id,
        title: title,
        price: price,
        description: description,
        imageUrl: image ?? '',
        productCategoryName: productCategoryName,
        brand: brand,
        quantity: quantity,
        isPopular: ispopular ?? false);

    FirebaseFirestore.instance
        .collection('products')
        .add(productModel.toMap())
        .then((value) {
      emit(UploadNewProductSuccessesState());
    }).catchError((error) {
      emit(UploadNewProductErrorState(error.toString()));
    });
  }

  void uploadProductImage({
    required String id,
    required String title,
    required double price,
    bool? ispopular,
    required int quantity,
    required String description,
    required String productCategoryName,
    required String brand,
  }) {
    emit(UploadNewProductImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadNewProduct(
            id: id,
            image: value,
            brand: brand,
            productCategoryName: productCategoryName,
            description: description,
            quantity: quantity,
            title: title,
            price: price,
            ispopular: ispopular ?? false);
      }).catchError((error) {});

      emit(UploadNewProductImageSuccessesState());
    }).catchError((error) {
      emit(UploadNewProductImageErrorState(error.toString()));
    });
  }
}
