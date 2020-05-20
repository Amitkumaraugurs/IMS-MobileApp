import 'package:dio/dio.dart';
import 'package:management/network/model/inventoryConf.dart';
//import 'package:management/network/model/user.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'model/goods_model.dart';
import 'model/request_inventory.dart';
import 'model/stock_model.dart';
import 'model/store.dart';
import 'model/task_model.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


part 'api_service.g.dart';

@RestApi(baseUrl: "http://imsapi.augursapps.com/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio);
  }

  @GET("photos")
  Future<List<TaskModel>> getTasks();

//  @POST("/Login/login")
//  Future<String> loginTask(
//    @Field("UserName") username,
//    @Field("Password") Password,
//    @Field("action") action,
//  );

  @POST("/login/Login")
  Future<String> getloginTask(@Field("UserName") username,
      @Field("Password") Password,
      @Field("action") action,);

  @POST("/StockEntry/GetVendor")
  Future<Vendorlist> getVendorList(@Field("ID") ID,
      @Field("StoreID") StoreID,
      @Field("VendorCode") VendorCode,
      @Field("Name") Name,
      @Field("Address") Address,
      @Field("Tin") Tin,
      @Field("City") City,
      @Field("State") State,
      @Field("Contact") Contact,
      @Field("Remarks") Remarks,
      @Field("Action") Action);

  @POST("/StockEntry/GetGroup")
  Future<Grouplist> getGroupList(@Field("ID") ID,
      @Field("Name") Name,
      @Field("GroupID") GroupID,
      @Field("Action") Action);

  @POST("/StockEntry/GetCategory")
  Future<Categorylist> getCategoryList(@Field("ID") ID,
      @Field("Name") Name,
      @Field("GroupID") GroupID,
      @Field("Action") Action);

  @POST("/StockEntry/GetSubGroup")
  Future<SubCategorylist> getSubCategoryList(@Field("ID") ID,
      @Field("Name") Name,
      @Field("StockLife") StockLife,
      @Field("CatID") CatID,
      @Field("MinQty") MinQty,
      @Field("MaxQty") MaxQty,
      @Field("Action") Action,
      @Field("SubCatCode") SubCatCode);

  @POST("/StockEntry/GetSeason")
  Future<SeasonList> getSeasonList(
      @Field("ID") ID,
      @Field("Name") Name,
      @Field("Action") Action);


  @POST("/StockEntry/SavePurchaseEntry")
  Future<String> submitGoodsFormData(@Field("ID") ID,
      @Field("VendorId") VendorId,
      @Field("CatId") CatId,
      @Field("GroupId") GroupId,
      @Field("SubGroupId") SubGroupId,
      @Field("Barcode") Barcode,
      @Field("Concept") Concept,
      @Field("ItemDesc") ItemDesc,
      @Field("StyleNo") StyleNo,
      @Field("Colour") Colour,
      @Field("Size") Size,
      @Field("CostPerPrice") CostPerPrice,
      @Field("RetailPrice") RetailPrice,
      @Field("Quantity") Quantity,
      @Field("SaleQuantity") SaleQuantity,
      @Field("StockBal") StockBal,
      @Field("DateStock") DateStock,
      @Field("Season") Season,
      @Field("Margin") Margin,
      @Field("VAT") VAT,
      @Field("SAT") SAT,
      @Field("Offer") Offer,
      @Field("BrandStyleCode") BrandStyleCode,
      @Field("StoreId") StoreId,
      @Field("Transport") Transport,
      @Field("DocketNo") DocketNo,
      @Field("StockLife") StockLife,
      @Field("OutTransport") OutTransport,
      @Field("OutDocketNo") OutDocketNo,
      @Field("Artical") Artical,
      @Field("Action") Action);


  @POST("/StockEntry/GetPurchaseEntry")
  Future<Purchaselist>getItemPurchaseList(@Field("ID") ID,
      @Field("VendorId") VendorId,
      @Field("CatId") CatId,
      @Field("GroupId") GroupId,
      @Field("SubGroupId") SubGroupId,
      @Field("Barcode") Barcode,
      @Field("Concept") Concept,
      @Field("ItemDesc") ItemDesc,
      @Field("StyleNo") StyleNo,
      @Field("Colour") Colour,
      @Field("Size") Size,
      @Field("CostPerPrice") CostPerPrice,
      @Field("RetailPrice") RetailPrice,
      @Field("Quantity") Quantity,
      @Field("SaleQuantity") SaleQuantity,
      @Field("StockBal") StockBal,
      @Field("DateStock") DateStock,
      @Field("Season") Season,
      @Field("Margin") Margin,
      @Field("VAT") VAT,
      @Field("SAT") SAT,
      @Field("Offer") Offer,
      @Field("BrandStyleCode") BrandStyleCode,
      @Field("StoreId") StoreId,
      @Field("Transport") Transport,
      @Field("DocketNo") DocketNo,
      @Field("StockLife") StockLife,
      @Field("OutTransport") OutTransport,
      @Field("OutDocketNo") OutDocketNo,
      @Field("Artical") Artical,
      @Field("Action") Action);




  @POST("/InventoryIssueToStore/GetStore")
  Future<Storelist> getStoreList(@Field("Action") Action);

  @POST("/InventoryIssueToStore/SaveDistribution")
  Future<String> SaveDistribution(
      @Field("ID") ID,
      @Field("StoreId") StoreId,
      @Field("PurchaseId") PurchaseId,
      @Field("IssueQty") IssueQty,
      @Field("SoldQty") SoldQty,
      @Field("DamageQty") DamageQty,
      @Field("ReturnQty") ReturnQty,
      @Field("Discount") Discount ,
      @Field("Barcode") Barcode,
      @Field("From") From,
      @Field("To") To,
      @Field("MasterQty") MasterQty,
      @Field("Transport") Transport,
      @Field("Docket") Docket,
      @Field("StockLife") StockLife,
      @Field("Action") Action);



  @POST("/StockEntry/GetArticle")
  Future<Stocklist>getStockList(
      @Field("ID") ID,
      @Field("CatId") CatId,
      @Field("GroupId") GroupId,
      @Field("SubGroupId") SubGroupId,
      @Field("Artical") Artical,
      @Field("ItemDesc") ItemDesc,
      @Field("StyleNo") StyleNo,
      @Field("Colour") Colour,
      @Field("Size") Size,
      @Field("CostPerPrice") CostPerPrice,
      @Field("RetailPrice") RetailPrice,
      @Field("Margin") Margin,
      @Field("VAT") VAT,
      @Field("SAT") SAT,
      @Field("Discount") Discount,
      @Field("BrandStyleCode") BrandStyleCode,
      @Field("Season") Season,
      @Field("Barcode") Barcode,
      @Field("Quantity") Quantity,
      @Field("Action") Action,
      );

  @POST("/StockEntry/SaveArticleEntry")
  Future<String>submitStockFormData(
      @Field("ID") ID,
      @Field("CatId") CatId,
      @Field("GroupId") GroupId,
      @Field("SubGroupId") SubGroupId,
      @Field("Article") Article,
      @Field("ItemDesc") ItemDesc,
      @Field("StyleNo") StyleNo,
      @Field("Colour") Colour,
      @Field("Size") Size,
      @Field("CostPerPrice") CostPerPrice,
      @Field("RetailPrice") RetailPrice,
      @Field("Margin") Margin,
      @Field("VAT") VAT,
      @Field("SAT") SAT,
      @Field("Discount") Discount,
      @Field("BrandStyleCode") BrandStyleCode,
      @Field("Season") Season,
      @Field("Barcode") Barcode,
      @Field("Quantity") Quantity,
      @Field("Action") Action,
      );


  @POST("/InventoryIssueToStore/GetTransfer")
  Future<Inventorylist>Gettransfer(
      @Field("ID") ID,
      @Field("Action") Action,
      @Field("FromStore") FromStore,
      @Field("ToStore") ToStore,
      @Field("PurchaseId") PurchaseId,
      @Field("Barcode") Barcode,
      @Field("Quantity") Quantity,
      @Field("IssuedQty") IssuedQty,
      );


  @POST("/InventoryIssueToStore/GetDistribution")
  Future<Requestlist>Getdistribution(
      @Field("ID") ID,
      @Field("StoreId") StoreId,
      @Field("PurchaseId") PurchaseId,
      @Field("IssueQty") IssueQty,
      @Field("SoldQty") SoldQty,
      @Field("DamageQty") DamageQty,
      @Field("ReturnQty") ReturnQty,
      @Field("Discount") Discount,
      @Field("Barcode") Barcode,
      @Field("From") From,
      @Field("To") To,
      @Field("MasterQty") MasterQty,
      @Field("Transport") Transport,
      @Field("Docket") Docket,
      @Field("StockLife") StockLife,
      @Field("Action") Action,
      );

}


