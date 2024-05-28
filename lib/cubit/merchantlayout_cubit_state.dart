part of 'merchantlayout_cubit_cubit.dart';

abstract class MerchantlayoutCubitState {}

class MerchantlayoutCubitInitial extends MerchantlayoutCubitState {}

 class ChangeButtomNavIndexState extends MerchantlayoutCubitState{}

class GetMerchantDataSuccessState extends MerchantlayoutCubitState{
   final MerchantModel merchant;

  GetMerchantDataSuccessState(this.merchant);
}
class GetMerchantDataLoadingState extends MerchantlayoutCubitState{}
class FailedToGetMerchantDataState extends MerchantlayoutCubitState{
  String error;
  FailedToGetMerchantDataState({required this.error});
}



class GetProductsSuccessState extends MerchantlayoutCubitState{

  final List<merchantproduct> products;

  GetProductsSuccessState(this.products);
}
class GetProductsLoadingState extends MerchantlayoutCubitState{}
class FailedToGetProductsState extends MerchantlayoutCubitState{}




class FilterproductSuccessState extends MerchantlayoutCubitState{}
class FiltercategoriesSuccessState extends MerchantlayoutCubitState{}


class addProductsSuccessState extends MerchantlayoutCubitState{}
class addProductsLoadingState extends MerchantlayoutCubitState{}
class FailedToaddProductsState extends MerchantlayoutCubitState{
     final String message;
  FailedToaddProductsState({required this.message});
}


class UpDateMerchantDataSuccessState extends MerchantlayoutCubitState{
  
}
class UpDateMerchantDataLoadingState extends MerchantlayoutCubitState{}
class UpDateMerchantDatawithFailureState extends MerchantlayoutCubitState{
 String? error;

  UpDateMerchantDatawithFailureState(this.error);
  
}


class ChangepasswordSuccessState extends MerchantlayoutCubitState{
  
}
class ChangepasswordLoadingState extends MerchantlayoutCubitState{}
class ChangepswwordwithFailureState extends MerchantlayoutCubitState{
 String? error;

  ChangepswwordwithFailureState(this.error);
  
}

class GetProductsDetailssSuccessState extends MerchantlayoutCubitState{
  final merchantproduct model;

  GetProductsDetailssSuccessState(this.model);
}
class GetProductsDetailsLoadingState extends MerchantlayoutCubitState{}
class FailedToGetProductsDetailsState extends MerchantlayoutCubitState{}

class ProductsLoadingDeleted extends MerchantlayoutCubitState {}
class ProductsDeleted extends MerchantlayoutCubitState {
  
 
}
class FailedToDeletedProductState extends MerchantlayoutCubitState {
  final String errorMessage;

  FailedToDeletedProductState(this.errorMessage);
}

class UpDateProductDataSuccessState extends MerchantlayoutCubitState{
  final merchantproduct model;

  UpDateProductDataSuccessState(this.model);
  
}
class UpDateProductDataLoadingState extends MerchantlayoutCubitState{}
class UpDateProductDatawithFailureState extends MerchantlayoutCubitState{
 String? error;

  UpDateProductDatawithFailureState(this.error);
  
}


class GetOrdersSuccessState extends MerchantlayoutCubitState{

  final List<Order> orders;

  GetOrdersSuccessState(this.orders);
}
class GetOrdersLoadingState extends MerchantlayoutCubitState{}
class FailedToGetOrdersState extends MerchantlayoutCubitState{}