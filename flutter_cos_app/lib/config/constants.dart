class AppConstants {
  static const String welcome = "Welcome";
  static const String signInContinue = "Sign in to continue!";
  static const String signUpContinue = "Register & get started!";
  static const String emailId = "Email ID";
  static const String password = "Password";
  static const String newPswd = "New Password";
  static const String confirmPswd = "Confirm Password";
  static const String login = "Login";
  static const String newUser = "I'm a new user, ";
  static const String signUp = "Sign Up";
  static const String home = "Home";
  static const String hello = "Hello";
  static const String loginWith = "or sign in with";
  static const String inProgressMessage = "Hi, this feature will soon provided";
  static const String emailRequired = "Email is required";
  static const String passwordRequired = "Password is required";
  static const String confirmPasswordRequired = "Confirm Password is required";
  static const String emailInvalid = "Invalid Email";
  static const String passwordInvalid = "Invalid Password";
  static const String passwordNotMatch = "Passwords do not match";
  static const String yes = "Yes";
  static const String no = "No";
  static const String logout = "Logout";
  static const String logoutMsg = "Are you sure you want to logout?";
  static const String vehicleList = "Inspected Vehicles";
  static const String addInspection = "New Inspection";
  static const String cosInspection = "CoS Inspection";
  static const String vId = "Vehicle ID";
  static const String vDate = "Inspection Date";
  static const String vModel = "Vehicle Model";
  static const String vMake = "Vehicle Make";
  static const String vsubmit = "Submit";
  static const String submit = "Submit";
  static const String userProfile = "User Profile";
  static const String changeProfile = "Change Profile";
  static const String changePassword = "Change Password";
  static const String changePasswordMesg = "Enter your new Password";
  static const String vehicleListError = "Oops! Failed to Fetch Vehicle";
  static const String idInvalid = "Inavlid Vehicle ID";
  static const String idRequired = "Vehicle Id is required";
  static const String dateRequired = "Vehicle Date is required";
  static const String vehiclePhotoText = "Upload Vehicle Photo";
  static const String userNotFound = "User not found. Please register";
  static const String wrongPassword =
      "User id or Password is invalid. Please try again";
  static const String signInCancel = "User has concelled sign in flow";
  static const String somethingWentWrong =
      "Something went wrong. Please try again";
  static const String userAlreadyExist =
      "Email already exist. Please register with new email";

  static const String correctInfo = "Please enter correct information";
  static const String unableToChangePswd =
      "Unable to change password. Please try again";
  static const String changePswdSuccess =
      "Password changed successfully. Please login with new password";
  static const String takePhoto = "Take a photo";
  static const String chooseGallery = "Choose from gallery";
  static const String loginInfo = "Please enter login information";
  static const String signUpInfo = "Please enter signup information'";
  static const String vehiclInfo = "Please enter vehicle information";
  static const String vehiclInfoNotSaved =
      "Vehicle information not saved. Please try again";
}

class AssetsConstants {
  static const String googleLogin = "assets/icons/google.png";
}

class FieldsRegExp {
  static final passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
}
