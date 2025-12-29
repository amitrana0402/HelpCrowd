import 'package:get/get.dart';
import '../../../data/models/donation_model.dart';

class MyDonationsController extends GetxController {
  final adhocDonations = <DonationModel>[
    DonationModel(
      id: '1',
      name: 'HELPCROWD',
      date: 'May 15, 2025',
      amount: 15.00,
      iconUrl: '',
      type: DonationType.adhoc,
    ),
  ].obs;

  final roundOffDonations = <DonationModel>[
    DonationModel(
      id: '2',
      name: 'AUSTRALIA FOOD RELIEF',
      date: 'May 15, 2025',
      amount: 3.34,
      iconUrl: '',
      type: DonationType.roundOff,
    ),
    DonationModel(
      id: '3',
      name: 'HELPCROWD AID DISTRIBUTION PROJECT',
      date: 'May 15, 2025',
      amount: 3.34,
      iconUrl: '',
      type: DonationType.roundOff,
    ),
    DonationModel(
      id: '4',
      name: 'CRITICAL NEEDS IN MYANMAR',
      date: 'May 15, 2025',
      amount: 3.34,
      iconUrl: '',
      type: DonationType.roundOff,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onBackTap() {
    Get.back();
  }

  void onViewInvoiceTap() {
    // TODO: Navigate to invoice view
  }
}

