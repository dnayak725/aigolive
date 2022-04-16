import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/account-setting/models/addressModel.dart';
import 'package:aigolive/account-setting/models/categoryInterestModel.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/models/productCategoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileProvider with ChangeNotifier {
  String userId = "";
  String firstName = "xx";
  String lastName = "xxxx";
  String fullName = "xx xxxx";
  String mobileNumber = "";
  String email = "";
  String photoUrl =
      "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";
  String countryId = "";
  String country = "";
  String dob = "";
  String gender = "Unknown";
  String genderShortName = "U";
  List<CategoryInterestModel> categoryInterest = [];
  List<CategoryInterestModel> allCategories = [
    CategoryInterestModel(
      text: 'text',
      value: '3',
      selected: false,
      disabled: 'disabled',
    )
  ];
  List<AddressModel> addresses = [];
  int selectedAddress = 0;

  changeSelectedAddress(addressId) {
    selectedAddress = addressId;
    notifyListeners();
  }

  fetchData(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = id;
    // print(AppConfig().apiLink + 'Customer/ListByCustomer/' + id);
    final response = await http.get(
      AppConfig().apiLink + "Customer/ListByCustomer/" + id,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    // print("LTPL: called" + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var result = json.decode(response.body);
        var data = result['data'][0];
        fullName = data['fullName'].toString();
        if (data['picture'].toString() == "")
          photoUrl =
              "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";
        else
          photoUrl = data['picture'].toString();

        mobileNumber = data['mobileNo'].toString();
        email = data['email'].toString();
        gender = data['gender'].toString();
        dob = data['dob'].toString();
        pref.setString("email", data['email'].toString());
        pref.setString("dob", data['dob'].toString());
        pref.setString("phone", data['phone'].toString());
        // print("ltpl ci:" + data['categoryInterest'].toString());
        List<CategoryInterestModel> temp = [];
        for (int i = 0; i < data['categoryInterest'].length; i++) {
          temp.add(
            CategoryInterestModel(
              text: data['categoryInterest'][i]['text'].toString(),
              value: data['categoryInterest'][i]['value'].toString(),
              selected: true,
              disabled: data['categoryInterest'][i]['disabled'].toString(),
            ),
          );
        }
        categoryInterest = temp;
        syncCategories();
        // print("//fetch addresses");
        // print(data["buyerAddress"]);
        List<AddressModel> addressesTemp = [];
        data["buyerAddress"].forEach((item) {
          // print(item);
          if (item["defaultSet"].toString() == "1") {
            selectedAddress = item["id"];
          }
          addressesTemp.add(
            AddressModel(
              item["id"].toString(),
              item["name"],
              item["phone"],
              item["address"],
              item["defaultSet"].toString(),
            ),
          );
        });
        addresses = addressesTemp;
        print("LTPL: ListByCustomer api data fetched");
        notifyListeners();
        break;

      default:
        print("LTPL:  ListByCustomer api error");
        break;
    }
    notifyListeners();
  }

  makeAddressDefault(String addressId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.put(
      ApiLinks().makeAddressDefaultApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "ID": int.parse(addressId),
        "CUST_ID": int.parse(pref.getString('user_id')),
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  deleteAddress(String addressId) async {
    final response = await http.delete(
      ApiLinks().deleteAddressApi + "/$addressId",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  updateProfile(String userId, String dob, String phone) async {
    final response = await http.put(
      AppConfig().apiLink + "Customer/PostBuyersProfile",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "ID": int.parse(userId),
        "DOB": dob,
        "mobileNo": phone,
      }),
    );
    print(userId + " " + gender);
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  updateEmail(String userId, String email) async {
    final response = await http.put(
      ApiLinks().updateProfileEmailApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "ID": int.parse(userId),
        "EMAIL": email,
      }),
    );
    print(userId + " " + gender);
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  updateGender(String gender1) async {
    final response = await http.put(
      AppConfig().apiLink + "Customer/PostBuyersProfile",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({"ID": int.parse(userId), "GENDER": gender1}),
    );
    print(userId + " " + gender);
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  updateMobileNumber(String newMobNumber) async {
    final response = await http.put(
      AppConfig().apiLink + "Customer/PostBuyersProfile",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({"ID": int.parse(userId), "mobileNo": newMobNumber}),
    );
    print(userId + " " + gender);
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  updateDOB(String newDOB) async {
    final response = await http.put(
      AppConfig().apiLink + "Customer/PostBuyersProfile",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({"ID": int.parse(userId), "DOB": newDOB}),
    );
    print(userId + " " + gender);
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  updateName(String newFName, String newLName) async {
    final response = await http.put(
      AppConfig().apiLink + "Customer/PostBuyersProfile",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "ID": int.parse(userId),
        "firstName": newFName,
        "lastName": newLName
      }),
    );
    print(userId + " " + gender);
    print(response.statusCode);
    if (response.statusCode == 200)
      print('success');
    else
      print('failure');
    fetchData(userId);
  }

  resetData() {
    userId = "";
    firstName = "xx";
    lastName = "xxxx";
    fullName = "xx xxxx";
    mobileNumber = "xxxxxxxxxx";
    email = "";
    photoUrl =
        "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";
    countryId = "";
    country = "";
    dob = "0000-00-00";
    gender = "Unknown";
    genderShortName = "U";
    categoryInterest = [];
    notifyListeners();
  }

  getAllCategories() async {
    final response = await http.get(
      ApiLinks().getAllCategoriesApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    // print("LTPL: called" + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          // status = results['status'];
          var data = results['data'];
          List<CategoryInterestModel> temp = [];
          data.forEach((item) {
            bool selected = false;
            // categoryInterest.forEach((userInterest) {
            //   if (item['value'].toString() == userInterest.value) {
            //     selected = true;
            //   }
            // });
            temp.add(
              CategoryInterestModel(
                text: item['text'].toString(),
                value: item['value'].toString(),
                selected: selected,
                disabled: item['disabled'].toString(),
              ),
            );
          });
          allCategories = temp;
        }
        print("LTPL: fetched allcategories data");
        syncCategories();
        break;

      default:
        print("LTPL: get allcategories api error");
        break;
    }
    notifyListeners();
  }

  selectAllCategories() {
    allCategories.forEach((item) {
      item.selected = true;
    });
    notifyListeners();
  }

  deselectAllCategories() {
    allCategories.forEach((item) {
      item.selected = false;
    });
    notifyListeners();
  }

  changeSelectStatus(String value1) {
    allCategories.forEach((item) {
      if (item.value == value1) {
        item.selected = !item.selected;
      }
    });
    notifyListeners();
  }

  updateCategories(context) async {
    String cats = "";
    allCategories.forEach((element) {
      if (element.selected == true) {
        cats += allCategories.indexOf(element) == 0
            ? element.value
            : "," + element.value;
      }
    });
    // print(jsonEncode({"ID": int.parse(userId), "Interests": cats}));
    final response = await http.put(
      AppConfig().apiLink + "Customer/PostBuyersProfile",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({"ID": int.parse(userId), "Interests": cats}),
    );
    print(userId + " " + gender);
    print(response.statusCode);
    if (response.statusCode == 200)
      _showAlertDialog(
          "Success!", "Your interests has been updated.", "OK", context);
    else
      _showAlertDialog(
          "Failed!",
          "Your interests couldn't updated please try again latter.",
          "OK",
          context);
    fetchData(userId);
    notifyListeners();
  }

  syncCategories() {
    allCategories.forEach((category) {
      categoryInterest.forEach((interest) {
        if (category.value == interest.value) category.selected = true;
      });
    });
  }

  _showAlertDialog(
      String alertText, String msg, String buttonText, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertText),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
