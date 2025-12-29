import 'package:get/get.dart';
import '../../../data/models/news_model.dart';
import '../../../data/models/appeal_model.dart';

class HomeController extends GetxController {
  // Tab Management
  final selectedTabIndex = 0.obs;

  // News Tab
  final newsList = <NewsModel>[].obs;
  final isLoadingNews = false.obs;
  final hasMoreNews = true.obs;
  final currentNewsPage = 1.obs;
  final int newsPageSize = 10;

  // Appeals Tab
  final appealsList = <AppealModel>[].obs;
  final isLoadingAppeals = false.obs;
  final hasMoreAppeals = true.obs;
  final currentAppealsPage = 1.obs;
  final int appealsPageSize = 10;

  @override
  void onInit() {
    super.onInit();
    loadInitialNews();
    loadInitialAppeals();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Tab Management
  void onTabChanged(int index) {
    selectedTabIndex.value = index;
  }

  // News Methods
  Future<void> loadInitialNews() async {
    if (newsList.isEmpty) {
      await loadMoreNews();
    }
  }

  Future<void> loadMoreNews() async {
    if (isLoadingNews.value || !hasMoreNews.value) return;

    isLoadingNews.value = true;

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data generation
    final newNews = _generateMockNews(currentNewsPage.value, newsPageSize);
    newsList.addAll(newNews);

    // Simulate pagination - stop after 5 pages
    if (currentNewsPage.value >= 5) {
      hasMoreNews.value = false;
    } else {
      currentNewsPage.value++;
    }

    isLoadingNews.value = false;
  }

  List<NewsModel> _generateMockNews(int page, int pageSize) {
    final List<NewsModel> mockNews = [];
    final startIndex = (page - 1) * pageSize;

    for (int i = 0; i < pageSize; i++) {
      final index = startIndex + i;
      mockNews.add(
        NewsModel(
          id: 'news_$index',
          title: _getNewsTitle(index),
          description: _getNewsDescription(index),
          imageUrl: 'https://picsum.photos/400/300?random=$index',
          datePosted: _getMockDate(index),
          isFeatured: index == 0 && page == 1,
          isTopStory: index == 1 && page == 1,
          content: _getNewsContent(index),
        ),
      );
    }

    return mockNews;
  }

  String _getNewsTitle(int index) {
    final titles = [
      'Cost-of-Living Crisis Sees More Australians Rely on Food Relief',
      'HelpCrowd Partners with Local Shelters to Address Homelessness',
      'Innovative Aid Distribution Project Improving Access to Care',
      'HelpCrowd Responds to Critical Health Needs in Myanmar',
      'Community Support Programs Expand Across Regional Areas',
      'Emergency Relief Fund Reaches Record Donations',
      'New Partnership Brings Hope to Displaced Families',
      'Medical Supplies Delivered to Remote Communities',
      'Education Initiative Launched for Refugee Children',
      'Clean Water Project Completed in Rural Villages',
    ];
    return titles[index % titles.length];
  }

  String _getNewsDescription(int index) {
    final descriptions = [
      'HelpCrowd has announced a new micro-giving partnership with local homeless shelters to help tackle the region\'s growing homelessness crisis.',
      'HelpCrowd is funding a new initiative to streamline humanitarian aid delivery by leveraging cash transfers and digital technology.',
      'The humanitarian crisis in Myanmar continues to escalate, leading to devastating and urgent healthcare needs for local communities.',
      'HelpCrowd expands its reach to provide essential services to communities facing economic hardship and food insecurity.',
      'Record-breaking donations enable HelpCrowd to support more families in need across multiple regions.',
      'Strategic partnerships help deliver critical aid to families displaced by conflict and natural disasters.',
      'Mobile medical units provide essential healthcare services to communities with limited access to medical facilities.',
      'Educational programs help refugee children access quality learning opportunities and build brighter futures.',
      'Infrastructure improvements bring clean, safe water to thousands of families in underserved areas.',
      'Community-driven initiatives empower local leaders to address pressing social and economic challenges.',
    ];
    return descriptions[index % descriptions.length];
  }

  String _getMockDate(int index) {
    final daysAgo = index % 30;
    final date = DateTime.now().subtract(Duration(days: daysAgo));
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Posted ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _getNewsContent(int index) {
    final contents = [
      '''HelpCrowd is funding a new initiative to streamline humanitarian aid delivery by leveraging cash transfers and digital technology.

Traditional aid can be slow to reach those in need. Our project is piloting innovative cash-transfer programming in partnership with aid groups on the ground.

By using these smart, efficient delivery methods, HelpCrowd is improving access to care for vulnerable communities—faster, and with greater impact.''',
      '''HelpCrowd has announced a new micro-giving partnership with local homeless shelters to help tackle the region's growing homelessness crisis.

The partnership will provide essential support services including food, shelter, and medical care to those experiencing homelessness.

Through community collaboration and innovative funding models, we're working to create sustainable solutions for housing insecurity.''',
      '''HelpCrowd is funding a new initiative to streamline humanitarian aid delivery by leveraging cash transfers and digital technology.

Traditional aid can be slow to reach those in need. Our project is piloting innovative cash-transfer programming in partnership with aid groups on the ground.

By using these smart, efficient delivery methods, HelpCrowd is improving access to care for vulnerable communities—faster, and with greater impact.''',
      '''The humanitarian crisis in Myanmar continues to escalate, leading to devastating and urgent healthcare needs for local communities.

HelpCrowd is responding with emergency medical supplies, mobile health clinics, and support for local healthcare workers.

Our teams on the ground are working tirelessly to ensure critical care reaches those who need it most.''',
      '''HelpCrowd expands its reach to provide essential services to communities facing economic hardship and food insecurity.

Through partnerships with local organizations, we're delivering food assistance, financial support, and access to essential services.

Together, we're building resilience and hope in communities across the region.''',
    ];
    return contents[index % contents.length];
  }

  NewsModel? get featuredNews {
    try {
      return newsList.firstWhere((news) => news.isFeatured);
    } catch (e) {
      return null;
    }
  }

  List<NewsModel> get topStories {
    return newsList.where((news) => news.isTopStory).toList();
  }

  List<NewsModel> get regularNews {
    return newsList
        .where((news) => !(news.isFeatured || news.isTopStory))
        .toList();
  }

  // Appeals Methods
  Future<void> loadInitialAppeals() async {
    if (appealsList.isEmpty) {
      await loadMoreAppeals();
    }
  }

  Future<void> loadMoreAppeals() async {
    if (isLoadingAppeals.value || !hasMoreAppeals.value) return;

    isLoadingAppeals.value = true;

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data generation
    final newAppeals = _generateMockAppeals(
      currentAppealsPage.value,
      appealsPageSize,
    );
    appealsList.addAll(newAppeals);

    // Simulate pagination - stop after 5 pages
    if (currentAppealsPage.value >= 5) {
      hasMoreAppeals.value = false;
    } else {
      currentAppealsPage.value++;
    }

    isLoadingAppeals.value = false;
  }

  List<AppealModel> _generateMockAppeals(int page, int pageSize) {
    final List<AppealModel> mockAppeals = [];
    final startIndex = (page - 1) * pageSize;

    final titles = [
      'What\'s it like to work with HelpCrowd?',
      'Become a HelpCrowd Sponsor',
      'Help Change the World',
      'Support Emergency Relief Efforts',
      'Join Our Volunteer Program',
      'Make a Difference Today',
      'Help Families in Need',
      'Support Education Initiatives',
      'Contribute to Health Programs',
      'Partner with HelpCrowd',
    ];

    for (int i = 0; i < pageSize; i++) {
      final index = startIndex + i;
      mockAppeals.add(
        AppealModel(
          id: 'appeal_$index',
          title: titles[index % titles.length],
          imageUrl: 'https://picsum.photos/300/300?random=${index + 1000}',
          isSelected: false,
        ),
      );
    }

    return mockAppeals;
  }

  String? getAppealDate(int index) {
    if (index == 0) return 'June 17, 2025';
    if (index == 1) return null; // No date
    if (index == 2) return 'May 25, 2025';
    final daysAgo = index % 30;
    final date = DateTime.now().subtract(Duration(days: daysAgo));
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
