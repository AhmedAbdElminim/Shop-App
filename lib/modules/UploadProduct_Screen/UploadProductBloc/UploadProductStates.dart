abstract class UploadProductStates {}

class UploadProductInitialStates extends UploadProductStates {}

class UploadProductSelectCategoryState extends UploadProductStates {}

class UploadProductSelectBrandState extends UploadProductStates {}

class UploadProductImageSuccessesState extends UploadProductStates {}

class UploadProductRemoveImageSuccessesState extends UploadProductStates {}

class UploadNewProductSuccessesState extends UploadProductStates {}

class UploadNewProductErrorState extends UploadProductStates {
  final String error;
  UploadNewProductErrorState(this.error);
}

class UploadNewProductImageLoadingState extends UploadProductStates {}

class UploadNewProductImageSuccessesState extends UploadProductStates {}

class UploadNewProductImageErrorState extends UploadProductStates {
  final String error;
  UploadNewProductImageErrorState(this.error);
}