//class Services {
//  static const _serviceUrl = 'http://imsapi.augursapps.com/api/StockEntry/SavePurchaseEntry';
//  static final _headers = {'Content-Type': 'application/json'};
//
//  Future<GoodsFormModel> submitGoodsFormData(GoodsFormModel goodsFormModel) async {
//    try {
////      var formData = new Goodsform();
//    print(goodsFormModel);
//      String jsonData = _toJson(goodsFormModel);
//      print("sssss");
//
//      print(jsonData);
//      final response = await http.post(_serviceUrl, headers: _headers, body: jsonData);
//      print(response.body);
////      var c = _fromJson(response.body);
////      return c;
//    } catch (e) {
//      print('Server Exception!!!');
//      print(e);
//      return null;
//    }
//  }
//
//  String _toJson(GoodsFormModel formData){
//    var mapData = new Map();
//
//    mapData["ID"] = "0";
//    mapData["VendorId"] = formData.VendorId;
//    mapData["CatId"] = formData.CatId;
//    mapData["GroupId"] = formData.GroupId;
//    mapData["SubGroupId"] = formData.SubGruopId;
//
//    mapData["Barcode"] = formData.Barcode;
//    mapData["Concept"] = "0";
//    mapData["ItemDesc"] = "";
//    mapData["StyleNo"] = "";
//    mapData["Colour"] = formData.Color;
//
//    mapData["Size"] = formData.Size;
//    mapData["CostPerPrice"] = formData.CostPerPrice;
//    mapData["RetailPrice"] = formData.RetailPrice;
//    mapData["Quantity"] = formData.Quantity;
//    mapData["SaleQuantity"] ="0";
//
//    mapData["StockBal"] = "0";
//    mapData["DateStock"] = formData.DateStock;
//    mapData["Season"] = formData.Season;
//    mapData["Margin"] = formData.Margin;
//    mapData["VAT"] = formData.VAT;
//
//    mapData["SAT"] = formData.SAT;
//    mapData["Offer"] = formData.Offer;
//    mapData["BrandStyleCode"] = formData.BrandStyleCode;
//    mapData["StoreId"] = "0";
//    mapData["Transport"] = formData.Transport;
//
//    mapData["DocketNo"] = formData.DocketNo;
//    mapData["StockLife"] = 0;
//    mapData["OutTransport"] = "";
//    mapData["OutDockectNo"] = "";
//    mapData["Article"] = "";
//
//    mapData["Action"] = 2;
//  }
//}
