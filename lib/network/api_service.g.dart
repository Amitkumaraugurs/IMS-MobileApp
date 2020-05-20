// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://imsapi.augursapps.com/api';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getTasks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('photos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => TaskModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  getloginTask(username, Password, action) async {
    ArgumentError.checkNotNull(username, 'username');
    ArgumentError.checkNotNull(Password, 'Password');
    ArgumentError.checkNotNull(action, 'action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'UserName': username,
      'Password': Password,
      'action': action
    };
    final Response<String> _result = await _dio.request('/login/Login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  getVendorList(ID, StoreID, VendorCode, Name, Address, Tin, City, State,
      Contact, Remarks, Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(StoreID, 'StoreID');
    ArgumentError.checkNotNull(VendorCode, 'VendorCode');
    ArgumentError.checkNotNull(Name, 'Name');
    ArgumentError.checkNotNull(Address, 'Address');
    ArgumentError.checkNotNull(Tin, 'Tin');
    ArgumentError.checkNotNull(City, 'City');
    ArgumentError.checkNotNull(State, 'State');
    ArgumentError.checkNotNull(Contact, 'Contact');
    ArgumentError.checkNotNull(Remarks, 'Remarks');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'StoreID': StoreID,
      'VendorCode': VendorCode,
      'Name': Name,
      'Address': Address,
      'Tin': Tin,
      'City': City,
      'State': State,
      'Contact': Contact,
      'Remarks': Remarks,
      'Action': Action
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/StockEntry/GetVendor',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Vendorlist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getGroupList(ID, Name, GroupID, Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(Name, 'Name');
    ArgumentError.checkNotNull(GroupID, 'GroupID');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'Name': Name,
      'GroupID': GroupID,
      'Action': Action
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/StockEntry/GetGroup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Grouplist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getCategoryList(ID, Name, GroupID, Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(Name, 'Name');
    ArgumentError.checkNotNull(GroupID, 'GroupID');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'Name': Name,
      'GroupID': GroupID,
      'Action': Action
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/StockEntry/GetCategory',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Categorylist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getSubCategoryList(
      ID, Name, StockLife, CatID, MinQty, MaxQty, Action, SubCatCode) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(Name, 'Name');
    ArgumentError.checkNotNull(StockLife, 'StockLife');
    ArgumentError.checkNotNull(CatID, 'CatID');
    ArgumentError.checkNotNull(MinQty, 'MinQty');
    ArgumentError.checkNotNull(MaxQty, 'MaxQty');
    ArgumentError.checkNotNull(Action, 'Action');
    ArgumentError.checkNotNull(SubCatCode, 'SubCatCode');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'Name': Name,
      'StockLife': StockLife,
      'CatID': CatID,
      'MinQty': MinQty,
      'MaxQty': MaxQty,
      'Action': Action,
      'SubCatCode': SubCatCode
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/StockEntry/GetSubGroup',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SubCategorylist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getSeasonList(ID, Name, Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(Name, 'Name');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'ID': ID, 'Name': Name, 'Action': Action};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/StockEntry/GetSeason',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SeasonList.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  submitGoodsFormData(
      ID,
      VendorId,
      CatId,
      GroupId,
      SubGroupId,
      Barcode,
      Concept,
      ItemDesc,
      StyleNo,
      Colour,
      Size,
      CostPerPrice,
      RetailPrice,
      Quantity,
      SaleQuantity,
      StockBal,
      DateStock,
      Season,
      Margin,
      VAT,
      SAT,
      Offer,
      BrandStyleCode,
      StoreId,
      Transport,
      DocketNo,
      StockLife,
      OutTransport,
      OutDocketNo,
      Artical,
      Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(VendorId, 'VendorId');
    ArgumentError.checkNotNull(CatId, 'CatId');
    ArgumentError.checkNotNull(GroupId, 'GroupId');
    ArgumentError.checkNotNull(SubGroupId, 'SubGroupId');
    ArgumentError.checkNotNull(Barcode, 'Barcode');
    ArgumentError.checkNotNull(Concept, 'Concept');
    ArgumentError.checkNotNull(ItemDesc, 'ItemDesc');
    ArgumentError.checkNotNull(StyleNo, 'StyleNo');
    ArgumentError.checkNotNull(Colour, 'Colour');
    ArgumentError.checkNotNull(Size, 'Size');
    ArgumentError.checkNotNull(CostPerPrice, 'CostPerPrice');
    ArgumentError.checkNotNull(RetailPrice, 'RetailPrice');
    ArgumentError.checkNotNull(Quantity, 'Quantity');
    ArgumentError.checkNotNull(SaleQuantity, 'SaleQuantity');
    ArgumentError.checkNotNull(StockBal, 'StockBal');
    ArgumentError.checkNotNull(DateStock, 'DateStock');
    ArgumentError.checkNotNull(Season, 'Season');
    ArgumentError.checkNotNull(Margin, 'Margin');
    ArgumentError.checkNotNull(VAT, 'VAT');
    ArgumentError.checkNotNull(SAT, 'SAT');
    ArgumentError.checkNotNull(Offer, 'Offer');
    ArgumentError.checkNotNull(BrandStyleCode, 'BrandStyleCode');
    ArgumentError.checkNotNull(StoreId, 'StoreId');
    ArgumentError.checkNotNull(Transport, 'Transport');
    ArgumentError.checkNotNull(DocketNo, 'DocketNo');
    ArgumentError.checkNotNull(StockLife, 'StockLife');
    ArgumentError.checkNotNull(OutTransport, 'OutTransport');
    ArgumentError.checkNotNull(OutDocketNo, 'OutDocketNo');
    ArgumentError.checkNotNull(Artical, 'Artical');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'VendorId': VendorId,
      'CatId': CatId,
      'GroupId': GroupId,
      'SubGroupId': SubGroupId,
      'Barcode': Barcode,
      'Concept': Concept,
      'ItemDesc': ItemDesc,
      'StyleNo': StyleNo,
      'Colour': Colour,
      'Size': Size,
      'CostPerPrice': CostPerPrice,
      'RetailPrice': RetailPrice,
      'Quantity': Quantity,
      'SaleQuantity': SaleQuantity,
      'StockBal': StockBal,
      'DateStock': DateStock,
      'Season': Season,
      'Margin': Margin,
      'VAT': VAT,
      'SAT': SAT,
      'Offer': Offer,
      'BrandStyleCode': BrandStyleCode,
      'StoreId': StoreId,
      'Transport': Transport,
      'DocketNo': DocketNo,
      'StockLife': StockLife,
      'OutTransport': OutTransport,
      'OutDocketNo': OutDocketNo,
      'Artical': Artical,
      'Action': Action
    };
    final Response<String> _result = await _dio.request(
        '/StockEntry/SavePurchaseEntry',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  getItemPurchaseList(
      ID,
      VendorId,
      CatId,
      GroupId,
      SubGroupId,
      Barcode,
      Concept,
      ItemDesc,
      StyleNo,
      Colour,
      Size,
      CostPerPrice,
      RetailPrice,
      Quantity,
      SaleQuantity,
      StockBal,
      DateStock,
      Season,
      Margin,
      VAT,
      SAT,
      Offer,
      BrandStyleCode,
      StoreId,
      Transport,
      DocketNo,
      StockLife,
      OutTransport,
      OutDocketNo,
      Artical,
      Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(VendorId, 'VendorId');
    ArgumentError.checkNotNull(CatId, 'CatId');
    ArgumentError.checkNotNull(GroupId, 'GroupId');
    ArgumentError.checkNotNull(SubGroupId, 'SubGroupId');
    ArgumentError.checkNotNull(Barcode, 'Barcode');
    ArgumentError.checkNotNull(Concept, 'Concept');
    ArgumentError.checkNotNull(ItemDesc, 'ItemDesc');
    ArgumentError.checkNotNull(StyleNo, 'StyleNo');
    ArgumentError.checkNotNull(Colour, 'Colour');
    ArgumentError.checkNotNull(Size, 'Size');
    ArgumentError.checkNotNull(CostPerPrice, 'CostPerPrice');
    ArgumentError.checkNotNull(RetailPrice, 'RetailPrice');
    ArgumentError.checkNotNull(Quantity, 'Quantity');
    ArgumentError.checkNotNull(SaleQuantity, 'SaleQuantity');
    ArgumentError.checkNotNull(StockBal, 'StockBal');
    ArgumentError.checkNotNull(DateStock, 'DateStock');
    ArgumentError.checkNotNull(Season, 'Season');
    ArgumentError.checkNotNull(Margin, 'Margin');
    ArgumentError.checkNotNull(VAT, 'VAT');
    ArgumentError.checkNotNull(SAT, 'SAT');
    ArgumentError.checkNotNull(Offer, 'Offer');
    ArgumentError.checkNotNull(BrandStyleCode, 'BrandStyleCode');
    ArgumentError.checkNotNull(StoreId, 'StoreId');
    ArgumentError.checkNotNull(Transport, 'Transport');
    ArgumentError.checkNotNull(DocketNo, 'DocketNo');
    ArgumentError.checkNotNull(StockLife, 'StockLife');
    ArgumentError.checkNotNull(OutTransport, 'OutTransport');
    ArgumentError.checkNotNull(OutDocketNo, 'OutDocketNo');
    ArgumentError.checkNotNull(Artical, 'Artical');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'VendorId': VendorId,
      'CatId': CatId,
      'GroupId': GroupId,
      'SubGroupId': SubGroupId,
      'Barcode': Barcode,
      'Concept': Concept,
      'ItemDesc': ItemDesc,
      'StyleNo': StyleNo,
      'Colour': Colour,
      'Size': Size,
      'CostPerPrice': CostPerPrice,
      'RetailPrice': RetailPrice,
      'Quantity': Quantity,
      'SaleQuantity': SaleQuantity,
      'StockBal': StockBal,
      'DateStock': DateStock,
      'Season': Season,
      'Margin': Margin,
      'VAT': VAT,
      'SAT': SAT,
      'Offer': Offer,
      'BrandStyleCode': BrandStyleCode,
      'StoreId': StoreId,
      'Transport': Transport,
      'DocketNo': DocketNo,
      'StockLife': StockLife,
      'OutTransport': OutTransport,
      'OutDocketNo': OutDocketNo,
      'Artical': Artical,
      'Action': Action
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/StockEntry/GetPurchaseEntry',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Purchaselist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getStoreList(Action) async {
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'Action': Action};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/InventoryIssueToStore/GetStore',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Storelist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  SaveDistribution(
      ID,
      StoreId,
      PurchaseId,
      IssueQty,
      SoldQty,
      DamageQty,
      ReturnQty,
      Discount,
      Barcode,
      From,
      To,
      MasterQty,
      Transport,
      Docket,
      StockLife,
      Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(StoreId, 'StoreId');
    ArgumentError.checkNotNull(PurchaseId, 'PurchaseId');
    ArgumentError.checkNotNull(IssueQty, 'IssueQty');
    ArgumentError.checkNotNull(SoldQty, 'SoldQty');
    ArgumentError.checkNotNull(DamageQty, 'DamageQty');
    ArgumentError.checkNotNull(ReturnQty, 'ReturnQty');
    ArgumentError.checkNotNull(Discount, 'Discount');
    ArgumentError.checkNotNull(Barcode, 'Barcode');
    ArgumentError.checkNotNull(From, 'From');
    ArgumentError.checkNotNull(To, 'To');
    ArgumentError.checkNotNull(MasterQty, 'MasterQty');
    ArgumentError.checkNotNull(Transport, 'Transport');
    ArgumentError.checkNotNull(Docket, 'Docket');
    ArgumentError.checkNotNull(StockLife, 'StockLife');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'StoreId': StoreId,
      'PurchaseId': PurchaseId,
      'IssueQty': IssueQty,
      'SoldQty': SoldQty,
      'DamageQty': DamageQty,
      'ReturnQty': ReturnQty,
      'Discount': Discount,
      'Barcode': Barcode,
      'From': From,
      'To': To,
      'MasterQty': MasterQty,
      'Transport': Transport,
      'Docket': Docket,
      'StockLife': StockLife,
      'Action': Action
    };
    final Response<String> _result = await _dio.request(
        '/InventoryIssueToStore/SaveDistribution',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  getStockList(
      ID,
      CatId,
      GroupId,
      SubGroupId,
      Artical,
      ItemDesc,
      StyleNo,
      Colour,
      Size,
      CostPerPrice,
      RetailPrice,
      Margin,
      VAT,
      SAT,
      Discount,
      BrandStyleCode,
      Season,
      Barcode,
      Quantity,
      Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(CatId, 'CatId');
    ArgumentError.checkNotNull(GroupId, 'GroupId');
    ArgumentError.checkNotNull(SubGroupId, 'SubGroupId');
    ArgumentError.checkNotNull(Artical, 'Artical');
    ArgumentError.checkNotNull(ItemDesc, 'ItemDesc');
    ArgumentError.checkNotNull(StyleNo, 'StyleNo');
    ArgumentError.checkNotNull(Colour, 'Colour');
    ArgumentError.checkNotNull(Size, 'Size');
    ArgumentError.checkNotNull(CostPerPrice, 'CostPerPrice');
    ArgumentError.checkNotNull(RetailPrice, 'RetailPrice');
    ArgumentError.checkNotNull(Margin, 'Margin');
    ArgumentError.checkNotNull(VAT, 'VAT');
    ArgumentError.checkNotNull(SAT, 'SAT');
    ArgumentError.checkNotNull(Discount, 'Discount');
    ArgumentError.checkNotNull(BrandStyleCode, 'BrandStyleCode');
    ArgumentError.checkNotNull(Season, 'Season');
    ArgumentError.checkNotNull(Barcode, 'Barcode');
    ArgumentError.checkNotNull(Quantity, 'Quantity');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'CatId': CatId,
      'GroupId': GroupId,
      'SubGroupId': SubGroupId,
      'Artical': Artical,
      'ItemDesc': ItemDesc,
      'StyleNo': StyleNo,
      'Colour': Colour,
      'Size': Size,
      'CostPerPrice': CostPerPrice,
      'RetailPrice': RetailPrice,
      'Margin': Margin,
      'VAT': VAT,
      'SAT': SAT,
      'Discount': Discount,
      'BrandStyleCode': BrandStyleCode,
      'Season': Season,
      'Barcode': Barcode,
      'Quantity': Quantity,
      'Action': Action
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/StockEntry/GetArticle',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Stocklist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  submitStockFormData(
      ID,
      CatId,
      GroupId,
      SubGroupId,
      Article,
      ItemDesc,
      StyleNo,
      Colour,
      Size,
      CostPerPrice,
      RetailPrice,
      Margin,
      VAT,
      SAT,
      Discount,
      BrandStyleCode,
      Season,
      Barcode,
      Quantity,
      Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(CatId, 'CatId');
    ArgumentError.checkNotNull(GroupId, 'GroupId');
    ArgumentError.checkNotNull(SubGroupId, 'SubGroupId');
    ArgumentError.checkNotNull(Article, 'Article');
    ArgumentError.checkNotNull(ItemDesc, 'ItemDesc');
    ArgumentError.checkNotNull(StyleNo, 'StyleNo');
    ArgumentError.checkNotNull(Colour, 'Colour');
    ArgumentError.checkNotNull(Size, 'Size');
    ArgumentError.checkNotNull(CostPerPrice, 'CostPerPrice');
    ArgumentError.checkNotNull(RetailPrice, 'RetailPrice');
    ArgumentError.checkNotNull(Margin, 'Margin');
    ArgumentError.checkNotNull(VAT, 'VAT');
    ArgumentError.checkNotNull(SAT, 'SAT');
    ArgumentError.checkNotNull(Discount, 'Discount');
    ArgumentError.checkNotNull(BrandStyleCode, 'BrandStyleCode');
    ArgumentError.checkNotNull(Season, 'Season');
    ArgumentError.checkNotNull(Barcode, 'Barcode');
    ArgumentError.checkNotNull(Quantity, 'Quantity');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'CatId': CatId,
      'GroupId': GroupId,
      'SubGroupId': SubGroupId,
      'Article': Article,
      'ItemDesc': ItemDesc,
      'StyleNo': StyleNo,
      'Colour': Colour,
      'Size': Size,
      'CostPerPrice': CostPerPrice,
      'RetailPrice': RetailPrice,
      'Margin': Margin,
      'VAT': VAT,
      'SAT': SAT,
      'Discount': Discount,
      'BrandStyleCode': BrandStyleCode,
      'Season': Season,
      'Barcode': Barcode,
      'Quantity': Quantity,
      'Action': Action
    };
    final Response<String> _result = await _dio.request(
        '/StockEntry/SaveArticleEntry',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return Future.value(value);
  }

  @override
  Gettransfer(ID, Action, FromStore, ToStore, PurchaseId, Barcode, Quantity,
      IssuedQty) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(Action, 'Action');
    ArgumentError.checkNotNull(FromStore, 'FromStore');
    ArgumentError.checkNotNull(ToStore, 'ToStore');
    ArgumentError.checkNotNull(PurchaseId, 'PurchaseId');
    ArgumentError.checkNotNull(Barcode, 'Barcode');
    ArgumentError.checkNotNull(Quantity, 'Quantity');
    ArgumentError.checkNotNull(IssuedQty, 'IssuedQty');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'Action': Action,
      'FromStore': FromStore,
      'ToStore': ToStore,
      'PurchaseId': PurchaseId,
      'Barcode': Barcode,
      'Quantity': Quantity,
      'IssuedQty': IssuedQty
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/InventoryIssueToStore/GetTransfer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Inventorylist.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  Getdistribution(
      ID,
      StoreId,
      PurchaseId,
      IssueQty,
      SoldQty,
      DamageQty,
      ReturnQty,
      Discount,
      Barcode,
      From,
      To,
      MasterQty,
      Transport,
      Docket,
      StockLife,
      Action) async {
    ArgumentError.checkNotNull(ID, 'ID');
    ArgumentError.checkNotNull(StoreId, 'StoreId');
    ArgumentError.checkNotNull(PurchaseId, 'PurchaseId');
    ArgumentError.checkNotNull(IssueQty, 'IssueQty');
    ArgumentError.checkNotNull(SoldQty, 'SoldQty');
    ArgumentError.checkNotNull(DamageQty, 'DamageQty');
    ArgumentError.checkNotNull(ReturnQty, 'ReturnQty');
    ArgumentError.checkNotNull(Discount, 'Discount');
    ArgumentError.checkNotNull(Barcode, 'Barcode');
    ArgumentError.checkNotNull(From, 'From');
    ArgumentError.checkNotNull(To, 'To');
    ArgumentError.checkNotNull(MasterQty, 'MasterQty');
    ArgumentError.checkNotNull(Transport, 'Transport');
    ArgumentError.checkNotNull(Docket, 'Docket');
    ArgumentError.checkNotNull(StockLife, 'StockLife');
    ArgumentError.checkNotNull(Action, 'Action');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'ID': ID,
      'StoreId': StoreId,
      'PurchaseId': PurchaseId,
      'IssueQty': IssueQty,
      'SoldQty': SoldQty,
      'DamageQty': DamageQty,
      'ReturnQty': ReturnQty,
      'Discount': Discount,
      'Barcode': Barcode,
      'From': From,
      'To': To,
      'MasterQty': MasterQty,
      'Transport': Transport,
      'Docket': Docket,
      'StockLife': StockLife,
      'Action': Action
    };
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/InventoryIssueToStore/GetDistribution',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Requestlist.fromJson(_result.data);
    return Future.value(value);
  }
}
