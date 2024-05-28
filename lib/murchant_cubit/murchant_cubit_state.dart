abstract class MerchantStates{}

class MerchantInitialState extends MerchantStates{} 


class SignUpLoadingState extends MerchantStates{} 
class SignUpSuccessState extends MerchantStates{} 
class FailedToSignUpState extends MerchantStates{
   String message;
  FailedToSignUpState({required this.message});

} 


class LogoutLoadingState extends MerchantStates{} 
class LogoutSuccessState extends MerchantStates{} 
class FailedToLogoutState extends MerchantStates{
 
}


class SignInLoadingState extends MerchantStates{} 
class SignInSuccessState extends MerchantStates{} 
class FailedToSigInState extends MerchantStates{
   final String message;
  FailedToSigInState({required this.message});
}