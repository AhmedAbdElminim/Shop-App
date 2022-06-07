import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/modules/Login_Screen/Bloc/LoginCubit.dart';
import 'package:e_commerce_app/modules/Login_Screen/Bloc/LoginStates.dart';
import 'package:e_commerce_app/modules/Swip_screen/SwipScreen.dart';
import 'package:e_commerce_app/shared/Bloc/Cubit/Cubit.dart';
import 'package:e_commerce_app/shared/Bloc/States/States.dart';
import 'package:e_commerce_app/shared/Component/Componetnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../layout/LayOut_Screens/BottomNavigationScreen.dart';
import '../../shared/Constant/Constant.dart';
import '../../shared/Network/Local/CasheHelper.dart';
import '../../shared/Style/Colors.dart';
import '../Register_Screen/RegisterScreen.dart';
//import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          uId = state.uId;
          CasheHelper.saveData(key: 'uId', value: state.uId);
          CasheHelper.saveData(key: 'token', value: 'token');
          showToAst(msg: 'Login Done Successfly', iserror: false);
          navigateAndFinish(context: context, widget: SwipScreen());
          AppCubit.get(context).getUserData();
        }
        if (state is LoginErrorState) {
          showToAst(
              msg: state.error
                  .toString()
                  .substring(30, state.error.toString().length),
              iserror: true);
        }
      },
      builder: (context, state) {
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
                          height: 450,
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
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Colors.white.withOpacity(.5),
                                    backgroundImage:
                                        AssetImage('assets/images/AppLogo.png'),
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
                                    obscureText: AppCubit.get(context)
                                        .passwordvisibility,
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
                                                .changePasswordVisibilty();
                                          },
                                          icon: AppCubit.get(context)
                                                  .passwordvisibility
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                        ),
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
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Forget PassWord?',
                                            style: TextStyle(
                                                color: Colors.deepPurple,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        // Navigator.push(context, MaterialPageRoute(builder: (Context)=>BottomNavigationScreen()));
                                        AppCubit.get(context).loginUser(
                                            email: emailController.text,
                                            password: passController.text);
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
                                        condition: state is! LoginLoadingState,
                                        builder: (context) => Text(
                                          'LOGIN',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        fallback: (context) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Don\'t have an Account?',
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
                                                        RegisterScreen()));
                                          },
                                          child: Text(
                                            'SIGNUP',
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
