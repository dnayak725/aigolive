import 'package:aigolive/landing/marketPlace/models/MKProductModel.dart';
import 'package:flutter/material.dart';

class WeeklyDealsProvider with ChangeNotifier {
  List<MKProductModel> weeklyDealsProductList = [];
  String listFetchingStatus = "fetching";

  void setWeeklyDealsProductList(List<MKProductModel> list){
    if(list.length>0){
        weeklyDealsProductList = list;
    }else{
      weeklyDealsProductList = [];
    }
    notifyListeners();
  }

  // fetchData() async {
  //   final response = await http.get(
  //     AppConfig().apiLink + "Customer/GetOnAirStream",
  //     headers: {
  //       "Content-Type": "application/json",
  //       "ApiKey": AppConfig().apiKey,
  //     },
  //   );
  //   print("LTPL: called" + response.statusCode.toString());
  //   switch (response.statusCode) {
  //     case 200:
  //       var results = json.decode(response.body);
  //       if (results['status'] == "success") {
  //         listFetchingStatus = results['status'];
  //         var data = results['data'];
  //         List<MKProductModel> temp = [];
  //         data.forEach((item) {
  //           temp.add(MKProductModel(
  //               123,
  //               "productName",
  //               "https://i.pinimg.com/564x/86/bd/04/86bd041a0db5a959d3b7e07609e93707.jpg",
  //               1000,
  //               1200,
  //               1,
  //               ["blue"],
  //               ["M", "L"]));
  //         });
  //         streamList = temp;
  //       }
  //       print("LTPL: GetOnAirStream api data fetched");
  //       break;
  //
  //     default:
  //       print("LTPL: GetOnAirStream api error");
  //       break;
  //   }
  //   notifyListeners();
  // }
}
