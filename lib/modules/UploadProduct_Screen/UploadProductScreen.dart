import 'dart:io';

import 'package:e_commerce_app/layout/LayOut_Screens/BottomNavigationScreen.dart';
import 'package:e_commerce_app/modules/Swip_screen/SwipScreen.dart';
import 'package:e_commerce_app/shared/Bloc/Cubit/Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Component/Componetnt.dart';
import 'UploadProductBloc/UploadProductCubit.dart';
import 'UploadProductBloc/UploadProductStates.dart';

class UploadProductScreen extends StatelessWidget {
  //const UploadProductScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadProductCubit(),
      child: BlocConsumer<UploadProductCubit, UploadProductStates>(
        listener: (context, state) {
          if (state is UploadNewProductErrorState) {
            showToAst(msg: state.error.toString(), iserror: true);
          }
          if (state is UploadNewProductImageErrorState) {
            showToAst(msg: state.error.toString(), iserror: true);
          }
          if (state is UploadNewProductImageSuccessesState) {
            showToAst(
                msg: 'Product Successfly Added To Products', iserror: false);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SwipScreen()));
          }
        },
        builder: (context, state) {
          var cubit = UploadProductCubit.get(context);
          var productImage = cubit.productImage;
          File? nulImage = null;
          var nullimage = File('');
          return Scaffold(
            bottomSheet: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    cubit.uploadProductImage(
                      price: double.parse(cubit.productPriceController.text),
                      description: cubit.productDescriptionController.text,
                      id: cubit.productTitleController.text,
                      title: cubit.productTitleController.text,
                      quantity: int.parse(cubit.productQuantityController.text),
                      productCategoryName: cubit.productCategoryController.text,
                      brand: cubit.productBrandController.text,
                    );
                  }
                },
                splashColor: Theme.of(context).splashColor,
                child: BuildBottomSheet(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: AppCubit.get(context).isDark
                      ? Colors.blueGrey[900]
                      : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (state is UploadNewProductImageLoadingState)
                            SizedBox(
                              height: 10,
                            ),
                          if (state is UploadNewProductImageLoadingState)
                            LinearProgressIndicator(),
                          if (state is UploadNewProductImageLoadingState)
                            SizedBox(
                              height: 10,
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: cubit.productTitleController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Product Title Must Not Be Empty 😏';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Product Title',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: cubit.productPriceController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Product Price Must Not Be Empty 😏';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Price \$',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            //cubit.productImage==null?null:FileImage(productImage!) as ImageProvider
                            children: [
                              Expanded(
                                  child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: cubit.productImage == null
                                      ? AssetImage(
                                          'assets/images/productImage.png')
                                      : FileImage(productImage!)
                                          as ImageProvider,
                                )),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .33,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor:
                                            Theme.of(context).splashColor,
                                        onTap: () {
                                          cubit.getProductImageFromCamera();
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Camera',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
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
                                        splashColor:
                                            Theme.of(context).splashColor,
                                        onTap: () {
                                          cubit.getProductImageFromGallery();
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Gallery',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
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
                                        splashColor:
                                            Theme.of(context).splashColor,
                                        onTap: () {
                                          cubit.RemoveProductImage();
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: cubit.productCategoryController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Product Category Must Not Be Empty 😏';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text(
                                    'Add a new category',
                                    style: TextStyle(),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: DropdownButton<String>(
                                //  value: cubit.productCategoryController.text.toString(),
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: Colors.white,
                                ),
                                hint: Text(
                                  'Select a category',
                                  style: TextStyle(),
                                ),
                                items: <String>[
                                  'Phones',
                                  'Clothes',
                                  'Beauty & healthy',
                                  'Shoes',
                                  'Furniture',
                                  'Watches'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  cubit.selectCategoryItem(value!);
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: cubit.productBrandController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Product Brand Must Not Be Empty 😏';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: Text(
                                    'Brand',
                                    style: TextStyle(),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: DropdownButton<String>(
                                //  value: cubit.productCategoryController.text.toString(),
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: Colors.white,
                                ),
                                hint: Text(
                                  'Select a Brand',
                                  style: TextStyle(),
                                ),
                                items: <String>[
                                  'Brandless',
                                  'Addidas',
                                  'Apple',
                                  'Dell',
                                  'H&M',
                                  'Nike',
                                  'Samsung',
                                  'Huawei',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  cubit.selectBrandItem(value!);
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: cubit.productDescriptionController,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Product Description Must Not Be Empty 😏';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text(
                                'Description',
                                style: TextStyle(),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: cubit.productQuantityController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Product Quantity Must Not Be Empty 😏';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text(
                              'Quantity',
                              style: TextStyle(),
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget BuildBottomSheet(context) => Container(
        color:
            AppCubit.get(context).isDark ? Colors.blueGrey[700] : Colors.grey,
        width: double.infinity,
        height: 55,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Upload',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.file_upload,
                  color: Colors.deepOrange,
                )
              ],
            ),
          ),
        ),
      );
}
