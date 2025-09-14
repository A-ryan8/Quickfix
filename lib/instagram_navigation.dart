import 'package:flutter/material.dart';
import 'upload_complaint_screen.dart';

class InstagramStyleNavigation extends StatefulWidget {
  const InstagramStyleNavigation({super.key});

  @override
  State<InstagramStyleNavigation> createState() => _InstagramStyleNavigationState();
}

class _InstagramStyleNavigationState extends State<InstagramStyleNavigation> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          InstagramHomeScreen(), // Home tab - shows Nearby Issues with Instagram styling
          SearchScreen(), // Search tab
          UploadComplaintScreen(), // Upload tab - existing screen
          NotificationsScreen(), // Notifications tab
          ProfileScreen(), // Profile tab
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  icon: Icons.home,
                  index: 0,
                  isSelected: _currentIndex == 0,
                ),
                _buildNavItem(
                  icon: Icons.search,
                  index: 1,
                  isSelected: _currentIndex == 1,
                ),
                _buildNavItem(
                  icon: Icons.add_box_outlined,
                  index: 2,
                  isSelected: _currentIndex == 2,
                ),
                _buildNavItem(
                  icon: Icons.notifications_outlined,
                  index: 3,
                  isSelected: _currentIndex == 3,
                ),
                _buildNavItem(
                  icon: Icons.person,
                  index: 4,
                  isSelected: _currentIndex == 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF1976D2).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected 
              ? const Color(0xFF1976D2)
              : Colors.grey.shade600,
          size: 24,
        ),
      ),
    );
  }
}

// Instagram-style Home Screen (Nearby Issues with Instagram styling)
class InstagramHomeScreen extends StatefulWidget {
  const InstagramHomeScreen({super.key});

  @override
  State<InstagramHomeScreen> createState() => _InstagramHomeScreenState();
}

