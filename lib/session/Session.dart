import 'dart:io';

class Session {
  static String userId = "1";
  static String name = "Kisakye Joel Nkanji";
  static String email = "nkanjijoel@gmail.com";
  static String contact = "0708847386";
  static String lastLogin = "9th/06/2022";
  static String lastAction = "Signed In at 8:00pm";
  static String today = "";
  static String deptName = "";
  static String desName = "";
  static bool signedIn = false;
  static bool completed = false;

  static Map<String, String> dept = {
    "id": "",
    "name": "Select your department.."
  };

  static Map<String, String> des = {
    "id": "",
    "name": "Select your designation.."
  };

  static Map<String, String> gender = {"gender": "", "name": "Male"};

  static updateSession() {
    try {
      File file = new File("SessionFile.txt");
      print("Updating Session");

      _checkFileExist(file).then((value) {
        if (value == true) {
          file.writeAsString("Some data");
        } else {
          file.create().then((value) {
            print(value);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> _checkFileExist(File file) async {
    return await file.exists().then((value) => value);
  }
}
