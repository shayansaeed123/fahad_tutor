import 'dart:core';

import 'package:get_storage/get_storage.dart';

class MySharedPrefrence {
  static var preferences;

  static MySharedPrefrence? _instance;

  MySharedPrefrence._() {
    preferences = () => GetStorage('MyPref');
  }

  factory MySharedPrefrence() {
    _instance ??= new MySharedPrefrence._();
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }

  bool getUserLoginStatus() {
    return false.val('user_login_status', getBox: preferences).val;
  }

  void setUserLoginStatus(bool? alarmStatus) {
    false.val('user_login_status', getBox: preferences).val =
        alarmStatus ?? false;
  }




  String get_user_loginstatus() {
    return ''.val('login_status', getBox: preferences).val;
  }

  void set_user_loginstatus(String? login_status) {
    ''.val('login_status', getBox: preferences).val = login_status ?? '';
  }


  String get_info() {
    return ''.val('info', getBox: preferences).val;
  }

  void set_info(String? info) {
    ''.val('info', getBox: preferences).val = info ?? '';
  }

void set_user_ID(String? userID) {
    ''.val('userID', getBox: preferences).val = userID ?? '';
  }

  String get_user_ID() {
    return ''.val('userID', getBox: preferences).val;
  }

  void set_tutor_name(String? tutorName) {
    ''.val('tutorName', getBox: preferences).val = tutorName ?? '';
  }

  String get_tutor_name() {
    return ''.val('tutorName', getBox: preferences).val;
  }



  void set_user_token(String? user_token) {
    ''.val('user_token', getBox: preferences).val = user_token ?? '';
  }

  String get_user_status1() {
    return '0'.val('status1', getBox: preferences).val;
  }
  void set_user_status1(String? user_token) {
    '0'.val('status1', getBox: preferences).val = user_token ?? '0';
  }

  String get_user_token() {
    return ''.val('user_token', getBox: preferences).val;
  }

  void set_shop_name(String? shop_name) {
    ''.val('shop_name', getBox: preferences).val = shop_name ?? '';
  }

  String get_shop_name() {
    return ''.val('shop_name', getBox: preferences).val;
  }

  void set_user_email(String? user_name) {
    ''.val('user_email', getBox: preferences).val = user_name ?? '';
  }

  String get_user_email() {
    return ''.val('user_email', getBox: preferences).val;
  }

  void set_user_number(String? user_name) {
    ''.val('user_number', getBox: preferences).val = user_name ?? '';
  }

  String get_user_number() {
    return ''.val('user_number', getBox: preferences).val;
  }

  void set_user_id(String? user_id) {
    ''.val('user_id', getBox: preferences).val = user_id ?? '';
  }

  String get_user_id() {
    return ''.val('user_id', getBox: preferences).val;
  }

  void set_user_type(String? user_type) {
    ''.val('user_type', getBox: preferences).val = user_type ?? '';
  }

  String get_user_type() {
    return ''.val('user_type', getBox: preferences).val;
  }

  void set_share_date(String? share_date) {
    ''.val('share_date', getBox: preferences).val = share_date ?? '';
  }

  String get_share_date() {
    return ''.val('share_date', getBox: preferences).val;
  }


  void set_tuition_name(String? tuition_name) {
    ''.val('tuition_name', getBox: preferences).val = tuition_name ?? '';
  }

  String get_tuition_name() {
    return ''.val('tuition_name', getBox: preferences).val;
  }

  void set_class_name(String? class_name) {
    ''.val('class_name', getBox: preferences).val = class_name ?? '';
  }

  String get_class_name() {
    return ''.val('class_name', getBox: preferences).val;
  }

  void set_subject(String? subject) {
    ''.val('subject', getBox: preferences).val = subject ?? '';
  }

  String get_subject() {
    return ''.val('subject', getBox: preferences).val;
  }

  void set_Placement(String? Placement) {
    ''.val('Placement', getBox: preferences).val = Placement ?? '';
  }

  String get_Placement() {
    return ''.val('Placement', getBox: preferences).val;
  }

  void set_location(String? location) {
    ''.val('location', getBox: preferences).val = location ?? '';
  }

  String get_location() {
    return ''.val('location', getBox: preferences).val;
  }

  void set_limit(String? limit) {
    ''.val('limit', getBox: preferences).val = limit ?? '';
  }

  String get_limit() {
    return ''.val('limit', getBox: preferences).val;
  }

  void set_remarks(String? remarks) {
    ''.val('remarks', getBox: preferences).val = remarks ?? '';
  }

  String get_remarks() {
    return ''.val('remarks', getBox: preferences).val;
  }

  void set_tutor_id(String? tutor_id) {
    ''.val('tutor_id', getBox: preferences).val = tutor_id ?? '';
  }

  String get_tutor_id() {
    return ''.val('tutor_id', getBox: preferences).val;
  }

  // Future<void> setVersionName() async {
  //   await PackageInfo.fromPlatform().then((PackageInfo? packageInfo) {
  //     String? version = packageInfo?.version;
  //     ''.val('versionName', getBox: preferences).val = version ?? '';
  //   });
  // }

