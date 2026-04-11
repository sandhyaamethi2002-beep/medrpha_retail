import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var firmId = 0.obs;
  var userId = 0.obs;
  var roleId = 0.obs;
  var userTypeId = 1.obs;
  var adminId = 0.obs;
  var mobileNo = "".obs;
  var address = "".obs;
  var firmName = "".obs;
  var drugLicence = 0.obs;
  var status = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }


  Future<void> saveUser(Map<String, dynamic> data) async {

    print("SAVE USER DATA => $data");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    firmId.value = data['firmId'] ?? 0;
    adminId.value = data['adminId'] ?? 0;
    drugLicence.value = data['hdnDrugsyesno'] ?? 0;
    status.value = data['status'] ?? 0;
    userTypeId.value = 1;

    mobileNo.value = data['phoneNo'] ?? data['personNumber'] ?? "";
    address.value = data['address'] ?? "";
    firmName.value = data['firmName'] ?? "";

    await prefs.setInt('firmId', firmId.value);
    await prefs.setInt('adminId', adminId.value);
    await prefs.setInt('userTypeId', userTypeId.value);

    await prefs.setString('phoneNo', mobileNo.value);
    await prefs.setString('address', address.value);
    await prefs.setString('firmName', firmName.value);
    await prefs.setInt('hdnDrugsyesno', drugLicence.value);
    await prefs.setInt('status', status.value);

    update();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    firmId.value = prefs.getInt('firmId') ?? 0;
    adminId.value = prefs.getInt('adminId') ?? 0;
    userTypeId.value = 1;
    mobileNo.value = prefs.getString('phoneNo') ?? "";
    address.value = prefs.getString('address') ?? "";
    firmName.value = prefs.getString('firmName') ?? "";
    drugLicence.value = prefs.getInt('hdnDrugsyesno') ?? 0;
    status.value = prefs.getInt('status') ?? 0;

    update();

    print("DATA LOADED => UserTypeId: ${userTypeId.value}");
    print("DATA LOADED => drugLicence: ${drugLicence.value}");
    print("DATA LOADED => status: ${status.value}");

  }

  // LOGOUT

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    firmId.value = 0;
    adminId.value = 0;
    userTypeId.value = 0;
    mobileNo.value = "";
    address.value = "";
    firmName.value = "";

    update();
    print(" User Logged Out & Controller Cleared");
  }
}
