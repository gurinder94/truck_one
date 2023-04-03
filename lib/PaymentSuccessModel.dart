// To parse this JSON data, do
//
//     final paymentSuccessModel = paymentSuccessModelFromJson(jsonString);

import 'dart:convert';

PaymentSuccessModel paymentSuccessModelFromJson(String str) => PaymentSuccessModel.fromJson(json.decode(str));

String paymentSuccessModelToJson(PaymentSuccessModel data) => json.encode(data.toJson());

class PaymentSuccessModel {
  PaymentSuccessModel({
    this.id,
    this.object,
    this.lastPaymentError,
    this.livemode,
    this.nextAction,
    this.status,
    this.amount,
    this.amountCapturable,
    this.amountDetails,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.charges,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.metadata,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.transferData,
    this.transferGroup,
  });

  String? id;
  String ?object;
  dynamic lastPaymentError;
  bool ?livemode;
  dynamic nextAction;
  String ?status;
  int? amount;
  int? amountCapturable;
  AmountDetails? amountDetails;
  int? amountReceived;
  dynamic application;
  dynamic applicationFeeAmount;
  dynamic automaticPaymentMethods;
  dynamic canceledAt;
  dynamic cancellationReason;
  String ?captureMethod;
  Charges ?charges;
  String ?clientSecret;
  String ?confirmationMethod;
  int ?created;
  String ?currency;
  dynamic customer;
  dynamic description;
  dynamic invoice;
  Metadata? metadata;
  dynamic onBehalfOf;
  String ?paymentMethod;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  dynamic processing;
  dynamic receiptEmail;
  dynamic review;
  dynamic setupFutureUsage;
  dynamic shipping;
  dynamic source;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  dynamic transferData;
  dynamic transferGroup;

  factory PaymentSuccessModel.fromJson(Map<String, dynamic> json) => PaymentSuccessModel(
    id: json["id"],
    object: json["object"],
    lastPaymentError: json["last_payment_error"],
    livemode: json["livemode"],
    nextAction: json["next_action"],
    status: json["status"],
    amount: json["amount"],
    amountCapturable: json["amount_capturable"],
    amountDetails: AmountDetails.fromJson(json["amount_details"]),
    amountReceived: json["amount_received"],
    application: json["application"],
    applicationFeeAmount: json["application_fee_amount"],
    automaticPaymentMethods: json["automatic_payment_methods"],
    canceledAt: json["canceled_at"],
    cancellationReason: json["cancellation_reason"],
    captureMethod: json["capture_method"],
    charges: Charges.fromJson(json["charges"]),
    clientSecret: json["client_secret"],
    confirmationMethod: json["confirmation_method"],
    created: json["created"],
    currency: json["currency"],
    customer: json["customer"],
    description: json["description"],
    invoice: json["invoice"],
    metadata: Metadata.fromJson(json["metadata"]),
    onBehalfOf: json["on_behalf_of"],
    paymentMethod: json["payment_method"],
    paymentMethodOptions: PaymentMethodOptions.fromJson(json["payment_method_options"]),
    paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
    processing: json["processing"],
    receiptEmail: json["receipt_email"],
    review: json["review"],
    setupFutureUsage: json["setup_future_usage"],
    shipping: json["shipping"],
    source: json["source"],
    statementDescriptor: json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"],
    transferData: json["transfer_data"],
    transferGroup: json["transfer_group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "last_payment_error": lastPaymentError,
    "livemode": livemode,
    "next_action": nextAction,
    "status": status,
    "amount": amount,
    "amount_capturable": amountCapturable,
    "amount_details": amountDetails!.toJson(),
    "amount_received": amountReceived,
    "application": application,
    "application_fee_amount": applicationFeeAmount,
    "automatic_payment_methods": automaticPaymentMethods,
    "canceled_at": canceledAt,
    "cancellation_reason": cancellationReason,
    "capture_method": captureMethod,
    "charges": charges!.toJson(),
    "client_secret": clientSecret,
    "confirmation_method": confirmationMethod,
    "created": created,
    "currency": currency,
    "customer": customer,
    "description": description,
    "invoice": invoice,
    "metadata": metadata!.toJson(),
    "on_behalf_of": onBehalfOf,
    "payment_method": paymentMethod,
    "payment_method_options": paymentMethodOptions!.toJson(),
    "payment_method_types": List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
    "processing": processing,
    "receipt_email": receiptEmail,
    "review": review,
    "setup_future_usage": setupFutureUsage,
    "shipping": shipping,
    "source": source,
    "statement_descriptor": statementDescriptor,
    "statement_descriptor_suffix": statementDescriptorSuffix,
    "transfer_data": transferData,
    "transfer_group": transferGroup,
  };
}

class AmountDetails {
  AmountDetails({
    this.tip,
  });