  String getVersionName() {
    return ''.val('versionName', getBox: preferences).val;
  }

  void setUserCurrentLocation(String? userCurrentLocation) {
    ''.val('user_current_location', getBox: preferences).val =
        userCurrentLocation ?? '';
  }

  String getUserCurrentLocation() {
    return ''.val('user_current_location', getBox: preferences).val;
  }

  void set_user_name(String? user_name) {
    ''.val('user_name', getBox: preferences).val = user_name ?? '';
  }

  String get_user_name() {
    return ''.val('user_name', getBox: preferences).val;
  }

  void set_user_cnic(String? user_cnic) {
    ''.val('user_cnic', getBox: preferences).val = user_cnic ?? '';
  }

  String get_user_cnic() {
    return ''.val('user_cnic', getBox: preferences).val;
  }

  void set_user_designation(String? user_designation) {
    ''.val('user_designation', getBox: preferences).val =
        user_designation ?? '';
  }


 String get_user_image() {
    return ''.val('image', getBox: preferences).val;
  }

  void set_user_image(String? user_image) {
    ''.val('image', getBox: preferences).val =
        user_image ?? '';
  }
  
  String get_user_designation() {
    return ''.val('user_designation', getBox: preferences).val;
  }

  void setUserCurrentAddressId(int? userCurrentAddressId) {
    0.val('user_current_address_id', getBox: preferences).val =
        userCurrentAddressId ?? 0;
  }

  int getUserCurrentAddressId() {
    return 0.val('user_current_address_id', getBox: preferences).val;
  }

  void setUserLastAddressId(int? userLastAddressId) {
    0.val('user_last_address_id', getBox: preferences).val =
        userLastAddressId ?? 0;
  }

  int getUserLastAddressId() {
    return 0.val('user_last_address_id', getBox: preferences).val;
  }

  String getUserCurrentLocationLatitude() {
    return ''.val('user_current_location_latitude', getBox: preferences).val;
  }

  void setUserCurrentLocationLatitude(String? userCurrentLocation) {
    ''.val('user_current_location_latitude', getBox: preferences).val =
        userCurrentLocation ?? '';
  }

  String getUserCurrentLocationLongitude() {
    return ''.val('user_current_location_longitude', getBox: preferences).val;
  }

  void setUserCurrentLocationLongitude(String? userCurrentLocation) {
    ''.val('user_current_location_longitude', getBox: preferences).val =
        userCurrentLocation ?? '';
  }

  void setUserOldLocation(String? userCurrentLocation) {
    ''.val('user_Old_location', getBox: preferences).val =
        userCurrentLocation ?? '';
  }

  String getUserOldLocation() {
    return ''.val('user_Old_location', getBox: preferences).val;
  }

  String getUserOldLocationLatitude() {
    return ''.val('user_Old_location_latitude', getBox: preferences).val;
  }

  void setUserOldLocationLatitude(String? userCurrentLocation) {
    ''.val('user_Old_location_latitude', getBox: preferences).val =
        userCurrentLocation ?? '';
  }

  String getUserOldLocationLongitude() {
    return ''.val('user_Old_location_longitude', getBox: preferences).val;
  }

  void setUserOldLocationLongitude(String? userCurrentLocation) {
    ''.val('user_Old_location_longitude', getBox: preferences).val =
        userCurrentLocation ?? '';
  }

  void setDistributorName(String? outletAddress) {
    ''.val('distributor_name', getBox: preferences).val = outletAddress ?? '';
  }

  String getDistributorName() {
    return ''.val('distributor_name', getBox: preferences).val;
  }


  void setname(String? name) {
    ''.val('name', getBox: preferences).val = name ?? '';
  }

  String getname() {
    return ''.val('name', getBox: preferences).val;
  }






  void set_store_distributor_id(int? user_id) {
    0.val('store_distributor_id', getBox: preferences).val = user_id ?? 0;
  }

  int get_store_distributor_id() {
    return 0.val('store_distributor_id', getBox: preferences).val;
  }

  void set_user_cafe_id(int? user_id) {
    0.val('user_cafe_id', getBox: preferences).val = user_id ?? 0;
  }

  int get_user_cafe_id() {
    return 0.val('user_cafe_id', getBox: preferences).val;
  }

  void set_user_company_id(String? user_id) {
    ''.val('user_company_id', getBox: preferences).val = user_id ?? '';
  }

  String get_user_company_id() {
    return ''.val('user_company_id', getBox: preferences).val;
  }

  void set_store_distributor_deliveryCharges(int? user_id) {
    0.val('store_distributor_deliveryCharges', getBox: preferences).val =
        user_id ?? 0;
  }

  int get_store_distributor_deliveryCharges() {
    return 0.val('store_distributor_deliveryCharges', getBox: preferences).val;
  }

  void set_login_code(String? login_code) {
    ''.val('login_code', getBox: preferences).val =
        login_code ?? '';
  }

  String get_login_code() {
    return ''.val('login_code', getBox: preferences).val;
  }

  void logout() {
    preferences().erase();
  }
}
