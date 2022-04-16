import 'package:aigolive/config/colors.dart';
import 'package:aigolive/stores/models/storeModel.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:aigolive/stores/providers/frontStoreSessionProvider.dart';
import 'package:aigolive/stores/screens/store_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowedStoresWidgets extends StatefulWidget {
  @override
  _FollowedStoresWidgetsState createState() => _FollowedStoresWidgetsState();
}

class _FollowedStoresWidgetsState extends State<FollowedStoresWidgets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FollowedStoreProvider>(
      builder: (context, storesObject, child) {
        List<StoreModel> tempStores = [];
        var key = storesObject.key;

        var regex = new RegExp("($key)", caseSensitive: false);
        storesObject.stores.forEach((element) {
          if (regex.hasMatch(element.storeName)) {
            tempStores.add(element);
          }
        });
        // storesObject.stores.forEach((element) {
        //   if (element.isFollow == true) {
        //     tempStores.add(element);
        //   }
        // });
        // tempStores.removeWhere((item) => item.isFollow == false);

        return tempStores.isEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(height: 200, child: Text('0 result found!')),
                ],
              )
            : Column(
                children: List.generate(
                  tempStores.length,
                  (index) => GestureDetector(
                    onTap: () async {
                      await Provider.of<FrontStoreSessionProvider>(context,
                              listen: false)
                          .reset();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreDetailsScreen(
                            storeId: tempStores[index].storeID,
                            storeName: tempStores[index].storeName,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      margin: EdgeInsets.symmetric(vertical: 0.5),
                      child: ListTile(
                        leading: Container(
                          height: 45,
                          width: 45,
                          // margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(2.5),
                          decoration: new BoxDecoration(
                            border: Border.all(
                              color: MyColors().iconColor,
                              width: 2.5,
                            ),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(tempStores[index].storeLogo),
                            ),
                          ),
                          // child: Image.network(
                          //   tempStores[index].storeLogo,
                          //   // height: 30,
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        title: Text(
                          tempStores[index].storeName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          tempStores[index].totalFollowers,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: RaisedButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 2,
                          ),
                          child: Text(
                            tempStores[index].isFollow ? 'Following' : 'Follow',
                            style: TextStyle(fontSize: 12),
                          ),
                          textColor: tempStores[index].isFollow
                              ? Colors.white
                              : Colors.black,
                          color: tempStores[index].isFollow
                              ? MyColors().iconColor
                              : Colors.grey[600],
                          onPressed: () {
                            if (tempStores[index].isFollow) {
                              Provider.of<FollowedStoreProvider>(context,
                                      listen: false)
                                  .unfollowStore(tempStores[index].storeID,
                                      tempStores[index].customerID, false);
                            } else {
                              Provider.of<FollowedStoreProvider>(context,
                                      listen: false)
                                  .unfollowStore(tempStores[index].storeID,
                                      tempStores[index].customerID, true);
                            }
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              );
      },
    );

    // TODO: implement build
    // return new Container(
    //   color: MyColors().lightGrey,
    //   child: widget._followedStoresList.isEmpty
    //       ? Column(
    //           children: <Widget>[
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Container(
    //               height: 200,
    //               child: Text('0 result')
    //             ),
    //           ],
    //         )
    //       : ListView.builder(
    //     itemBuilder: (ctx, index){
    //       return Container(height: 10,color: Colors.red,);
    //     },
    //     itemCount: widget._followedStoresList.length,
    //   ),
    // );
  }
}