class _InstagramHomeScreenState extends State<InstagramHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<IssuePost> _issues = _generateDummyIssues();
  bool _isDarkMode = false;
  final List<String> _seenPosts = []; // Track seen posts for stories

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _jumpToUserPost(String userId) {
    // Find the latest post by this user and scroll to it
    final userPosts = _issues.where((issue) => issue.reporterName == userId).toList();
    if (userPosts.isNotEmpty) {
      final latestPost = userPosts.first;
      final index = _issues.indexOf(latestPost);
      if (index != -1) {
        _scrollController.animateTo(
          index * 400.0, // Approximate height of each post
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    
    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom App Bar
            SliverAppBar(
              floating: false,
              pinned: true,
              backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              elevation: 0,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFDB8A5), Color(0xFFF55A73)],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // App name on the left
                        Text(
                          'QuickFix',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        // Icons on the right
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Dark mode toggle
                            IconButton(
                              onPressed: _toggleDarkMode,
                              icon: Icon(
                                _isDarkMode ? Icons.sunny : Icons.nightlight_round,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            // Settings icon
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SettingsPage(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Stories Row
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _issues.length,
                  itemBuilder: (context, index) {
                    final issue = _issues[index];
                    final isSeen = _seenPosts.contains(issue.id);
                    
                    return GestureDetector(
                      onTap: () {
                        _jumpToUserPost(issue.reporterName);
                        if (!isSeen) {
                          setState(() {
                            _seenPosts.add(issue.id);
                          });
                        }
                      },
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            // Story circle
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSeen ? Colors.grey.shade400 : Colors.red,
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 27,
                                backgroundColor: const Color(0xFF1976D2).withOpacity(0.1),
                                child: Text(
                                  issue.reporterName[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // User name
                            Text(
                              issue.reporterName,
                              style: TextStyle(
                                fontSize: 12,
                                color: _isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Posts Feed
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _InstagramIssuePostCard(
                    issue: _issues[index],
                    isDarkMode: _isDarkMode,
                  );
                },
                childCount: _issues.length,
              ),
            ),
            // Bottom padding for navigation bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

// Instagram-style Issue Post Card with thumbs-up button
class _InstagramIssuePostCard extends StatefulWidget {
  final IssuePost issue;
  final bool isDarkMode;

  const _InstagramIssuePostCard({
    required this.issue,
    this.isDarkMode = false,
  });

  @override
  State<_InstagramIssuePostCard> createState() => _InstagramIssuePostCardState();
}

class _InstagramIssuePostCardState extends State<_InstagramIssuePostCard>
    with TickerProviderStateMixin {
  late AnimationController _likeController;
  late AnimationController _scaleController;
  late Animation<double> _likeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.issue.voteCount;
    
    _likeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _likeAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _likeController, curve: Curves.elasticOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
    
    if (_isLiked) {
      _likeController.forward().then((_) => _likeController.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = widget.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(widget.isDarkMode ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF1976D2).withOpacity(0.1),
                  child: Text(
                    widget.issue.reporterName[0].toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.issue.reporterName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: textColor,
                        ),
                      ),
                      Text(
                        widget.issue.timeAgo,
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status indicator
                if (widget.issue.status == 'pending')
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  )
                else if (widget.issue.status == 'resolved')
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                const SizedBox(width: 8),
                _PostDropdownMenu(
                  issue: widget.issue,
                  isDarkMode: widget.isDarkMode,
                ),
              ],
            ),
          ),
          
          // Location (on top of post)
          if (widget.issue.location.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: secondaryTextColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.issue.location,
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          
          // Image/Video
          GestureDetector(
            onTap: () {
              _scaleController.forward().then((_) => _scaleController.reverse());
            },
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                    ),
                    child: ClipRRect(
                      child: widget.issue.imageUrl.isNotEmpty
                          ? Image.asset(
                              widget.issue.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: widget.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 50,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: widget.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: secondaryTextColor,
                                ),
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _toggleLike,
                  child: AnimatedBuilder(
                    animation: _likeAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _likeAnimation.value,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                              color: _isLiked ? const Color(0xFF1976D2) : secondaryTextColor,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$_likeCount',
                              style: TextStyle(
                                color: _isLiked ? const Color(0xFF1976D2) : secondaryTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.comment_outlined,
                  color: secondaryTextColor,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.share_outlined,
                  color: secondaryTextColor,
                  size: 28,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.issue.severity == 'High'
                        ? Colors.red.withOpacity(0.1)
                        : widget.issue.severity == 'Medium'
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.issue.severity,
                    style: TextStyle(
                      color: widget.issue.severity == 'High'
                          ? Colors.red
                          : widget.issue.severity == 'Medium'
                              ? Colors.orange
                              : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Description/Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${widget.issue.reporterName} ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: widget.issue.description,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Search Screen
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search issues...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Search results will appear here',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Notifications Screen
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      'User123 liked your post',
      'Admin updated status of your report',
      'New issue reported near you',
      'Your report has been resolved',
      'Community member commented on your post',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF1976D2).withOpacity(0.1),
                  child: const Icon(
                    Icons.notifications,
                    color: Color(0xFF1976D2),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    notifications[index],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${index + 1}h ago',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock data for user profile
  final String username = 'Username';
  final int totalComplaints = 12;
  final int resolvedComplaints = 8;
  final int pendingComplaints = 3;
  final int rejectedComplaints = 1;

  // Mock complaint data
  final List<Map<String, dynamic>> mockComplaints = [
    {
      'id': '1',
      'title': 'Broken Street Light',
      'description': 'Street light not working on Main Street near the park',
      'status': 'Resolved',
      'date': '2024-01-15',
      'time': '2:30 PM',
      'image': 'assets/images/pole image.webp',
    },
    {
      'id': '2',
      'title': 'Water Leak Report',
      'description': 'Water leaking from underground pipe on Oak Avenue',
      'status': 'In Progress',
      'date': '2024-01-12',
      'time': '10:15 AM',
      'image': 'assets/images/water leak image.jpeg',
    },
    {
      'id': '3',
      'title': 'Pothole on Highway',
      'description': 'Large pothole causing traffic issues on Route 101',
      'status': 'Pending',
      'date': '2024-01-10',
      'time': '4:45 PM',
      'image': 'assets/images/2ndroadimadge.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isLargeScreen ? 28 : 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            _buildProfileHeader(),
            SizedBox(height: isLargeScreen ? 32 : screenWidth * 0.05),
            
            // Stats Bar
            _buildStatsBar(),
            SizedBox(height: isLargeScreen ? 40 : screenWidth * 0.08),
            
            // My Complaints Section - Responsive layout
            _buildComplaintsSection(),
            SizedBox(height: isLargeScreen ? 32 : 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        children: [
          // Profile Photo with Edit Option
          Stack(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.16,
                backgroundColor: const Color(0xFF1976D2).withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: screenWidth * 0.16,
                  color: const Color(0xFF1976D2),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Handle edit photo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit photo functionality')),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.015),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1976D2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.04),
          
          // Username - Responsive with FittedBox
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              username,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          
          // User Status
          Text(
            'Active Community Member',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: screenWidth * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 32 : screenWidth * 0.04,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use Wrap for very small screens to prevent overflow
          if (screenWidth < 400) {
            return Wrap(
              spacing: screenWidth * 0.015,
              runSpacing: screenWidth * 0.015,
              children: [
                SizedBox(
                  width: (constraints.maxWidth - screenWidth * 0.045) / 2,
                  child: _buildStatChip(
                    'Total\nComplaints',
                    totalComplaints.toString(),
                    const Color(0xFF1976D2),
                  ),
                ),
                SizedBox(
                  width: (constraints.maxWidth - screenWidth * 0.045) / 2,
                  child: _buildStatChip(
                    'Resolved',
                    resolvedComplaints.toString(),
                    const Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(
                  width: (constraints.maxWidth - screenWidth * 0.045) / 2,
                  child: _buildStatChip(
                    'Pending',
                    pendingComplaints.toString(),
                    const Color(0xFFFF9800),
                  ),
                ),
                SizedBox(
                  width: (constraints.maxWidth - screenWidth * 0.045) / 2,
                  child: _buildStatChip(
                    'Rejected',
                    rejectedComplaints.toString(),
                    const Color(0xFFF44336),
                  ),
                ),
              ],
            );
          }
          
          // Use Row for larger screens with reduced spacing
          return Row(
            children: [
              Expanded(
                child: _buildStatChip(
                  'Total\nComplaints',
                  totalComplaints.toString(),
                  const Color(0xFF1976D2),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: _buildStatChip(
                  'Resolved',
                  resolvedComplaints.toString(),
                  const Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: _buildStatChip(
                  'Pending',
                  pendingComplaints.toString(),
                  const Color(0xFFFF9800),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: _buildStatChip(
                  'Rejected',
                  rejectedComplaints.toString(),
                  const Color(0xFFF44336),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatChip(String label, String count, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;
    final isSmallScreen = screenWidth < 400;
    
    return Container(
      height: isLargeScreen ? 100 : isSmallScreen ? 70 : 80, // Responsive height
      padding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 16 : isSmallScreen ? 8 : screenWidth * 0.03, 
        horizontal: isLargeScreen ? 12 : isSmallScreen ? 6 : screenWidth * 0.015,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              count,
              style: TextStyle(
                fontSize: isLargeScreen ? 24 : isSmallScreen ? screenWidth * 0.045 : screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          SizedBox(height: isLargeScreen ? 8 : isSmallScreen ? 2 : screenWidth * 0.008),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isLargeScreen ? 14 : isSmallScreen ? screenWidth * 0.025 : screenWidth * 0.03,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplaintsSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;
    final isMediumScreen = screenWidth > 600;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 32 : screenWidth * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Complaints',
            style: TextStyle(
              fontSize: isLargeScreen ? 24 : screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: isLargeScreen ? 20 : screenWidth * 0.04),
          
          // Simple Column layout for mobile, Grid for larger screens
          isLargeScreen || isMediumScreen
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = isLargeScreen ? 3 : 2;
                    double childAspectRatio = isLargeScreen ? 1.2 : 1.1;
                    double crossAxisSpacing = isLargeScreen ? 16 : 12;
                    double mainAxisSpacing = isLargeScreen ? 16 : 12;
                    
                    int rows = (mockComplaints.length / crossAxisCount).ceil();
                    double totalHeight = rows * (constraints.maxWidth / crossAxisCount / childAspectRatio) + (rows - 1) * mainAxisSpacing;
                    
                    return SizedBox(
                      height: totalHeight,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspectRatio,
                          crossAxisSpacing: crossAxisSpacing,
                          mainAxisSpacing: mainAxisSpacing,
                        ),
                        itemCount: mockComplaints.length,
                        itemBuilder: (context, index) {
                          return _buildComplaintCard(mockComplaints[index]);
                        },
                      ),
                    );
                  },
                )
              : Column(
                  children: mockComplaints.map((complaint) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildComplaintCard(complaint),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildComplaintCard(Map<String, dynamic> complaint) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;
    final isMediumScreen = screenWidth > 600;
    
    return Container(
      constraints: BoxConstraints(
        maxWidth: isLargeScreen ? 350 : double.infinity,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle complaint card tap
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Viewing complaint: ${complaint['title']}')),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(
              isLargeScreen ? 16 : 12,
            ),
            child: isLargeScreen || isMediumScreen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image for larger screens
                      Container(
                        width: double.infinity,
                        height: isLargeScreen ? 120 : 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            complaint['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 40,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: isLargeScreen ? 12 : 8),
                      
                      // Title
                      Text(
                        complaint['title'],
                        style: TextStyle(
                          fontSize: isLargeScreen ? 16 : 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      
                      // Description
                      Text(
                        complaint['description'],
                        style: TextStyle(
                          fontSize: isLargeScreen ? 14 : 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      
                      // Status and Date Row
                      Row(
                        children: [
                          _buildStatusBadge(complaint['status']),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${complaint['date']} • ${complaint['time']}',
                              style: TextStyle(
                                fontSize: isLargeScreen ? 12 : 10,
                                color: Colors.grey.shade500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image and content row for mobile
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail Image for mobile - smaller size
                          Container(
                            width: screenWidth * 0.18,
                            height: screenWidth * 0.18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                complaint['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: screenWidth * 0.08,
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          
                          // Content - takes remaining space
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  complaint['title'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.038,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: screenWidth * 0.008),
                                
                                // Description
                                Text(
                                  complaint['description'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.032,
                                    color: Colors.grey.shade600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: screenWidth * 0.015),
                      
                      // Status and Date Row - full width
                      Row(
                        children: [
                          _buildStatusBadge(complaint['status']),
                          SizedBox(width: screenWidth * 0.025),
                          Expanded(
                            child: Text(
                              '${complaint['date']} • ${complaint['time']}',
                              style: TextStyle(
                                fontSize: screenWidth * 0.028,
                                color: Colors.grey.shade500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                            size: screenWidth * 0.04,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case 'Resolved':
        backgroundColor = const Color(0xFF4CAF50).withOpacity(0.1);
        textColor = const Color(0xFF4CAF50);
        break;
      case 'In Progress':
        backgroundColor = const Color(0xFF2196F3).withOpacity(0.1);
        textColor = const Color(0xFF2196F3);
        break;
      case 'Pending':
        backgroundColor = const Color(0xFFFF9800).withOpacity(0.1);
        textColor = const Color(0xFFFF9800);
        break;
      case 'Rejected':
        backgroundColor = const Color(0xFFF44336).withOpacity(0.1);
        textColor = const Color(0xFFF44336);
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 12 : screenWidth * 0.02, 
        vertical: isLargeScreen ? 6 : screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: isLargeScreen ? 12 : screenWidth * 0.03,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
          ),
        ),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsItem(
            icon: Icons.language,
            title: 'App Language',
            subtitle: 'English',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageSelectionPage(),
                ),
              );
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildSettingsItem(
            icon: Icons.location_on,
            title: 'Location',
            subtitle: 'Manage location settings',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Location settings coming soon')),
              );
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildSettingsItem(
            icon: Icons.privacy_tip,
            title: 'Privacy',
            subtitle: 'Control your privacy settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPage(),
                ),
              );
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: 'Help',
            subtitle: 'Get help and support',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help section coming soon')),
              );
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildSettingsItem(
            icon: Icons.feedback_outlined,
            title: 'Send Feedback',
            subtitle: 'Share your thoughts with us',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback feature coming soon')),
              );
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version and information',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About QuickFix'),
                  content: const Text('QuickFix v1.0.0\n\nA civic issue reporting app that helps communities report and track local problems.\n\nBuilt with Flutter.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color cardColor,
    required Color textColor,
    required Color secondaryTextColor,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1976D2),
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: secondaryTextColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: secondaryTextColor,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

// Language Selection Page
class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String _selectedLanguage = 'English';
  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'हिन्दी (Hindi)'},
    {'code': 'es', 'name': 'Español (Spanish)'},
    {'code': 'fr', 'name': 'Français (French)'},
    {'code': 'de', 'name': 'Deutsch (German)'},
    {'code': 'zh', 'name': '中文 (Chinese)'},
    {'code': 'ja', 'name': '日本語 (Japanese)'},
    {'code': 'ko', 'name': '한국어 (Korean)'},
    {'code': 'ar', 'name': 'العربية (Arabic)'},
    {'code': 'pt', 'name': 'Português (Portuguese)'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'App Language',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
          ),
        ),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          final isSelected = language['name'] == _selectedLanguage;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                language['name']!,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: const Color(0xFF1976D2),
                      size: 24,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = language['name']!;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Language changed to ${language['name']}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Privacy Page
class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool _locationPrivacyEnabled = true;
  bool _dataCollectionEnabled = false;
  bool _analyticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Privacy Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
          ),
        ),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPrivacyItem(
            icon: Icons.location_on,
            title: 'Location Privacy',
            subtitle: 'Control how your location data is used',
            value: _locationPrivacyEnabled,
            onChanged: (value) {
              setState(() {
                _locationPrivacyEnabled = value;
              });
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildPrivacyItem(
            icon: Icons.data_usage,
            title: 'Data Collection',
            subtitle: 'Allow app to collect usage data for improvements',
            value: _dataCollectionEnabled,
            onChanged: (value) {
              setState(() {
                _dataCollectionEnabled = value;
              });
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildPrivacyItem(
            icon: Icons.analytics,
            title: 'Analytics',
            subtitle: 'Help improve the app by sharing anonymous analytics',
            value: _analyticsEnabled,
            onChanged: (value) {
              setState(() {
                _analyticsEnabled = value;
              });
            },
            cardColor: cardColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
                  Icons.info_outline,
                  color: const Color(0xFF1976D2),
                  size: 24,
                ),
                const SizedBox(height: 8),
            Text(
                  'Privacy Notice',
              style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
            Text(
                  'Your privacy is important to us. We only collect data necessary to provide our services and never share your personal information with third parties without your consent.',
              style: TextStyle(
                fontSize: 14,
                    color: secondaryTextColor,
                    height: 1.4,
              ),
            ),
          ],
        ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color cardColor,
    required Color textColor,
    required Color secondaryTextColor,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1976D2),
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: secondaryTextColor,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF1976D2),
        ),
      ),
    );
  }
}

// Data Models (reusing from existing code)
class IssuePost {
  final String id;
  final String reporterName;
  final String description;
  final String location;
  final String imageUrl;
  final String timeAgo;
  final int voteCount;
  final String severity;
  final String status; // 'pending', 'reviewed', 'resolved'

  IssuePost({
    required this.id,
    required this.reporterName,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.timeAgo,
    required this.voteCount,
    required this.severity,
    required this.status,
  });
}

// Dummy Data (reusing from existing code)
List<IssuePost> _generateDummyIssues() {
  return [
    IssuePost(
      id: '1',
      reporterName: 'Rajesh K.',
      description: 'Utility pole has fallen across the road, blocking traffic completely. Wires are hanging dangerously low.',
      location: 'Pune, India',
      imageUrl: 'assets/images/pole image.webp',
      timeAgo: '3h ago',
      voteCount: 42,
      severity: 'High',
      status: 'pending', // Red dot will show
    ),
    IssuePost(
      id: '2',
      reporterName: 'Priya S.',
      description: 'Water is gushing from a broken pipe on the main road. Cars are splashing through large puddles.',
      location: 'Mumbai, India',
      imageUrl: 'assets/images/water leak image.jpeg',
      timeAgo: '5h ago',
      voteCount: 28,
      severity: 'High',
      status: 'reviewed', // No indicator (municipal party viewed)
    ),
    IssuePost(
      id: '3',
      reporterName: 'Amit P.',
      description: 'Multiple deep potholes filled with water making it dangerous for vehicles and pedestrians.',
      location: 'Delhi, India',
      imageUrl: 'assets/images/2ndroadimadge.jpg',
      timeAgo: '1d ago',
      voteCount: 35,
      severity: 'Medium',
      status: 'resolved', // Blue checkmark will show
    ),
  ];
}

// Post Dropdown Menu Widget
class _PostDropdownMenu extends StatefulWidget {
  final IssuePost issue;
  final bool isDarkMode;

  const _PostDropdownMenu({
    required this.issue,
    required this.isDarkMode,
  });

  @override
  State<_PostDropdownMenu> createState() => _PostDropdownMenuState();
}

class _PostDropdownMenuState extends State<_PostDropdownMenu>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleDropdown() {
    print('Three dots tapped!'); // Debug print
    if (_isOpen) {
      _closeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    setState(() {
      _isOpen = true;
    });
    
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _closeDropdown,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              // Position the dropdown relative to the three-dot icon
              Positioned(
                right: 16, // Adjust based on screen width
                top: 200, // Adjust based on post position
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 160,
                      minWidth: 140,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDropdownItem(
                          icon: Icons.flag,
                          title: 'Report',
                          onTap: () {
                            _closeDropdown();
                            _handleReport();
                          },
                        ),
                        _buildDropdownItem(
                          icon: Icons.info_outline,
                          title: 'About this Account',
                          onTap: () {
                            _closeDropdown();
                            _handleAboutAccount();
                          },
                        ),
                        _buildDropdownItem(
                          icon: null,
                          title: 'Cancel',
                          onTap: _closeDropdown,
                          isCancel: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    setState(() {
      _isOpen = false;
    });
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final secondaryTextColor = widget.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;
    
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.more_vert,
          color: secondaryTextColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildDropdownItem({
    IconData? icon,
    required String title,
    required VoidCallback onTap,
    bool isCancel = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isCancel ? Colors.red : Colors.grey.shade700,
                size: 20,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isCancel ? Colors.red : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reporting post by ${widget.issue.reporterName}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleAboutAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About ${widget.issue.reporterName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reporter: ${widget.issue.reporterName}'),
              const SizedBox(height: 8),
              Text('Location: ${widget.issue.location}'),
              const SizedBox(height: 8),
              Text('Issue Severity: ${widget.issue.severity}'),
              const SizedBox(height: 8),
              Text('Status: ${widget.issue.status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
