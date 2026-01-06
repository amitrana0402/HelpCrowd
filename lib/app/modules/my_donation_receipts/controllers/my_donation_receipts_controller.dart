import 'package:get/get.dart';
import '../../../data/models/donation_receipt_model.dart';

class MyDonationReceiptsController extends GetxController {
  final donationReceipts = <DonationReceiptModel>[
    DonationReceiptModel(
      id: '1',
      invoiceNumber: 'INV #13540950135',
      date: '31/7/18',
    ),
    DonationReceiptModel(
      id: '2',
      invoiceNumber: 'INV #13540950134',
      date: '31/6/18',
    ),
    DonationReceiptModel(
      id: '3',
      invoiceNumber: 'INV #13540950133',
      date: '31/5/18',
    ),
    DonationReceiptModel(
      id: '4',
      invoiceNumber: 'INV #13540950132',
      date: '31/4/18',
    ),
    DonationReceiptModel(
      id: '5',
      invoiceNumber: 'INV #13540950131',
      date: '31/3/18',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onBackTap() {
    Get.back();
  }

  void onReceiptTap(DonationReceiptModel receipt) {
    // TODO: Navigate to receipt detail
  }
}

