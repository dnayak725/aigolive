// import 'package:aigolive/account-setting/orders/models/purchases_model.dart';
// import 'package:aigolive/account-setting/orders/screens/order_details_screen.dart';
// import 'package:aigolive/config/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CancellationsWidget extends StatefulWidget {
//   //variables and functions
//   final List<PurchasesModel> purchaseList;
//   final Function cancelOrder;

//   //constructor
//   const CancellationsWidget(this.purchaseList, this.cancelOrder);

//   @override
//   _CancellationsWidgetState createState() => _CancellationsWidgetState();
// }

// class _CancellationsWidgetState extends State<CancellationsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Container(
//       color: MyColors().lightGrey,
//       child: widget.purchaseList.isEmpty
//           ? Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   height: 200,
//                   child: Image.asset(
//                     'assets/images/empty-order.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             )
//           : ListView.builder(
//               itemBuilder: (ctx, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => OrderDetailsScreen("2")),
//                     );
//                   },
//                   child: Container(
//                     color: Colors.white,
//                     margin: EdgeInsets.symmetric(
//                       vertical: 8,
//                       horizontal: 0,
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           // color: Colors.grey,
//                           child: ListTile(
//                             title: Row(
//                               children: [
//                                 Text(
//                                   "Order Number #" +
//                                       widget.purchaseList[index].orderId
//                                           .toString() +
//                                       "  ",
//                                   // style: Theme.of(context).textTheme.title,
//                                 ),
//                                 Icon(
//                                   Icons.chevron_right_sharp,
//                                   color: Colors.grey,
//                                 ),
//                               ],
//                             ),
//                             subtitle: Text(
//                               "Paid on  18 August 2020 22:30:30",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         Center(
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 _getItem(),
//                                 SizedBox(
//                                   height: 15,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               itemCount: widget.purchaseList.length,
//             ),
//     );
//   }

//   Widget _getItem() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(horizontal: 15.0),
//       // margin: EdgeInsets.only(top: 3.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: EdgeInsets.only(right: 8),
//             padding: EdgeInsets.all(2),
//             decoration: new BoxDecoration(
//               shape: BoxShape.rectangle,
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 1,
//               ),
//             ),
//             child: Container(
//               width: 60.0,
//               height: 60.0,
//               decoration: new BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 image: new DecorationImage(
//                   image: NetworkImage(
//                       'https://5.imimg.com/data5/VB/HN/GLADMIN-12117779/samsung-washing-machine-wt655qpndrp-500x500.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width - 115,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Lorem ipsum dolor sit amet,'),
//                     Text('\$233.00'),
//                   ],
//                 ),
//                 Text(
//                   "x 2",
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(child: Text('Reason of cancel order:')),
//                         Container(
//                             width: MediaQuery.of(context).size.width * 0.4,
//                             child: Text(
//                               'Purchased item by mistake or changed mind',
//                               style: TextStyle(fontSize: 12),
//                             )),
//                       ],
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//                       decoration: new BoxDecoration(
//                         borderRadius: BorderRadius.circular(30.0),
//                         border: Border.all(
//                           color: MyColors().orderCancelButtonColor,
//                           width: 1.5,
//                         ),
//                       ),
//                       child: Text(
//                         'Cancelled',
//                         style:
//                             TextStyle(color: MyColors().orderCancelButtonColor),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text('Total:  '),
//                     Text(
//                       "\$466.00",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