  Metadata ?tip;

  factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
    tip: Metadata.fromJson(json["tip"]),
  );

  Map<String, dynamic> toJson() => {
    "tip": tip!.toJson(),
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Datum {
  Datum({
    this.id,
    this.object,
    this.amount,
    this.amountCaptured,
    this.amountRefunded,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    this.balanceTransaction,
    this.billingDetail,
    this.calculatedStatementDescriptor,
    this.captured,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.destination,
    this.dispute,
    this.disputed,
    this.failureBalanceTransaction,
    this.failureCode,
    this.failureMessage,
    this.fraudDetails,
    this.invoice,
    this.livemode,
    this.metadata,
    this.onBehalfOf,
    this.order,
    this.outcome,
    this.paid,
    this.paymentIntent,
    this.paymentMethod,
    this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    this.receiptUrl,
    this.refunded,
    this.refunds,
    this.review,
    this.shipping,
    this.source,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  String ?id;
  String ?object;
  int ?amount;
  int ?amountCaptured;
  int ?amountRefunded;
  dynamic application;
  dynamic applicationFee;
  dynamic applicationFeeAmount;
  String? balanceTransaction;
  BillingDetail? billingDetail;
  String ?calculatedStatementDescriptor;
  bool ?captured;
  int ?created;
  String? currency;
  dynamic customer;
  dynamic description;
  dynamic destination;
  dynamic dispute;
  bool ?disputed;
  dynamic failureBalanceTransaction;
  dynamic failureCode;
  dynamic failureMessage;
  Metadata ?fraudDetails;
  dynamic invoice;
  bool? livemode;
  Metadata? metadata;
  dynamic onBehalfOf;
  dynamic order;
  Outcome? outcome;
  bool ?paid;
  String ?paymentIntent;
  String ?paymentMethod;
  PaymentMethodDetails? paymentMethodDetails;
  dynamic receiptEmail;
  dynamic receiptNumber;
  String ?receiptUrl;
  bool ?refunded;
  Charges ?refunds;
  dynamic review;
  dynamic shipping;
  dynamic source;
  dynamic sourceTransfer;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String ?status;
  dynamic transferData;
  dynamic transferGroup;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    object: json["object"],
    amount: json["amount"],
    amountCaptured: json["amount_captured"],
    amountRefunded: json["amount_refunded"],
    application: json["application"],
    applicationFee: json["application_fee"],
    applicationFeeAmount: json["application_fee_amount"],
    balanceTransaction: json["balance_transaction"],
    billingDetail: BillingDetail.fromJson(json["billing_details"]),
    calculatedStatementDescriptor: json["calculated_statement_descriptor"],
    captured: json["captured"],
    created: json["created"],
    currency: json["currency"],
    customer: json["customer"],
    description: json["description"],
    destination: json["destination"],
    dispute: json["dispute"],
    disputed: json["disputed"],
    failureBalanceTransaction: json["failure_balance_transaction"],
    failureCode: json["failure_code"],
    failureMessage: json["failure_message"],
    fraudDetails: Metadata.fromJson(json["fraud_details"]),
    invoice: json["invoice"],
    livemode: json["livemode"],
    metadata: Metadata.fromJson(json["metadata"]),
    onBehalfOf: json["on_behalf_of"],
    order: json["order"],
    outcome: Outcome.fromJson(json["outcome"]),
    paid: json["paid"],
    paymentIntent: json["payment_intent"],
    paymentMethod: json["payment_method"],
    paymentMethodDetails: PaymentMethodDetails.fromJson(json["payment_method_details"]),
    receiptEmail: json["receipt_email"],
    receiptNumber: json["receipt_number"],
    receiptUrl: json["receipt_url"],
    refunded: json["refunded"],
    refunds: Charges.fromJson(json["refunds"]),
    review: json["review"],
    shipping: json["shipping"],
    source: json["source"],
    sourceTransfer: json["source_transfer"],
    statementDescriptor: json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"],
    status: json["status"],
    transferData: json["transfer_data"],
    transferGroup: json["transfer_group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "amount": amount,
    "amount_captured": amountCaptured,
    "amount_refunded": amountRefunded,
    "application": application,
    "application_fee": applicationFee,
    "application_fee_amount": applicationFeeAmount,
    "balance_transaction": balanceTransaction,
    "billing_detail": billingDetail!.toJson(),
    "calculated_statement_descriptor": calculatedStatementDescriptor,
    "captured": captured,
    "created": created,
    "currency": currency,
    "customer": customer,
    "description": description,
    "destination": destination,
    "dispute": dispute,
    "disputed": disputed,
    "failure_balance_transaction": failureBalanceTransaction,
    "failure_code": failureCode,
    "failure_message": failureMessage,
    "fraud_details": fraudDetails!.toJson(),
    "invoice": invoice,
    "livemode": livemode,
    "metadata": metadata!.toJson(),
    "on_behalf_of": onBehalfOf,
    "order": order,
    "outcome": outcome!.toJson(),
    "paid": paid,
    "payment_intent": paymentIntent,
    "payment_method": paymentMethod,
    "payment_method_details": paymentMethodDetails!.toJson(),
    "receipt_email": receiptEmail,
    "receipt_number": receiptNumber,
    "receipt_url": receiptUrl,
    "refunded": refunded,
    "refunds": refunds!.toJson(),
    "review": review,
    "shipping": shipping,
    "source": source,
    "source_transfer": sourceTransfer,
    "statement_descriptor": statementDescriptor,
    "statement_descriptor_suffix": statementDescriptorSuffix,
    "status": status,
    "transfer_data": transferData,
    "transfer_group": transferGroup,
  };
}

class Charges {
  Charges({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  String ?object;
  List<Datum>? data;
  bool ?hasMore;
  int ?totalCount;
  String ?url;

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
    object: json["object"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    hasMore: json["has_more"],
    totalCount: json["total_count"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "has_more": hasMore,
    "total_count": totalCount,
    "url": url,
  };
}

class BillingDetail {
  BillingDetail({
    this.addres,
    this.email,
    this.name,
    this.phone,
  });

  Addres ?addres;
  dynamic email;
  dynamic name;
  dynamic phone;

  factory BillingDetail.fromJson(Map<String, dynamic> json) => BillingDetail(
    addres: Addres.fromJson(json["addres"]),
    email: json["email"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "addres": addres!.toJson(),
    "email": email,
    "name": name,
    "phone": phone,
  };
}

class Addres {
  Addres({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  dynamic city;
  String ?country;
  dynamic line1;
  dynamic line2;
  String ?postalCode;
  dynamic state;

  factory Addres.fromJson(Map<String, dynamic> json) => Addres(
    city: json["city"],
    country: json["country"],
    line1: json["line1"],
    line2: json["line2"],
    postalCode: json["postal_code"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "line1": line1,
    "line2": line2,
    "postal_code": postalCode,
    "state": state,
  };
}

class Outcome {
  Outcome({
    this.networkStatus,
    this.reason,
    this.riskLevel,
    this.riskScore,
    this.sellerMessage,
    this.type,
  });

  String ?networkStatus;
  dynamic reason;
  String ?riskLevel;
  int ?riskScore;
  String ?sellerMessage;
  String ?type;

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
    networkStatus: json["network_status"],
    reason: json["reason"],
    riskLevel: json["risk_level"],
    riskScore: json["risk_score"],
    sellerMessage: json["seller_message"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "network_status": networkStatus,
    "reason": reason,
    "risk_level": riskLevel,
    "risk_score": riskScore,
    "seller_message": sellerMessage,
    "type": type,
  };
}

class PaymentMethodDetails {
  PaymentMethodDetails({
    this.card,
    this.type,
  });

  PaymentMethodDetailsCard ?card;
  String ?type;

  factory PaymentMethodDetails.fromJson(Map<String, dynamic> json) => PaymentMethodDetails(
    card: PaymentMethodDetailsCard.fromJson(json["card"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "card": card!.toJson(),
    "type": type,
  };
}

class PaymentMethodDetailsCard {
  PaymentMethodDetailsCard({
    this.brand,
    this.checks,
    this.country,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.installments,
    this.last4,
    this.mandate,
    this.network,
    this.threeDSecure,
    this.wallet,
  });

  String ?brand;
  Checks ?checks;
  String ?country;
  int ?expMonth;
  int ?expYear;
  String ?fingerprint;
  String ?funding;
  dynamic installments;
  String ?last4;
  dynamic mandate;
  String ?network;
  dynamic threeDSecure;
  dynamic wallet;

  factory PaymentMethodDetailsCard.fromJson(Map<String, dynamic> json) => PaymentMethodDetailsCard(
    brand: json["brand"],
    checks: Checks.fromJson(json["checks"]),
    country: json["country"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: json["funding"],
    installments: json["installments"],
    last4: json["last4"],
    mandate: json["mandate"],
    network: json["network"],
    threeDSecure: json["three_d_secure"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "checks": checks!.toJson(),
    "country": country,
    "exp_month": expMonth,
    "exp_year": expYear,
    "fingerprint": fingerprint,
    "funding": funding,
    "installments": installments,
    "last4": last4,
    "mandate": mandate,
    "network": network,
    "three_d_secure": threeDSecure,
    "wallet": wallet,
  };
}

class Checks {
  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck,
  });

  dynamic addressLine1Check;
  String ?addressPostalCodeCheck;
  String ?cvcCheck;

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
    addressLine1Check: json["address_line1_check"],
    addressPostalCodeCheck: json["address_postal_code_check"],
    cvcCheck: json["cvc_check"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1_check": addressLine1Check,
    "address_postal_code_check": addressPostalCodeCheck,
    "cvc_check": cvcCheck,
  };
}

class PaymentMethodOptions {
  PaymentMethodOptions({
    this.card,
  });

  PaymentMethodOptionsCard? card;

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
    card: PaymentMethodOptionsCard.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "card": card!.toJson(),
  };
}

class PaymentMethodOptionsCard {
  PaymentMethodOptionsCard({
    this.installments,
    this.mandateOptions,
    this.network,
    this.requestThreeDSecure,
  });

  dynamic installments;
  dynamic mandateOptions;
  dynamic network;
  String ?requestThreeDSecure;

  factory PaymentMethodOptionsCard.fromJson(Map<String, dynamic> json) => PaymentMethodOptionsCard(
    installments: json["installments"],
    mandateOptions: json["mandate_options"],
    network: json["network"],
    requestThreeDSecure: json["request_three_d_secure"],
  );

  Map<String, dynamic> toJson() => {
    "installments": installments,
    "mandate_options": mandateOptions,
    "network": network,
    "request_three_d_secure": requestThreeDSecure,
  };
}
