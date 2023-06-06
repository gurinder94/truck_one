// To parse this JSON data, do
//
//     final validateReceiptIosModel = validateReceiptIosModelFromJson(jsonString);

import 'dart:convert';

ValidateReceiptIosModel validateReceiptIosModelFromJson(String str) =>
    ValidateReceiptIosModel.fromJson(json.decode(str));

String validateReceiptIosModelToJson(ValidateReceiptIosModel data) =>
    json.encode(data.toJson());

class ValidateReceiptIosModel {
  ValidateReceiptIosModel({
    required this.environment,
    required this.receipt,
    required this.latestReceiptInfo,
    required this.latestReceipt,
    required this.pendingRenewalInfo,
    required this.status,
  });

  String environment;
  Receipt receipt;
  List<LatestReceiptInfo> latestReceiptInfo;
  String latestReceipt;
  List<PendingRenewalInfo> pendingRenewalInfo;
  int status;

  factory ValidateReceiptIosModel.fromJson(Map<String, dynamic> json) =>
      ValidateReceiptIosModel(
        environment: json["environment"]==null?"":json["environment"],
        receipt: Receipt.fromJson(json["receipt"]),
        latestReceiptInfo: List<LatestReceiptInfo>.from(
            json["latest_receipt_info"]
                .map((x) => LatestReceiptInfo.fromJson(x))),
        latestReceipt: json["latest_receipt"],
        pendingRenewalInfo: List<PendingRenewalInfo>.from(
            json["pending_renewal_info"]
                .map((x) => PendingRenewalInfo.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "environment": environment,
    "receipt": receipt.toJson(),
    "latest_receipt_info":
    List<dynamic>.from(latestReceiptInfo.map((x) => x.toJson())),
    "latest_receipt": latestReceipt,
    "pending_renewal_info":
    List<dynamic>.from(pendingRenewalInfo.map((x) => x.toJson())),
    "status": status,
  };
}

class LatestReceiptInfo {
  LatestReceiptInfo({
    this.quantity,
    this.productId,
    this.transactionId,
    this.originalTransactionId,
    this.purchaseDate,
    this.purchaseDateMs,
    this.purchaseDatePst,
    this.originalPurchaseDate,
    this.originalPurchaseDateMs,
    this.originalPurchaseDatePst,
    this.expiresDate,
    this.expiresDateMs,
    this.expiresDatePst,
    this.webOrderLineItemId,
    this.isTrialPeriod,
    this.isInIntroOfferPeriod,
    this.inAppOwnershipType,
    this.subscriptionGroupIdentifier,
  });

  String? quantity;
  String? productId;
  String? transactionId;
  String? originalTransactionId;
  String? purchaseDate;
  String? purchaseDateMs;
  String? purchaseDatePst;
  String? originalPurchaseDate;
  String? originalPurchaseDateMs;
  String? originalPurchaseDatePst;
  String? expiresDate;
  String? expiresDateMs;
  String? expiresDatePst;
  String? webOrderLineItemId;
  String? isTrialPeriod;
  String? isInIntroOfferPeriod;
  String? inAppOwnershipType;
  String? subscriptionGroupIdentifier;

  factory LatestReceiptInfo.fromJson(Map<String, dynamic> json) =>
      LatestReceiptInfo(
        quantity: json["quantity"],
        productId: json["product_id"],
        transactionId: json["transaction_id"],
        originalTransactionId: json["original_transaction_id"],
        purchaseDate: json["purchase_date"],
        purchaseDateMs: json["purchase_date_ms"],
        purchaseDatePst: json["purchase_date_pst"],
        originalPurchaseDate: json["original_purchase_date"],
        originalPurchaseDateMs: json["original_purchase_date_ms"],
        originalPurchaseDatePst: json["original_purchase_date_pst"],
        expiresDate: json["expires_date"] == null ? "" : json["expires_date"],
        expiresDateMs: json["expires_date_ms"]==null?"":json["expires_date_ms"],
        expiresDatePst: json["expires_date_pst"]==null?"":json["expires_date_pst"],
        webOrderLineItemId: json["web_order_line_item_id"],
        isTrialPeriod: json["is_trial_period"],
        isInIntroOfferPeriod: json["is_in_intro_offer_period"],
        inAppOwnershipType: json["in_app_ownership_type"],
        subscriptionGroupIdentifier: json["subscription_group_identifier"],
      );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "product_id": productId,
    "transaction_id": transactionId,
    "original_transaction_id": originalTransactionId,
    "purchase_date": purchaseDate,
    "purchase_date_ms": purchaseDateMs,
    "purchase_date_pst": purchaseDatePst,
    "original_purchase_date": originalPurchaseDate,
    "original_purchase_date_ms": originalPurchaseDateMs,
    "original_purchase_date_pst": originalPurchaseDatePst,
    "expires_date": expiresDate,
    "expires_date_ms": expiresDateMs,
    "expires_date_pst": expiresDatePst,
    "web_order_line_item_id": webOrderLineItemId,
    "is_trial_period": isTrialPeriod,
    "is_in_intro_offer_period": isInIntroOfferPeriod,
    "in_app_ownership_type": inAppOwnershipType,
    "subscription_group_identifier": subscriptionGroupIdentifier,
  };
}

class PendingRenewalInfo {
  PendingRenewalInfo({
    required this.autoRenewProductId,
    required this.productId,
    required this.originalTransactionId,
    required this.autoRenewStatus,
  });

