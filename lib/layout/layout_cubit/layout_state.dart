

import 'package:smallproject/layout/user_model.dart';
import 'package:smallproject/models/products_model.dart';

abstract class LayoutStates{} 

class LayoutInitialState extends LayoutStates{}
 class ChangeButtomNavIndexState extends LayoutStates{}

class GetUserDataSuccessState extends LayoutStates{
   final UserModel usermodel;

  GetUserDataSuccessState(this.usermodel);
}
class GetUserDataLoadingState extends LayoutStates{}
class FailedToGetUserDataState extends LayoutStates{
  String error;
  FailedToGetUserDataState({required this.error});
}



class GetCategotiesSuccessState extends LayoutStates{}
class GetCategotiessLoadingState extends LayoutStates{}
class FailedToGetCategotiesState extends LayoutStates{}


class GetProductsSuccessState extends LayoutStates{}
class GetProductsLoadingState extends LayoutStates{}
class FailedToGetProductsState extends LayoutStates{}


class GetProductDetailssSuccessState extends LayoutStates{
  final ProductModel model;

  GetProductDetailssSuccessState(this.model);
}
class GetProductsDetailsLoadingState extends LayoutStates{}
class FailedToGetProductsDetailsState extends LayoutStates{}


class FilterproductSuccessState extends LayoutStates{}
class FiltercategoriesSuccessState extends LayoutStates{}


class UpDateUserDataSuccessState extends LayoutStates{
  
}
class UpDateUserDataLoadingState extends LayoutStates{}
class UpDateUserDatawithFailureState extends LayoutStates{
 String? error;

  UpDateUserDatawithFailureState(this.error);
  
}

class ChangepasswordSuccessState extends LayoutStates{
  
}
class ChangepasswordLoadingState extends LayoutStates{}
class ChangepswwordwithFailureState extends LayoutStates{
 String? error;

  ChangepswwordwithFailureState(this.error);
  
}

class GetOrderSuccessState extends LayoutStates{}
class GetOrderLoadingState extends LayoutStates{}
class FailedToGetOrderState extends LayoutStates{}