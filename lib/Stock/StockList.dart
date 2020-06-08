import 'package:flutter/material.dart';
import 'AddStockItem.dart';
import 'package:management/network/api_service.dart';
import 'package:provider/provider.dart';
import 'package:management/network/model/stock_model.dart';
import 'package:management/Stock/EditStockItem.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:flutter/src/material/refresh_indicator.dart';

class StockRowData {
  int Id;
  String Qty;
  String Article;
//  int StockBal;
  String Barcode;
  String ItemDesc;
  String StyleNo;
  String Color;
  String Size;
  double CostPerPrice;
  String GroupName;
  String Category;
  String Subcategory;
  double RetailPrice;
  double Margin;
  double VAT;
  double SAT;
  double Discount;
  String BrandStyleCode;
  String CreatedOn;
  bool Status;
  int CatId;
  int GroupId;
  int SubGroupId;

  StockRowData(
      {this.Id,
      this.Qty,
      this.Article,
//        this.StockBal,
      this.Barcode,
      this.ItemDesc,
      this.StyleNo,
      this.Color,
      this.Size,
      this.CostPerPrice,
      this.GroupName,
      this.Category,
      this.Subcategory,
      this.RetailPrice,
      this.Margin,
      this.VAT,
      this.SAT,
      this.Discount,
      this.BrandStyleCode,
      this.CreatedOn,
      this.Status,
      this.CatId,
      this.GroupId,
      this.SubGroupId});
}

class StockList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StockListState();
  }
}

class StockListState extends State<StockList> {
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

  // void _onRefresh() async {
  //   return _refreshController.refreshCompleted();
  // }

  bool isLoader = false;

  List<StockListData> stockList = <StockListData>[];

  List<StockListData> searchStockList = <StockListData>[];

  Future<List> loadStockItemList() async {
    isLoader = true;
    final api = Provider.of<ApiService>(context, listen: false);
    return await api.getStockList(
            0, 0, 0, 0, "", "", "", "", "", 0, 0, 0, 0, 0, 0, "", "", "", "", 4).then((result) {
      isLoader = false;
      setState(() {
        searchStockList = result.stockData;
        stockList = result.stockData;
      });
    }).catchError((error) {
      isLoader = false;
      print(error);
    });
  }

  TextEditingController searchController = TextEditingController();

  onSearchTextChanged(String value) {
    if (this.stockList.length > 0) {
      setState(() {
        this.stockList = [];
      });
    }

    for (var i = 0; i <= this.searchStockList.length; i++) {
      if (this.searchStockList[i].Article.contains(value)) {
        setState(() {
          this.stockList.add(this.searchStockList[i]);
        });
      }
    }
  }

  onEdit(id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => new EditStockItem(id)));
  }

  @override
  void initState() {
    super.initState();
    this.loadStockItemList();

    print(NavigationToolbar.kMiddleSpacing);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);
    final emailField = TextField(
      controller: searchController,
      onChanged: onSearchTextChanged,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        filled: true,
        fillColor: Colors.white,
        hintText: "Search Article",
        // icon: Icon(Icons.clear, color: Colors.deepOrange),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    return
        // WillPopScope(
        // onWillPop: loadStockItemList,
        // () {
        //   // loadStockItemList();
        //   return new Future.value(true);
        // },
        Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context, "From BackButton");
            }),
        title: Text("Stock"),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            height: 35.0,
            width: double.infinity,
            color: Colors.teal,
            child: Center(child: Text("Stock Item List", style: style)),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: emailField,
          ),
          stockList.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: stockList.length,
                    itemBuilder: _buildRow,
                  ),
                  // onRefresh: loadStockItemList,
                )
              : isLoader == true
                  ? Container(
                      margin: const EdgeInsets.all(180.0),
                      child: Center(child: CircularProgressIndicator()))
                  : Container(
                      margin: const EdgeInsets.all(170.0),
                      // child: Center(
                      // width: 180.0,
                      child: Text("No Data"),
                      // )
                    ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddStockItem()));
          },
          child: Icon(Icons.add)),
      // )
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    return Card(
        child: InkWell(
      onTap: () => onEdit(stockList[index].Id),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(7.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('Article : ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      child: Text('Style No : ',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      child: Text("Group : ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      child: Text("Size : ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      child: Text("Quantity : ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
          ),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(stockList[index].Article != null
                        ? stockList[index].Article
                        : ''),
                  ),
                  Container(
                    child: Text(stockList[index].StyleNo != null
                        ? stockList[index].StyleNo
                        : ''),
                  ),
                  Container(
                    child: Text(stockList[index].GroupName != null
                        ? stockList[index].GroupName
                        : ''),
                  ),
                  Container(
                    child: Text(stockList[index].Size != null
                        ? stockList[index].Size
                        : ''),
                  ),
                  Container(
                    child: Text(stockList[index].Qty != null
                        ? stockList[index].Qty
                        : ''),
                  ),
                ]),
          ),
        ],
      ),
    ));
  }
}
