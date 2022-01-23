


abstract class RegisterStates {} 

class RegisterIntialStates extends RegisterStates {} 

class RegisterLoadingStates extends RegisterStates {} 

class RegisterSuccessStates extends RegisterStates
{
  // final LoginModel loginModel;

  // RegisterSuccessStates(this.loginModel);
} 

class RegisterErrorStates extends RegisterStates {

  final String error;

  RegisterErrorStates(this.error);
  } 

  

class CreateUserSuccessStates extends RegisterStates{} 

class CreateUserErrorStates extends RegisterStates {

  final String error;

  CreateUserErrorStates(this.error);
  } 

  class RegisterChangePasswordVisibilityStates extends RegisterStates {} 