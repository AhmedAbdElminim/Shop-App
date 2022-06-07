import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/modules/Landing_Screen/LandingScreen.dart';
import 'package:e_commerce_app/shared/Component/Componetnt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/ProductModel.dart';
import '../../Constant/Constant.dart';
import '../../Constant/data.dart';
import '../../Network/Local/CasheHelper.dart';
import '../States/States.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int DotsIndex = 0;
  void ChangeDotsOfCarousal(index) {
    DotsIndex = index;
    emit(AppChangeDotsOfCarousalState());
  }

  UserModel? userModel;

  void ChangePostionOfFloatingButton() {
    emit(AppChangePostionOfFlaotingActionButton());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeState());
    } else {
      isDark = !isDark;
      CasheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeState());
      });
    }
  }

  // List<ProductModel> Products = Data.products;
  ///////////////////////
  List<ProductModel> LaptopList = [];
  List<ProductModel> PhonesList = [];
  List<ProductModel> BeautyList = [];
  List<ProductModel> FurnitureList = [];
  List<ProductModel> ClothesList = [];
  List<ProductModel> ShoesList = [];
  List<ProductModel> WathchesList = [];
  List<ProductModel> ViewesRecentlyList = [];

  List<ProductModel> getCategoryList({index}) {
    LaptopList = [];
    PhonesList = [];
    BeautyList = [];
    FurnitureList = [];
    ClothesList = [];
    ShoesList = [];
    WathchesList = [];
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].productCategoryName == 'Laptops') {
        LaptopList.add(Products[i]);
      }
      if (Products[i].productCategoryName == 'Phones') {
        PhonesList.add(Products[i]);
      }
      if (Products[i].productCategoryName == 'Beauty & health') {
        BeautyList.add(Products[i]);
      }
      if (Products[i].productCategoryName == 'Furniture') {
        FurnitureList.add(Products[i]);
      }
      if (Products[i].productCategoryName == 'Clothes') {
        ClothesList.add(Products[i]);
      }
      if (Products[i].productCategoryName == 'Shoes') {
        ShoesList.add(Products[i]);
      }
      if (Products[i].productCategoryName == 'Watches') {
        WathchesList.add(Products[i]);
      }
    }
    if (index == 0) return LaptopList;
    if (index == 1) return PhonesList;
    if (index == 2) return BeautyList;
    if (index == 3) return FurnitureList;
    if (index == 4) return ClothesList;
    if (index == 5) return ShoesList;

    return WathchesList;
  }

  List<ProductModel> AdidasList = [];
  List<ProductModel> AppleList = [];
  List<ProductModel> DellList = [];
  List<ProductModel> HuaweiList = [];
  List<ProductModel> NikeList = [];
  List<ProductModel> SamsungList = [];
  List<ProductModel> HMList = [];
  List<ProductModel> AllPopularBrandList = [];
  List<ProductModel> getAllPopularBrandList({index}) {
    AllPopularBrandList = [];
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].brand != 'No brand') {
        AllPopularBrandList.add(Products[i]);
      }
    }

    return AllPopularBrandList;
  }

  List<ProductModel> getBrandList({index}) {
    AdidasList = [];
    AppleList = [];
    DellList = [];
    HuaweiList = [];
    NikeList = [];
    SamsungList = [];
    HMList = [];
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].brand == 'Addidas') {
        AdidasList.add(Products[i]);
      }
      if (Products[i].brand == 'Nike') {
        NikeList.add(Products[i]);
      }
      if (Products[i].brand == 'H&M') {
        HMList.add(Products[i]);
      }
      if (Products[i].brand == 'Apple') {
        AppleList.add(Products[i]);
      }
      if (Products[i].brand == 'Samsung') {
        SamsungList.add(Products[i]);
      }
      if (Products[i].brand == 'Huawei') {
        HuaweiList.add(Products[i]);
      }
      if (Products[i].brand == 'Dell') {
        DellList.add(Products[i]);
      }
    }
    if (index == 0) return AdidasList;
    if (index == 1) return AppleList;
    if (index == 2) return DellList;
    if (index == 3) return HuaweiList;
    if (index == 4) return NikeList;
    if (index == 5) return SamsungList;

    return HMList;
  }

  List<ProductModel> PopularProductList = [];
  List<ProductModel> getPopularProduct({index}) {
    PopularProductList = [];
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].isPopular == true) {
        PopularProductList.add(Products[i]);
      }
    }
    return PopularProductList;
  }

  bool inwish = false;
  List<ProductModel> inWishList = [];
  void Add_DeleteFromWishList(ProductModel inwishlist) {
    inwish = !inwish;
    if (inwish) {
      inWishList.add(inwishlist);
    } else {
      inWishList.remove(inwishlist);
    }
  }

  void signout(context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      navigateAndFinish(context: context, widget: LandingScreen());
      emit(AppSignOutSuccessState());
    });
  }

  void getUserData() {
    emit(AppGetUserLoadingState());
//'hkJqBIFh5cMU7XffaXQAfUEtQFh2'
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());

      emit(AppGetUserSuccessState());
    }).catchError((error) {
      emit(AppGetUserErrorState(error.toString()));
    });
  }
