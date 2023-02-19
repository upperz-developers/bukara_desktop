// ignore_for_file: constant_identifier_names

class APIURL {
  static const String BASEURL = "https://api-bukara.upper-z.com/api/v1";
  static const String LOGIN = "$BASEURL/users/signin";
  static const String SIGNUP = "$BASEURL/users/";
  static const String ADDENTERPRISEURL = "$BASEURL/entreprises";
  static const String GETENTERPRISE = "$BASEURL/entreprises";
  static const String EDITADDRESS = "$BASEURL/address/";
  static const String EDITBANK = "$BASEURL/bank-account/";
  static const String UPDATEENTREPRS = "$BASEURL/entreprises/";
  static const String ADDAPARTIMAGE = "$BASEURL/appartements/images/";
  static const String GETAPARTURL = "$BASEURL/appartements";
  static const String ADDAPART = "$BASEURL/appartements";
  static const String EDITAPARTIMAGE = "$BASEURL/appartements/images/";
  static const String EDITADDRESSURL = "$BASEURL/appartements/address/";
  static const String ADDTENANT = "$BASEURL/landlords";
  static const String EDITTENANT = "$BASEURL/landlords/";
  static const String EDITTENANTPHONE = "$BASEURL/landlords/phones/";
  static const String GETTENANT = "$BASEURL/landlords";
  static const String CONTRATTENANT = "$BASEURL/rental-contrats";
  static const String DAILYCONTRATTENANT = "$BASEURL/daily-contract";
  static const String GETRECOVERYINFO = "$BASEURL/recoveries";
  static const String PAYERENT = "$BASEURL/payments";
  static const String GETPAYEMENT = "$BASEURL/payments";
  static const String GETPAYEMENTPERRECOVERY = "$BASEURL/payments/historical/";
  static const String BREACKCONTRAT = "$BASEURL/rental-contrats/break/";
}
