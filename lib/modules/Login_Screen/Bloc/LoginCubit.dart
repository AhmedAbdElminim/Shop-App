import 'package:e_commerce_app/modules/Login_Screen/Bloc/LoginStates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);

  bool passwordvisibility=true;
  void changePasswordVisibilty(){
    passwordvisibility=!passwordvisibility;
    emit(LoginChangePasswordVisibiltyState());
  }
void loginUser({
  required String email,
  required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(LoginSuccessState());

    })
        .catchError((error){
          emit(LoginErrorState(error.toString()));
    });
}

}*/