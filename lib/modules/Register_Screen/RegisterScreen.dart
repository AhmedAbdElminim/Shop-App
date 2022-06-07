import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/shared/Bloc/Cubit/Cubit.dart';
import 'package:e_commerce_app/shared/Bloc/States/States.dart';
import 'package:e_commerce_app/shared/Network/Local/CasheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../layout/LayOut_Screens/BottomNavigationScreen.dart';
import '../../shared/Component/Componetnt.dart';
import '../../shared/Constant/Constant.dart';
import '../../shared/Style/Colors.dart';
import '../Login_Screen/LoginScreen.dart';
import '../Swip_screen/SwipScreen.dart';
import 'Register_Bloc/Register_Cubit.dart';
import 'Register_Bloc/Register_States.dart';

class RegisterScreen extends StatelessWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is RegisterUserSuccessState) {
          uId = state.uId;

          CasheHelper.saveData(key: 'uId', value: state.uId);
          CasheHelper.saveData(key: 'token', value: 'token');
          showToAst(msg: 'Register Done Successfly', iserror: false);
          navigateAndFinish(
            context: context,
            widget: SwipScreen(),
          );
          AppCubit.get(context).getUserData();
        }
        if (state is RegisterUserErrorState) {
          showToAst(
              msg: state.error
                  .toString()
                  .substring(36, state.error.toString().length),
              iserror: true);
        }
        if (state is RegisterUploadImageErrorState) {
          showToAst(msg: state.error.toString(), iserror: true);
        }
      },
      builder: (context, state) {
        var userImage = AppCubit.get(context).userImage;
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.95,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [
                          ColorsConsts.gradiendFStart,
                          ColorsConsts.gradiendLStart
                        ],
                        [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                      ],
                      durations: [19440, 10800],
                      heightPercentages: [0.20, 0.25],
                      blur: MaskFilter.blur(BlurStyle.solid, 10),
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight,
                    ),
                    waveAmplitude: 0,
                    size: Size(
                      double.infinity,
                      double.infinity,
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Container(
                          height: 630,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.7),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.red[900],
                                        child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              AppCubit.get(context).userImage ==
                                                      null
                                                  ? null
                                                  : FileImage(userImage!)
                                                      as ImageProvider,
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            AppCubit.get(context)
                                                .showDailogForPickedImage(
                                                    context);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.grey,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red[900],
                                            child: Icon(
                                              Icons.add_a_photo,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'Please Enter Your Name 😏';

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          'Name',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'Please enter Your Numberphone 😏';
                                      if (value.length < 11)
                                        return 'Plesse Enter a Valid Number Phone 😏';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.phone_android,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          'Phone',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'Please enter Email 😏';
                                      if (!value.contains('@'))
                                        return 'Plesse enter a valid Email 😏';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          'Email',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: passController,
                                    obscureText: AppCubit.get(context).isSecure,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'Please enter PassWord 😏';
                                      if (value.length < 7)
                                        return 'Password is short 😏';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              AppCubit.get(context)
                                                  .securePassword();
                                            },
                                            icon: AppCubit.get(context).isSecure
                                                ? Icon(
                                                    Icons.visibility,
                                                  )
                                                : Icon(
                                                    Icons.visibility_off,
                                                  )),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          'PassWord',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        AppCubit.get(context).uploadUserImage(
                                          email: emailController.text,
                                          password: passController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: <Color>[
                                                Colors.blue,
                                                Colors.purple
                                              ])),
                                      child: ConditionalBuilder(
                                        condition: state
                                                is! RegisterUploadImageLoadingState ||
                                            state is! RegisterUserLoadingState,
                                        builder: (context) => Text(
                                          'SIGNUP',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        fallback: (context) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Do have an Account?',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()));
                                          },
                                          child: Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                color: Colors.deepPurple,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
