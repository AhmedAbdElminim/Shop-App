abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeThemeState extends AppStates {}

class AppChangeDotsOfCarousalState extends AppStates {}

class AppChangePostionOfFlaotingActionButton extends AppStates {}

class AppAddInCartSuccessState extends AppStates {}

class AppClearInCartList extends AppStates {}

class AppSignOutSuccessState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;
  AppGetUserErrorState(this.error);
}

//----------------------------------------------------------//
//Login States
class LoginChangePasswordVisibiltyState extends AppStates {}

class LoginSuccessState extends AppStates {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginLoadingState extends AppStates {}

class LoginErrorState extends AppStates {
  final String error;
  LoginErrorState(this.error);
}

//--------------------------------------------------------//
// Register States
class RegisterPickedImageSuccessState extends AppStates {}

class RegisterPickedImageErrorState extends AppStates {}

class RegisterRemoveUserImageSuccessState extends AppStates {}

class RegisterShowDialogImageSuccessState extends AppStates {}

class RegisterCreateUserSuccessState extends AppStates {}

class RegisterCreateUserErrorState extends AppStates {}

class RegisterUserLoadingState extends AppStates {}

class RegisterUserSuccessState extends AppStates {
  final String uId;
  RegisterUserSuccessState(this.uId);
}

class RegisterUserErrorState extends AppStates {
  final String error;
  RegisterUserErrorState(this.error);
}

class RegisterSecurePasswordState extends AppStates {}

class RegisterUploadImageSuccessState extends AppStates {}

class RegisterUploadImageLoadingState extends AppStates {}

class RegisterUploadImageErrorState extends AppStates {
  final String error;
  RegisterUploadImageErrorState(this.error);
}

//--------------------------------------------------------------------------------------//
//states for get all products
class GetAllProductsLoadingState extends AppStates {}

class GetAllProductsSuccessState extends AppStates {}

class GetAllProductsErrorState extends AppStates {
  final String error;
  GetAllProductsErrorState(this.error);
}

//--------------------------------------------------------------------------------------//
//in cart logic states
class RemoveSelectedItemFromCartSuccessState extends AppStates {}

class SetelctTheNumberOfItemInEachProductInCartSuccessState extends AppStates {}

//--------------------------------------------------------------------------------------//
//in Wish logic states
class AppClearInWishList extends AppStates {}

//--------------------------------------------------------------------------------------//
//Search states
class SearchInProductsLoadingState extends AppStates {}

class SearchInProductsSuccessState extends AppStates {}
