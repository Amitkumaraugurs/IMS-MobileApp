import 'package:dio/dio.dart';
import 'package:management/network/model/inventoryConf.dart';
//import 'package:management/network/model/user.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'model/company.dart';
import 'model/goods_model.dart';
import 'model/request_inventory.dart';
import 'model/stock_model.dart';
import 'model/store.dart';
import 'model/task_model.dart';
import 'model/vendor_balance.dart';
import 'model/store_stock_balance.dart';
// import 'package:intl/intl.dart';
import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

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
  Future<String> getloginTask(
    @Field("UserName") username,
    @Field("Password") Password,
    @Field("action") action,
  );

  @POST("/login/getcompanyinformation")
  Future<Companylist> getCompanyList(@Field("Action") Action);

  @POST("/login/getusertype")
  Future<Usertypelist> getusertypeList(@Field("Action") Action);

  @POST("/login/getusernames")
  Future<UserNamelist> getusernameList(@Field("userscope") userscope);

  @POST("/StockEntry/GetVendor")
  Future<Vendorlist> getVendorList(
      @Field("ID") ID,
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
  Future<Grouplist> getGroupList(@Field("ID") ID, @Field("Name") Name,
      @Field("GroupID") GroupID, @Field("Action") Action);

  @POST("/StockEntry/GetCategory")
  Future<Categorylist> getCategoryList(@Field("ID") ID, @Field("Name") Name,
      @Field("GroupID") GroupID, @Field("Action") Action);

  @POST("/StockEntry/GetSubGroup")
  Future<SubCategorylist> getSubCategoryList(
      @Field("ID") ID,
      @Field("Name") Name,
      @Field("StockLife") StockLife,
      @Field("CatID") CatID,
      @Field("MinQty") MinQty,
      @Field("MaxQty") MaxQty,
      @Field("Action") Action,
      @Field("SubCatCode") SubCatCode);

  @POST("/StockEntry/GetSeason")
  Future<SeasonList> getSeasonList(
      @Field("ID") ID, @Field("Name") Name, @Field("Action") Action);

  // Start Purchase entry
  @POST("/StockEntry/SavePurchaseEntry")
  Future<String> submitGoodsFormData(
      @Field("ID") ID,
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
  Future<Purchaselist> getItemPurchaseList(
      @Field("ID") ID,
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

  // End Purchase entry

  // Start Stock Article

  @POST("/StockEntry/GetArticle")
  Future<Stocklist> getStockList(
    @Field("ID") ID,
    @Field("CatId") CatId,
    @Field("GroupId") GroupId,
    @Field("SubGroupId") SubGroupId,
    @Field("Artical") Artical,
    @Field("ItemDesc") ItemDesc,
    @Field("StyleNo") StyleNo,
    @Field("Color") Color,
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
  Future<String> submitStockFormData(
    @Field("ID") ID,
    @Field("CatId") CatId,
    @Field("GroupId") GroupId,
    @Field("SubGroupId") SubGroupId,
    @Field("Article") Article,
    @Field("ItemDesc") ItemDesc,
    @Field("StyleNo") StyleNo,
    @Field("Color") Color,
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
    @Field("RFID") RFID,
    @Field("Action") Action,
  );

  // End Stock Article

  // Start Inventory Issue to store

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
      @Field("Discount") Discount,
      @Field("Barcode") Barcode,
      @Field("From") From,
      @Field("To") To,
      @Field("MasterQty") MasterQty,
      @Field("Transport") Transport,
      @Field("Docket") Docket,
      @Field("StockLife") StockLife,
      @Field("Action") Action);

  @POST("/InventoryIssueToStore/GetTransfer")
  Future<Inventorylist> Gettransfer(
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
  Future<Requestlist> Getdistribution(
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

  // End Inventory Issue to store

  //Start Vendor Store balance

  @POST("/vendorbalance/GetVendor")
  Future<BalanceVendorlist> getBalVendorList(
      @Field("ID") ID,
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

  @POST("/vendorbalance/getBalance")
  Future<VendorSearchBalList> getVendorBalanceList(
    @Field("id") id,
    @Field("storeid") storeid,
    // @Field("VendorCode") VendorCode,
    // @Field("name") name,
    // @Field("address") address,
    // @Field("tin") tin,
    // @Field("city") city,
    // @Field("state") state,
    // @Field("contact") contact,
    // @Field("remarks") remarks,
    @Field("action") action,
  );

  @POST("/vendorbalance/updateVendorBalance")
  Future<String> updateVendorBalance(
    @Field("balance") balance,
    @Field("vendorId") vendorId,
    @Field("InvNo") invoice,
    @Field("action") action,
  );

  //End Vendor Store balance

  //Start Store Stock Balance

  @POST("/StoreStockBalance/GetStore")
  Future<StoreStocklist> getStoreStockList(
      @Field("ID") id,
      @Field("Name") name,
      @Field("Address") address,
      @Field("Contact") contact,
      @Field("Tin") tin,
      @Field("Action") action);

  @POST("/StoreStockBalance/BindData")
  Future<StoreStockBalList> searchStoreStock(@Field("StoreId") storeId,
      @Field("fromdate") fromdate, @Field("todate") todate);

  // End Store Stock Balance
}
