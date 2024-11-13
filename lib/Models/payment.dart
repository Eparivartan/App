// class Payment {
//   String? authId;
//   String? authorization;
//   String? bankReference;
//   int? cfPaymentId;
//   String? entity;
//   String? errorDetails;
//   bool? isCaptured;
//   double? orderAmount;
//   String? orderId;
//   double? paymentAmount;
//   String? paymentCompletionTime;
//   String? paymentCurrency;
//   String? paymentGatewayDetails;
//   String? paymentGroup;
//   String? paymentMessage;
//   PaymentMethod? paymentMethod;
//   List<PaymentOffer>? paymentOffers;
//   String? paymentStatus;
//   String? paymentTime;
//
//   Payment({
//     this.authId,
//     this.authorization,
//     this.bankReference,
//     this.cfPaymentId,
//     this.entity,
//     this.errorDetails,
//     this.isCaptured,
//     this.orderAmount,
//     this.orderId,
//     this.paymentAmount,
//     this.paymentCompletionTime,
//     this.paymentCurrency,
//     this.paymentGatewayDetails,
//     this.paymentGroup,
//     this.paymentMessage,
//     this.paymentMethod,
//     this.paymentOffers,
//     this.paymentStatus,
//     this.paymentTime,
//   });
//
//   factory Payment.fromJson(Map<String, dynamic> json) {
//     return Payment(
//       authId: json['auth_id'],
//       authorization: json['authorization'],
//       bankReference: json['bank_reference'],
//       cfPaymentId: json['cf_payment_id'],
//       entity: json['entity'],
//       errorDetails: json['error_details'],
//       isCaptured: json['is_captured'],
//       orderAmount: json['order_amount'],
//       orderId: json['order_id'],
//       paymentAmount: json['payment_amount'],
//       paymentCompletionTime: json['payment_completion_time'],
//       paymentCurrency: json['payment_currency'],
//       paymentGatewayDetails: json['payment_gateway_details'],
//       paymentGroup: json['payment_group'],
//       paymentMessage: json['payment_message'],
//       paymentMethod: PaymentMethod.fromJson(json['payment_method']),
//       paymentOffers: List<PaymentOffer>.from(json['payment_offers'].map((x) => PaymentOffer.fromJson(x))),
//       paymentStatus: json['payment_status'],
//       paymentTime: json['payment_time'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['auth_id'] = authId;
//     data['authorization'] = authorization;
//     data['bank_reference'] = bankReference;
//     data['cf_payment_id'] = cfPaymentId;
//     data['entity'] = entity;
//     data['error_details'] = errorDetails;
//     data['is_captured'] = isCaptured;
//     data['order_amount'] = orderAmount;
//     data['order_id'] = orderId;
//     data['payment_amount'] = paymentAmount;
//     data['payment_completion_time'] = paymentCompletionTime;
//     data['payment_currency'] = paymentCurrency;
//     data['payment_gateway_details'] = paymentGatewayDetails;
//     data['payment_group'] = paymentGroup;
//     data['payment_message'] = paymentMessage;
//     data['payment_method'] = paymentMethod?.toJson();
//     data['payment_offers'] = paymentOffers?.map((x) => x.toJson()).toList();
//     data['payment_status'] = paymentStatus;
//     data['payment_time'] = paymentTime;
//     return data;
//   }
// }
//
// class PaymentMethod {
//   Upi? upi;
//
//   PaymentMethod({this.upi});
//
//   factory PaymentMethod.fromJson(Map<String, dynamic> json) {
//     return PaymentMethod(
//       upi: Upi.fromJson(json['upi']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['upi'] = upi?.toJson();
//     return data;
//   }
// }

//
class PaymentModel {
  String? auth_id;
  String? cf_payment_id;
  String? order_amount;
  String? order_id;
  String? payment_amount;
  String? payment_time;
  String? payment_status;

  PaymentModel(
    this.auth_id,
    this.cf_payment_id,
    this.order_amount,
    this.order_id,
    this.payment_amount,
    this.payment_time,
    this.payment_status,
  );

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      json['auth_id'] ?? '',
      json['cf_payment_id'] ?? '',
      json['order_amount'] ?? '',
      json['order_id'] ?? '',
      json['payment_amount'] ?? '',
      json['payment_time'] ?? '',
      json['payment_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth_id': auth_id,
      'cf_payment_id': cf_payment_id,
      'order_amount': order_amount,
      'order_id': order_id,
      'payment_amount': payment_amount,
      'payment_time': payment_time,
      'payment_status': payment_status,
    };
  }
}
