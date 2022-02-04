class ApiLinks {
  String get mainBase => "https://api.bnrsecurities.com/rest/BNRV2Service";

  String get authMainBase => "https://trading-uat.aliceblueonline.com/hsauth";
  String get hsiMainBase => "https://trading-uat.aliceblueonline.com/hsi";
  String get hscontent => "https://trading-uat.aliceblueonline.com/hscontent";
  // String get mainBase => "https://uat.bnrsecurities.com/rest/BNRUATService";

  // Zebu
  // String get mainBase => "https://api.zebull.in/rest/V2MobullService";

  // BNR UAT
  // String get mainBase => "https://uat.bnrsecurities.com/rest/BNRUATService/";
  String get v2Base =>
      "https://pure.bnrsecurities.com/rest/BNRDataAPIService/v2";
  // String get version => "/v2";
  // String get base => mainBase + version;
  String get searchBase =>
      "https://pure.bnrsecurities.com/rest/BNRDataAPIService/v2";
  String get base => mainBase;

  static const String version = "1.0.0.27";
  static const String loginType = "Mobile";

  // Websocket
  static const baseWSURL = 'http://154.83.3.25:8889';
  String get baseWS => baseWSURL;
  static const String mwWebSocket =
      "wss://trading.bnrsecurities.com/NestHtml5MobileInH/socket/stream";

  // Alice Blue

  String get authBase => authMainBase;

  // Login
  String get deviceInfo => '$authBase/api/checkdeviceinfo';
  String get cancelorder => '$hsiMainBase/orders/regular/210927000000031';
  String get otpvalidation => '$authBase/api/validateotp';
  String get guestLogin => '$authBase/api/guestlogin';
  String get changePassword => '$authBase/api/chngpwd';
  String get guestOTP => '$authBase/api/verifyotp';
  String get forgotuserid => '$authBase/api/frgtuid';
  String get resendOTP => '$authBase/api/resendotp';
  String get unblockUser => '$authBase/api/unblockuser';
  String get createMpin => '$authBase/api/setmpin';
  String get createPassword => '$authBase/api/newpwd';
  String get login => '$authBase/api/login';
  String get forgotPassword => '$authBase/api/frgtpwd';
  String get verifyMpin => '$authBase/api/mpinlogin';
  String get holdings => '$hsiMainBase/portfolio/holdings';
  String get positions => '$hsiMainBase/portfolio/positions';
  String get fetchOrderBook => '$hsiMainBase/orders';
  String get fetchTradeBook => '$hsiMainBase/trades';
  String get userDetails => '$hsiMainBase/user/profile';
  String get scripInfo => '$hsiMainBase/scrip/info';
  String get placeRegularOrder => '$hsiMainBase/orders/regular';
  String get placeCoverOrder => '$hsiMainBase/orders/co';
  String get placeBracketOrder => '$hsiMainBase/orders/bo';
  String get placeAmoOrder => '$hsiMainBase/orders/amo';



  //  Customer
  String get customer => '$base/customer';
  String get verify2FA => '$customer/validAnswer';
  // String get forgotPassword => '$customer/forgotPassword';
  String get reset2FA => '$customer/saveAns';
  String get resetQuestion2FA => '$customer/reset2fa';
  String get creatempin => '$customer/createMpin';
  String get encryptionKey => '$customer/getEncryptionKey';
  String get loginStatus => '$customer/getUserStatusAndVersion';
  String get logoutStatus => '$customer/logoutStatus';
  String get logoutUser => '$customer/logout';
  String get logoutAll => '$customer/logOutFromAllDevice';
  String get unblockAccount => '$customer/unblockUser';

  // MarketWatch
  String get marketWatch => '$base/marketWatch';
  String get fetchMWList => '$marketWatch/fetchMWList';
  String get fetchMWScrips => '$marketWatch/fetchMWScrips';
  String get deleteMWScrips => '$marketWatch/deleteMWScrip';
  String get addScripMW => '$marketWatch/addScripToMW';
  String get scripMw => '$base/marketWatch/scripsMW';
  String get fundamentalAnalysis =>
      '$base/fundamentalAnalysis/getFundamentalIndicators';
  String get technicalAnalysis =>
      '$base/techinicalAnalysis/getTechnicalIndicators';
  String get scripAlert => '$base/more/getSecTradeAlert';
  String get optionChain => '$base/FNOInstrument/getModernAlgoOptionChain';

  // Exchange
  String get exchange => '$searchBase/exchange';
  String get searchScripList => '$exchange/getScripForSearch';

  // Orders

  String get orderHistory => '$base/placeOrder/orderHistory';
  String get placeOrder => '$base/placeOrder/executePlaceOrder';

  String get cancelOrder => '$base/placeOrder/cancelOrder';
  String get cancelCoverOrder => '$base/placeOrder/exitCoverOrder';
  String get cancelBracketOrder => '$base/placeOrder/exitBracketOrder';

  String get modifyOrder => '$base/placeOrder/modifyOrder';

  // Funds
  String get getRmsLimit => '$base/limits/getRmsLimits';
  String get getDepositWithdrawToken => '$base/pay/getOMSessionToken';

  String get getRmsLimitFunds =>
      '$hsiMainBase/user/limits?seg=ALL&exch=ALL&prod=ALL';

  // Settings
  String get getProfile => '$base/customer/accountDetails';
  String get appAccessVendor => '$base/api/getVendorList';
  String get removeAuthorize => '$base/api/revokeAuthorizeAccessforVendor';
  String get addAuthorizeAccess => '$base/api/authorizeAccessforVendor';

  // Scrip
  String get getScripPrice => '$base/ScripDetails/getNewPriceRange';
  String get getScripQuoteDetails => '$base/ScripDetails/getScripQuoteDetails';
  String get getSecurityInfo => '$base/ScripDetails/getSecurityInfo';

  // Portfolio
  String get posHold => '$base/positionAndHoldings';
  String get getHolding => '$posHold/holdings';
  String get getPosition => '$posHold/positionBook';
  String get getPositionAverage => '$base/avgPrice/getPositionAvgPrice';
  String get getPreviousDayClose => '$base/analytics/getPreviousDayPrice';
  String get exitPosition => '$base/positionAndHoldings/positionSqrOff';
  String get convertPosition => '$base/positionAndHoldings/positionConvertion';

  // Change Password & Change Mpin
  String get updatePassword => '$base/customer/changePassword';
  String get updateMpin => '$base/customer/updateMpin';

  // Indices dashboard
  String get indices => '$base/ScripDetails/getIndexDetails';
  String get globalMarketIndices => '$base/others/getGlobalIndicesData';
  String get normalNews => '$base/news/getmarketMovers';
  String get getPriceRangeFuture => '$base/ScripDetails/getNewPriceRange';
  String get getCurrentFutureToken => '$base/ScripDetails/getFutureToken';

  // Analytics

  String get topGainers => '$base/fundamentalAnalysis/getTopGainers';
  String get topLossers => '$base/fundamentalAnalysis/getTopLosers';
  String get weekHigh => '$base/fundamentalAnalysis/get52WeekHigh';
  String get weekLow => '$base/fundamentalAnalysis/get52WeekLow';
  String get riders => '$base/fundamentalAnalysis/getRiders';
  String get draggers => '$base/fundamentalAnalysis/getDraggers';
  String get mostActive => '$base/fundamentalAnalysis/getTopVolume';
  String get meanReversion => '$base/fundamentalAnalysis/getMeanReversion';
  String get longBuild => '$base/analytics/getLongBuildUp';
  String get shortBuild => '$base/analytics/getShortBuildUp';
  String get longUnwinding => '$base/analytics/getLongUnwinding';
  String get shortUnwinding => '$base/analytics/getShortUnwinding';

  // Notification

  String get notification =>
      'https://uat.bnrsecurities.com/rest/BNRAdminServiceCheck/admin/getMessageDetails';

  // Exchange Message

  String get exchangeMessage => '$base/exchange/getExchangeMessage';

  // WebScokets

  String get createSessionWS => '$baseWS/NorenWsHelper/CreateSess';
  String get invalidateSessionWS => '$baseWS/NorenWsHelper/InvalidateSess';

  //Marketwatch
  String get getUsergroups => '$hscontent/htpl/userwatchlist/getusergroups';
  String get getScripInfo => '$hsiMainBase/scrip/info';
  String get searchSymbol => '$hscontent/htpl/search/symbol';
  String get deleteUserGroups =>
      '$hscontent/htpl/userwatchlist/deleteusergroups';
  String get updateWatchlist => '$hscontent/htpl/userwatchlist/updatewatchlist';
  String get renameWatchlist => '$hscontent/htpl/userwatchlist/renamewatchlist';
}
