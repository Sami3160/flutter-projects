// late initilization of non-nullable members/ initilize after calculation

class ResetPassword {

  // final String username;
  // final String newPassword;
  final String username;
  final String newPassword;

  ResetPassword.reset(this.username, this.newPassword);   //ptivate constructor

  factory ResetPassword(String username) {

    //first a value is calculated
    String password = generateRandomPassword();

    // and then object is created
    return ResetPassword.reset(username, password);
  }

  static String generateRandomPassword() {
    return 'Yo9Rtj3K';
  }

}

//not exactly a lazy iintilization

void main() {
  ResetPassword r1= ResetPassword("sami");
  print(r1.username);
  print(r1.newPassword);
}

// The fields username and newPassword are not initialized immediately at class load time —
// they are initialized after some logic is executed.




// So What Is This Pattern Solving?
//    Fields are non-nullable
//    They must be initialized
//    But their values require calculation first