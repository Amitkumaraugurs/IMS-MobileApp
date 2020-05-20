import 'package:flutter/material.dart';
import 'AddStockItem.dart';
import 'package:management/network/api_service.dart';
import 'package:provider/provider.dart';
import 'package:management/network/model/stock_model.dart';



class StockList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StockListState();
  }
}

class StockListState  extends State<StockList>{
  @override
  void initState() {
    super.initState();
    this.loadStockItemList();
  }


  List<StockListData> stockList = <StockListData>[];

  Future<List> loadStockItemList() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getStockList(0, 0, 0, 0, "", "", "", "", "", 0, 0, 0, 0, 0,0, "", "", "", "", 4).then((result) {
      print(result.stockData);
          if (result.stockData.isNotEmpty) {
            setState(() {
              stockList = result.stockData;
            });
          }else{
            stockList = [];
          }
          print(stockList);
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0,color: Colors.black);
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: ()async{
            Navigator.pop(context,"From BackButton");
          }),
        title: Text("Stock"),),
        
      body: Container(
        child: Column(
            children: <Widget>[
              Container(
                height: 35.0,
                width: double.infinity,
                color: Colors.teal,
                child:Center(
                    child: Text("Stock Item List",style: style)
                ),
              ),
              /*Container(
                margin: const EdgeInsets.all(10.0),
                child: emailField,
              ),*/
              stockList.isNotEmpty
                  ? Expanded(child: ListView.builder(
                itemCount: stockList.length,
                itemBuilder: _buildRow,
              ),
              )
                  : Container(
                  margin: const EdgeInsets.all(180.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
            ]
        ),
      ),


      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddStockItem()));
          },
          child: Icon(Icons.add)
      ),
    );
    throw UnimplementedError();
  }

  Widget _buildRow(BuildContext context, int index) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(7.0),
//            FontWeight : const  bold = w700,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('Article : ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
//                    decoration: ,
                  ),
                  Container(
                      child: Text('Style No : ',
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Container(
                      child: Text("Group : ",
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Container(
                      child: Text("Category : ",
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                ]
            ),
          ),

          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(stockList[index].Article != null ? stockList[index].Article :''),
                  ),
                  Container(
                    child: Text(stockList[index].StyleNo != null ? stockList[index].StyleNo :''),
                  ),
                  Container(
                    child: Text(stockList[index].GroupName != null ? stockList[index].GroupName :''),
                  ),
                  Container(
                    child: Text(stockList[index].Category != null ? stockList[index].Category :''),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}