import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/stores/models/product_model.dart';
import 'package:aigolive/stores/models/storeSessionModel.dart';
import 'package:aigolive/stores/providers/frontStoreSessionProvider.dart';
import 'package:aigolive/stores/widgets/storeProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllStoreProducts extends StatefulWidget {
  @override
  _AllStoreProductsState createState() => _AllStoreProductsState();
}

class _AllStoreProductsState extends State<AllStoreProducts> {
  List<String> productFilters = ["Popular", "Recent", "Price"];

  @override
  void initState() {
    super.initState();
    Provider.of<FrontStoreSessionProvider>(context, listen: false).priceOrder =
        "ASC";
    Provider.of<FrontStoreSessionProvider>(context, listen: false)
        .activeProductFilterIndex = 0;
    Provider.of<FrontStoreSessionProvider>(context, listen: false)
        .activeSessionFilterIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: AppBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [MyColors().blueDark, MyColors().blueLight],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        elevation: 0,
        title: SearchBar(
          isSearchIcon: false,
          isbackNav: false,
        ),
      ),
      body: Consumer<FrontStoreSessionProvider>(
        builder: (context, storeSessionProvider, child) {
          StoreSession storeSessionResult =
              storeSessionProvider.storeSessionData;
          int fetchStatus = storeSessionProvider.fetchStatus;
          List<ProductModel> productList =
              storeSessionResult.storefrontProductList;
          int activeFilterIndex = storeSessionProvider.activeProductFilterIndex;
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: List.generate(
                        productFilters.length,
                        (i) => Expanded(
                          child: GestureDetector(
                            onTap: () {
                              storeSessionProvider.filterProducts(
                                  productFilters[i], i);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey[400],
                                  ),
                                  bottom: BorderSide(
                                    color: i == activeFilterIndex
                                        ? MyColors().iconColor
                                        : Colors.grey[400],
                                    width: i == activeFilterIndex ? 2.0 : 1.0,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${productFilters[i]}',
                                    textAlign: TextAlign.center,
                                  ),
                                  productFilters[i] == "Price"
                                      ? Icon(
                                          storeSessionProvider.priceOrder ==
                                                  "ASC"
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_up,
                                          size: 15,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.84,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return StoreProductWidget(
                          storeDetails: storeSessionResult,
                          productDetails: productList[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