  String autoRenewProductId;
  String productId;
  String originalTransactionId;
  String autoRenewStatus;

  factory PendingRenewalInfo.fromJson(Map<String, dynamic> json) =>
      PendingRenewalInfo(
        autoRenewProductId: json["auto_renew_product_id"],
        productId: json["product_id"],
        originalTransactionId: json["original_transaction_id"],
        autoRenewStatus: json["auto_renew_status"],
      );

  Map<String, dynamic> toJson() => {
    "auto_renew_product_id": autoRenewProductId,
    "product_id": productId,
    "original_transaction_id": originalTransactionId,
    "auto_renew_status": autoRenewStatus,
  };
}

class Receipt {
  Receipt({
    required this.receiptType,
    required this.adamId,
    required this.appItemId,
    required this.bundleId,
    required this.applicationVersion,
    required this.downloadId,
    required this.versionExternalIdentifier,
    required this.receiptCreationDate,
    required this.receiptCreationDateMs,
    required this.receiptCreationDatePst,
    required this.requestDate,
    required this.requestDateMs,
    required this.requestDatePst,
    required this.originalPurchaseDate,
    required this.originalPurchaseDateMs,
    required this.originalPurchaseDatePst,
    required this.originalApplicationVersion,
    required this.inApp,
  });

  String receiptType;
  int adamId;
  int appItemId;
  String bundleId;
  String applicationVersion;
  int downloadId;
  int versionExternalIdentifier;
  String receiptCreationDate;
  String receiptCreationDateMs;
  String receiptCreationDatePst;
  String requestDate;
  String requestDateMs;
  String requestDatePst;
  String originalPurchaseDate;
  String originalPurchaseDateMs;
  String originalPurchaseDatePst;
  String originalApplicationVersion;
  List<LatestReceiptInfo> inApp;

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
    receiptType: json["receipt_type"],
    adamId: json["adam_id"],
    appItemId: json["app_item_id"],
    bundleId: json["bundle_id"],
    applicationVersion: json["application_version"],
    downloadId: json["download_id"],
    versionExternalIdentifier: json["version_external_identifier"],
    receiptCreationDate: json["receipt_creation_date"],
    receiptCreationDateMs: json["receipt_creation_date_ms"],
    receiptCreationDatePst: json["receipt_creation_date_pst"],
    requestDate: json["request_date"],
    requestDateMs: json["request_date_ms"],
    requestDatePst: json["request_date_pst"],
    originalPurchaseDate: json["original_purchase_date"],
    originalPurchaseDateMs: json["original_purchase_date_ms"],
    originalPurchaseDatePst: json["original_purchase_date_pst"],
    originalApplicationVersion: json["original_application_version"],
    inApp: List<LatestReceiptInfo>.from(
        json["in_app"].map((x) => LatestReceiptInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "receipt_type": receiptType,
    "adam_id": adamId,
    "app_item_id": appItemId,
    "bundle_id": bundleId,
    "application_version": applicationVersion,
    "download_id": downloadId,
    "version_external_identifier": versionExternalIdentifier,
    "receipt_creation_date": receiptCreationDate,
    "receipt_creation_date_ms": receiptCreationDateMs,
    "receipt_creation_date_pst": receiptCreationDatePst,
    "request_date": requestDate,
    "request_date_ms": requestDateMs,
    "request_date_pst": requestDatePst,
    "original_purchase_date": originalPurchaseDate,
    "original_purchase_date_ms": originalPurchaseDateMs,
    "original_purchase_date_pst": originalPurchaseDatePst,
    "original_application_version": originalApplicationVersion,
    "in_app": List<dynamic>.from(inApp.map((x) => x.toJson())),
  };
}
