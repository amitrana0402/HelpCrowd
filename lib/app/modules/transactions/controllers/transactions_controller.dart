import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/models/donation_model.dart';

class TransactionsController extends GetxController {
  final selectedTabIndex = 0.obs; // 0 = Transactions, 1 = Donations

  // Transaction summary data
  final donatedThisMonth = 17.25.obs;
  final spentThisMonth = 4207.01.obs;

  // Donation summary data
  final donationsFor2025 = 3694.10.obs;
  final taxSaving = 208.23.obs;
  final taxRate = 30.obs;

  // Transaction list
  final transactions = <TransactionModel>[
    TransactionModel(
      id: '1',
      name: 'Vodafone North Sydney NS AUS',
      date: 'January 12, 2025',
      amount: -101.85,
      donationAmount: 0.50,
      iconType: 'spreadsheet',
      iconColor: 'red',
    ),
    TransactionModel(
      id: '2',
      name: 'Crown Group AUS',
      date: 'January 23, 2025',
      amount: 830.00,
      donationAmount: 0.50,
      iconType: 'house',
      iconColor: 'green',
    ),
    TransactionModel(
      id: '3',
      name: 'Events Cinemas George Sydney AU',
      date: 'February 7, 2025',
      amount: -27.65,
      donationAmount: 0.50,
      iconType: 'theater',
      iconColor: 'purple',
    ),
    TransactionModel(
      id: '4',
      name: 'VGA Group Australia PTY',
      date: 'March 18, 2025',
      amount: -27.73,
      donationAmount: 0.50,
      iconType: 'wine',
      iconColor: 'blue',
    ),
    TransactionModel(
      id: '5',
      name: 'Transaction Example',
      date: 'April 1, 2025',
      amount: -50.00,
      donationAmount: 0.50,
      iconType: 'spreadsheet',
      iconColor: 'red',
    ),
  ].obs;

  // Donation list
  final donations = <DonationModel>[
    DonationModel(
      id: '1',
      name: 'HELPCROWD',
      date: 'May 15, 2025',
      amount: 15.00,
      iconUrl: '',
      type: DonationType.adhoc,
    ),
    DonationModel(
      id: '2',
      name: 'HELPCROWD',
      date: 'May 12, 2025',
      amount: 10.00,
      iconUrl: '',
      type: DonationType.adhoc,
    ),
    DonationModel(
      id: '3',
      name: 'HELPCROWD',
      date: 'May 9, 2025',
      amount: 17.00,
      iconUrl: '',
      type: DonationType.adhoc,
    ),
    DonationModel(
      id: '4',
      name: 'HELPCROWD',
      date: 'May 3, 2025',
      amount: 10.00,
      iconUrl: '',
      type: DonationType.adhoc,
    ),
    DonationModel(
      id: '5',
      name: 'HELPCROWD',
      date: 'May 1, 2025',
      amount: 25.00,
      iconUrl: '',
      type: DonationType.adhoc,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onTabChanged(int index) {
    selectedTabIndex.value = index;
  }

  void onFilterTap() {
    // TODO: Implement filter functionality
  }

  Color getIconColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return AppColors.transactionRed;
      case 'green':
        return AppColors.transactionGreen;
      case 'purple':
        return AppColors.transactionPurple;
      case 'blue':
        return AppColors.transactionBlue;
      default:
        return AppColors.grey;
    }
  }

  IconData getIconData(String iconType) {
    switch (iconType.toLowerCase()) {
      case 'spreadsheet':
        return Icons.table_chart;
      case 'house':
        return Icons.home;
      case 'theater':
        return Icons.movie;
      case 'wine':
        return Icons.wine_bar;
      default:
        return Icons.receipt;
    }
  }
}