//-------------------------------------------------------------------------------------------------------------//
  ////Login methods///////

  bool passwordvisibility = true;
  void changePasswordVisibilty() {
    passwordvisibility = !passwordvisibility;
    emit(LoginChangePasswordVisibiltyState());
  }

  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void emitLoginSuccessState(uid) {
    emit(LoginSuccessState(uid));
  }

//-------------------------------------------------------------------------------------------------------------//
//Register Methods////////
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
          uId: value.user!.uid,
          email: email,
          phone: phone,
          name: name,
          image: image);
      emit(RegisterUserSuccessState(value.user!.uid));
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

  bool isSecure = true;
  void securePassword() {
    isSecure = !isSecure;
    emit(RegisterSecurePasswordState());
  }

  void uploadUserImage({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(RegisterUploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(userImage!.path).pathSegments.last}')
        .putFile(userImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        RegisterUser(
            email: email,
            name: name,
            phone: phone,
            image: value,
            password: password);
        emit(RegisterUploadImageSuccessState());
      }).catchError((error) {});
      emit(RegisterUploadImageSuccessState());
    }).catchError((error) {
      emit(RegisterUploadImageErrorState(error.toString()));
    });
  }

//---------------------------------------------------------------------------------------------------------//
//Get All Products from firebase
  List<Map> productlist = [];
  List<ProductModel> Products = [];

  void getAllProducts() {
    //productlist=[];

    emit(GetAllProductsLoadingState());
    if (Products.isEmpty) {
      FirebaseFirestore.instance.collection('products').get().then((value) {
        for (var element in value.docs) {
          //final data=ProductModel.fromJson(element.data());
          //productlist.add(data);
          productlist.add(element.data());
          Products.add(ProductModel.fromJson(element.data()));
        }

        emit(GetAllProductsSuccessState());
      }).catchError((error) {
        emit(GetAllProductsErrorState(error.toString()));
      });
    }
  }
//----------------------------------------------------------------------------------------------------//
//In Cart Logic----------------------//

  int lengthOfCartList = 0;
  var num;
  List<ProductModel> inCartList = [];
  var checkOut;
  var price;
  void AddToCart(ProductModel incartlist) {
    inCartList.add(incartlist);
    lengthOfCartList++;
    num = List<int>.generate(lengthOfCartList, (index) => 1);
    checkOut = List<double>.generate(lengthOfCartList, (index) => 1.0);
    price = List<double>.generate(lengthOfCartList, (index) => 1.0);
    //checkOut.add(inCartList[index].price!*num[index]);

    //CalculateTheTotalPrice();
    emit(AppAddInCartSuccessState());
  }

  var totalsum = 0.0;
  void CalculateTheTotalPrice() {
    totalsum = 0.0;
    for (int i = 0; i < lengthOfCartList; i++) {
      checkOut[i] = (inCartList[i].price! * num[i]);
      // price[i]=inCartList[i].price;
      totalsum += checkOut[i];
    }
  }

  void ClearCartList() {
    inCartList = [];
    checkOut = [];
    num = [];
    emit(AppClearInCartList());
  }

  void removeSelecteditemFromCartList(index) {
    inCartList.removeAt(index);
    emit(RemoveSelectedItemFromCartSuccessState());
  }

  // var num= List<int>.generate(0, (i) => 1);

  void CalculateThePriceOfProductsInCart(opertor, index) {
    if (opertor == '+') {
      num[index] += 1;
    }
    if (opertor == '-') {
      num[index] -= 1;
    }
    emit(SetelctTheNumberOfItemInEachProductInCartSuccessState());
  }

//----------------------------------------------------------------------------------------------------//
//In Wish Logic----------------------//
  void ClearWishList() {
    inWishList = [];
    emit(AppClearInWishList());
  }

//-------------------------------------------------------------------------------------------------//
//Search Logic------------------------------------->//
  String onChangeValue = '';
  void getSearchProducts(String searchEnteredKeyword) {
    List<ProductModel> results = [];

    if (searchEnteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      // testlist();
      results = Products;
      onChangeValue = searchEnteredKeyword;
    } else {
      emit(SearchInProductsLoadingState());
      onChangeValue = searchEnteredKeyword;
      results = Products.where((product) => product.title!
          .toLowerCase()
          .contains(searchEnteredKeyword.toLowerCase())).toList();
      SearchList = results;
      emit(SearchInProductsSuccessState());
    }
  }

  //------//
  List<ProductModel> SearchList = [];
}
