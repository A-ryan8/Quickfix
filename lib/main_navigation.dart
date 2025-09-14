import 'package:flutter/material.dart';
import 'upload_complaint_screen.dart';
import 'dashboard_components.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onUploadPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UploadComplaintScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          NearbyIssuesScreen(),
          Center(
            child: Text(
              'Upload',
              style: TextStyle(fontSize: 24),
            ),
          ),
          MyIssuesScreen(),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.location_on,
                  label: 'Nearby',
                  index: 0,
                  isSelected: _currentIndex == 0,
                ),
                const SizedBox(width: 40), // Space for FAB
                _buildNavItem(
                  icon: Icons.person,
                  label: 'My Issues',
                  index: 2,
                  isSelected: _currentIndex == 2,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1976D2).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _onUploadPressed,
          backgroundColor: const Color(0xFF1976D2),
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF1976D2).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? const Color(0xFF1976D2)
                  : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected 
                    ? const Color(0xFF1976D2)
                    : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Instagram-style Nearby Issues Screen
class NearbyIssuesScreen extends StatefulWidget {
  const NearbyIssuesScreen({super.key});

  @override
  State<NearbyIssuesScreen> createState() => _NearbyIssuesScreenState();
}

class _NearbyIssuesScreenState extends State<NearbyIssuesScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<IssuePost> _issues = _generateDummyIssues();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Nearby Issues',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1976D2),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Filter action
            },
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              // Search action
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _issues.shuffle();
          });
        },
        child: ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: _issues.length,
          itemBuilder: (context, index) {
            return _IssuePostCard(issue: _issues[index]);
          },
        ),
      ),
    );
  }
}

// Instagram-style Issue Post Card
class _IssuePostCard extends StatefulWidget {
  final IssuePost issue;

  const _IssuePostCard({required this.issue});

  @override
  State<_IssuePostCard> createState() => _IssuePostCardState();
}

class _IssuePostCardState extends State<_IssuePostCard>
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                  child: Icon(
                    Icons.person,
                    color: const Color(0xFF1976D2),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.issue.reporterName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.issue.timeAgo,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // More options
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey.shade600,
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
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: widget.issue.imageUrl.isNotEmpty
                          ? Image.asset(
                              widget.issue.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
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
                              _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                              color: _isLiked ? const Color(0xFF1976D2) : Colors.grey.shade600,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$_likeCount',
                              style: TextStyle(
                                color: _isLiked ? const Color(0xFF1976D2) : Colors.grey.shade600,
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
                  color: Colors.grey.shade600,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.share_outlined,
                  color: Colors.grey.shade600,
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
          
          // Description
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
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: widget.issue.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.issue.location,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
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

// My Issues Screen
class MyIssuesScreen extends StatefulWidget {
  const MyIssuesScreen({super.key});

  @override
  State<MyIssuesScreen> createState() => _MyIssuesScreenState();
}

class _MyIssuesScreenState extends State<MyIssuesScreen> {
  final List<MyIssue> _myIssues = _generateMyIssues();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'My Issues',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1976D2),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Filter by status
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: _myIssues.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No issues submitted yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to report an issue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _myIssues.length,
              itemBuilder: (context, index) {
                return _MyIssueCard(issue: _myIssues[index]);
              },
            ),
    );
  }
}

class _MyIssueCard extends StatelessWidget {
  final MyIssue issue;

  const _MyIssueCard({required this.issue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: issue.imageUrl.isNotEmpty
                        ? Image.network(
                            issue.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          )
                        : const Center(
                            child: Icon(Icons.image, color: Colors.grey),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        issue.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        issue.location,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(issue.status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              issue.status,
                              style: TextStyle(
                                color: _getStatusColor(issue.status),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            issue.submittedDate,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (issue.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                issue.description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.thumb_up_outlined,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  '${issue.voteCount} votes',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                if (issue.status == 'In Progress')
                  TextButton(
                    onPressed: () {
                      // View progress
                    },
                    child: const Text('View Progress'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Submitted':
        return Colors.blue;
      case 'In Progress':
        return Colors.orange;
      case 'Resolved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Data Models
class IssuePost {
  final String id;
  final String reporterName;
  final String description;
  final String location;
  final String imageUrl;
  final String timeAgo;
  final int voteCount;
  final String severity;

  IssuePost({
    required this.id,
    required this.reporterName,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.timeAgo,
    required this.voteCount,
    required this.severity,
  });
}

class MyIssue {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final String status;
  final String submittedDate;
  final int voteCount;

  MyIssue({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.status,
    required this.submittedDate,
    required this.voteCount,
  });
}

// Dummy Data
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
    ),
  ];
}

List<MyIssue> _generateMyIssues() {
  return [
    MyIssue(
      id: '1',
      title: 'Broken Traffic Light',
      description: 'The traffic light at the intersection of 5th and Main has been malfunctioning for 3 days.',
      location: '5th Street & Main',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200',
      status: 'In Progress',
      submittedDate: '2 days ago',
      voteCount: 8,
    ),
    MyIssue(
      id: '2',
      title: 'Damaged Road Sign',
      description: 'Stop sign is bent and barely visible to drivers.',
      location: 'Elm Street',
      imageUrl: 'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=200',
      status: 'Submitted',
      submittedDate: '1 week ago',
      voteCount: 3,
    ),
    MyIssue(
      id: '3',
      title: 'Blocked Drainage',
      description: 'Storm drain is clogged with leaves and debris.',
      location: 'Park Avenue',
      imageUrl: 'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=200',
      status: 'Resolved',
      submittedDate: '2 weeks ago',
      voteCount: 12,
    ),
  ];
}
