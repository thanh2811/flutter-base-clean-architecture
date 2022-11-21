class EndPoints {
  static const String baseDomain = "https://fitolabs.eztek.net";
  static const String idBaseUrl = "https://fitolabs-id.eztek.net";
  static const String appBaseUrl = "https://fitolabs-m.eztek.net";
  static const String cdnBaseUrl = "https://cdn-fitolabs.eztek.net";
  // static const String baseDomain = "https://dms.fitolabs.vn";
  // static const String idBaseUrl = "https://id.fitolabs.vn";
  // static const String appBaseUrl = "https://dms-m.fitolabs.vn";
  static const String publicAddressbaseUrl =
      "https://provinces.open-api.vn/api/p";
  // static const String idBaseUrl = 'https://tc-be.eztek.net';

  // user related
  static const String login = '/api/authenticate';
  static const String getAccountInfo = '/api/account';
  static const String changePassword = '/api/account/change-password';

  // employee related
  static const String getEmployeeByIdForUser =
      '/gw/Employee/GetEmployeeByIdForUser';

  static const String getCollabInfo = '/user/GetCurrentInfo';
  static const String getCollabTree = '/user/GetCurrentTree';
  static const String checkCollaborator = '/user/GetCheck';
  static const String getMemberDetailInfo =
      '/gateway/Member/memberViewMemberInformation';
  static const String getMemberBasicInfo = '/api/getInformation';
  static const String getBusinessTab = '/gateway/Member/memberListBusinessTab';
  static const String getSubTab = '/gateway/Member/memberListSubTab';
  static const String getGroupProductList = '/gateway/Product/groupProductList';
  static const String getProductList = '/gateway/Product/productList';
  static const String getProductViewDetail =
      '/gateway/Product/productViewDetail';

  static const String getCatalogList = '/gw/Catalog/search';
  static const String getCatalogActiveList = '/gw/Catalog/getListActive';
  static const String getOrders = '/gw/Order/search';
  static const String getOrderDetail = '/gw/PurchaseOrder/Id';
  static const String addPurchaseOrder = '/gw/PurchaseOrder/Add';
  static const String addReturnOrder = '/gw/Returns/Add';
  static const String getAllUnit = '/gw/Catalog/UnitGetAll';
  static const String getAllWarehouse = '/gw/Warehouse/getall';
  static const String getAllGroupByEmployeeId = '/gw/GetAllGroupByEmployeeId';
  // customer related
  static const String getCustomerInfo = "/gw/Customer/id";
  static const String getAllCustomer = "/gw/Customer/searchAdmin";
  static const String addNewCustomer = "/gw/Customer/add";
  static const String updateCustomer = "/gw/Customer/update";
  static const String getCustomerGroup = "/gw/CustomerGroup/getall";
  static const String getCustomerType = "/gw/CustomerType/getall";
  static const String getCustomerChannel = "/gw/Channel/getall";
  static const String getRouteByEmployeeId = "/gw/Route/getall";
  static String getRouteByCustomerId = '/gw/Route/by_cusId';
  static String getAllGroupByType = '';

  //check in
  static const String getAllAlbums = "/gw/Album/getall";
  static const String addCheckIn = "/gw/CheckIn/Add";

  // storage repository
  static const String uploadImage = "/gateway/Image/Upload";
  // report related
  static const String getSaleCustomer = "/gw/Report/SaleCustomer";
  static const String getSaleProduct = "/gw/Report/SaleProduct";
  static const String getOrderCustomer = "/gw/Report/OrderCustomer";
  static const String getOrderProduct = "/gw/Report/OrderProduct";

}
