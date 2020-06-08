import 'package:flutter/material.dart';
import 'package:management/Goods/AddGoodMain.dart';
import 'package:management/UI/InventoryConfirmation.dart';
import 'package:management/UI/InventoryRequest.dart';
import 'package:management/UI/IssuetoStore.dart';
import 'package:management/UI/store-stock-balance.dart';
import 'Stock/StockList.dart';
import 'UI/VendorBalance.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 14.0, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    // final userThumbnail = new Container(
    //   margin: EdgeInsets.symmetric(vertical: 16.0),
    //   alignment: FractionalOffset.centerLeft,
    //   child: Image(
    //     image: new AssetImage("assets/goodsicon.png"),
    //   ),
    // );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: 120.0,
                  color: Colors.cyan,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            print("onTap Goods.");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StockList()));
                          },
                          child: Image(
                            height: 55,
                            fit: BoxFit.fill,
                            image: AssetImage("assets/goodsicon.png"),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Stock Entry", style: style)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: 120.0,
                  color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IssuetoStore()));
                            print("onTap Goods.");
                          },
                          child: Image(
                            height: 55,
                            fit: BoxFit.fill,
                            image: AssetImage("assets/doc.png"),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Store Transfers",
                        style: style,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: 120.0,
                  color: Colors.orange,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        InventoryConfirmation()));
                            print("onTap Goods.");
                          },
                          child: Image(
                            height: 50,
                            fit: BoxFit.fill,
                            image: AssetImage("assets/bill.png"),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Inventory Confirmation",
                          style: style, textAlign: TextAlign.center)
                    ],
                  ),
                )
              ],
            )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15.0),
                      width: 120.0,
                      color: Colors.blueAccent,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InventoryRequest()));
                                print("onTap Goods.");
                              },
                              child: Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/report.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Inventory Request",
                              style: style, textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      width: 120.0,
                      color: Colors.brown,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddGoodMain()));
                                print("onTap Goods.");
                              },
                              child: Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/doc.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Purchase Entry",
                              style: style, textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: 120.0,
                      color: Colors.deepPurple,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                print("onTap Goods.");
                              },
                              child: Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/negative-goods.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Good Out", style: style)
                        ],
                      ),
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: 120.0,
                      color: Colors.green,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                print("onTap Goods.");
                              },
                              child: Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/user.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Supplier", style: style)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: 120.0,
                      color: Colors.orangeAccent,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                print("onTap Goods.");
                              },
                              child: Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/stickman.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Customer", style: style)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: 120.0,
                      color: Colors.teal,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                print("onTap Goods.");
                              },
                              child: Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/gear.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Settings", style: style)
                        ],
                      ),
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16.0),
                      width: 120.0,
                      color: Colors.cyan,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                print("onTap Goods.");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoreStockBalance()));
                              },
                              child: Image(
                                height: 55,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/goodsicon.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Store Stock Balance", style: style)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: 120.0,
                      color: Colors.green,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                print("onTap Goods.");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => VendorBalance())));
                              },
                              child: Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: AssetImage("assets/bill.png"),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Vendor Balance", style: style)
                        ],

                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
