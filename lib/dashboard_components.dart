import 'package:flutter/material.dart';

// ---------------- Dashboard Components ----------------

class _RecentActivitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 16),
        _ActivityItem(
          icon: Icons.check_circle,
          title: 'Pothole Report #1234',
          subtitle: 'Status: In Progress',
          time: '2 hours ago',
          color: const Color(0xFF10B981),
        ),
        _ActivityItem(
          icon: Icons.pending,
          title: 'Garbage Collection #1233',
          subtitle: 'Status: Pending Review',
          time: '1 day ago',
          color: Colors.orange,
        ),
        _ActivityItem(
          icon: Icons.check_circle,
          title: 'Water Leak #1232',
          subtitle: 'Status: Resolved',
          time: '3 days ago',
          color: const Color(0xFF10B981),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Impact',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Reports',
                value: '12',
                icon: Icons.assignment_outlined,
                color: const Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Resolved',
                value: '8',
                icon: Icons.check_circle_outline,
                color: const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Votes',
                value: '24',
                icon: Icons.how_to_vote_outlined,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const _CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                isActive: selectedIndex == 0,
                onTap: () => onItemTapped(0),
              ),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                isActive: selectedIndex == 1,
                onTap: () => onItemTapped(1),
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: 'Settings',
                isActive: selectedIndex == 2,
                onTap: () => onItemTapped(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF3B82F6).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Placeholder Screens ----------------
class _UploadScreen extends StatelessWidget {
  const _UploadScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Complaint'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_file, size: 64, color: Color(0xFF3B82F6)),
            SizedBox(height: 16),
            Text('Upload Complaint Screen', style: TextStyle(fontSize: 18)),
            Text('This screen will allow users to upload complaints with photos and location data.'),
          ],
        ),
      ),
    );
  }
}

class _MyIssuesScreen extends StatelessWidget {
  const _MyIssuesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Issues'),
        backgroundColor: const Color(0xFF10B981),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_outlined, size: 64, color: Color(0xFF10B981)),
            SizedBox(height: 16),
            Text('My Issues Screen', style: TextStyle(fontSize: 18)),
            Text('This screen will show all user-submitted issues and their status.'),
          ],
        ),
      ),
    );
  }
}

class _NearbyIssuesScreen extends StatefulWidget {
  const _NearbyIssuesScreen();

  @override
  State<_NearbyIssuesScreen> createState() => _NearbyIssuesScreenState();
}

class _NearbyIssuesScreenState extends State<_NearbyIssuesScreen> {
  final List<_IssuePost> _posts = [
    _IssuePost(
      imageUrl: 'https://picsum.photos/seed/road/800/500',
      title: 'Large pothole causing traffic',
      location: 'Main St & 3rd Ave',
      votes: 24,
      tag: 'Roads',
    ),
    _IssuePost(
      imageUrl: 'https://picsum.photos/seed/garbage/800/500',
      title: 'Overflowing garbage bin',
      location: 'Elm Park, West Gate',
      votes: 17,
      tag: 'Sanitation',
    ),
    _IssuePost(
      imageUrl: 'https://picsum.photos/seed/water/800/500',
      title: 'Water leakage on sidewalk',
      location: '12th Street, Downtown',
      votes: 12,
      tag: 'Utilities',
    ),
    _IssuePost(
      imageUrl: 'https://picsum.photos/seed/light/800/500',
      title: 'Streetlight not working',
      location: 'Maple Ave Bus Stop',
      votes: 33,
      tag: 'Lighting',
    ),
  ];

  String _activeTag = 'All';
  String _sort = 'Top';

  @override
  Widget build(BuildContext context) {
    final filtered = _activeTag == 'All'
        ? _posts
        : _posts.where((p) => p.tag == _activeTag).toList();

    if (_sort == 'Top') {
      filtered.sort((a, b) => b.votes.compareTo(a.votes));
    } else {
      // Newest first (stable here as dummy data)
    }

    return Scaffold(
      backgroundColor: const Color(0xFF8B4513), // Rich brown background
      appBar: AppBar(
        title: const Text('Nearby Issues'),
        backgroundColor: const Color(0xFFA0522D), // Saddle brown
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFA0522D), Color(0xFF8B4513)],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: _FiltersBar(
                activeTag: _activeTag,
                sort: _sort,
                onTagChanged: (t) => setState(() => _activeTag = t),
                onSortChanged: (s) => setState(() => _sort = s),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = filtered[index];
                return _InteractiveIssueCard(
                  post: post,
                  onVote: () => setState(() => post.votes += 1),
                );
              },
              childCount: filtered.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}

class _IssuePost {
  _IssuePost({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.votes,
    required this.tag,
  });

  final String imageUrl;
  final String title;
  final String location;
  int votes;
  final String tag;
}

class _FiltersBar extends StatelessWidget {
  final String activeTag;
  final String sort;
  final ValueChanged<String> onTagChanged;
  final ValueChanged<String> onSortChanged;

  const _FiltersBar({
    required this.activeTag,
    required this.sort,
    required this.onTagChanged,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tags = const ['All', 'Roads', 'Sanitation', 'Utilities', 'Lighting'];
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tags.map((t) {
                final bool selected = t == activeTag;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(t),
                    selected: selected,
                    selectedColor: const Color(0xFF3B82F6).withOpacity(0.15),
                    labelStyle: TextStyle(
                      color: selected ? const Color(0xFF1D4ED8) : const Color(0xFF334155),
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (_) => onTagChanged(t),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        DropdownButtonHideUnderline(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButton<String>(
              value: sort,
              items: const [
                DropdownMenuItem(value: 'Top', child: Text('Top')),
                DropdownMenuItem(value: 'Newest', child: Text('Newest')),
              ],
              onChanged: (v) {
                if (v != null) onSortChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _InteractiveIssueCard extends StatefulWidget {
  final _IssuePost post;
  final VoidCallback onVote;

  const _InteractiveIssueCard({required this.post, required this.onVote});

  @override
  State<_InteractiveIssueCard> createState() => _InteractiveIssueCardState();
}

class _InteractiveIssueCardState extends State<_InteractiveIssueCard> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  bool _isVoted = false;
  int _displayVotes = 0;

  @override
  void initState() {
    super.initState();
    _displayVotes = widget.post.votes;
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleVote() {
    setState(() {
      _isVoted = !_isVoted;
      _displayVotes += _isVoted ? 1 : -1;
    });
    _scaleController.forward().then((_) => _scaleController.reverse());
    _pulseController.forward().then((_) => _pulseController.reverse());
    widget.onVote();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: GestureDetector(
        onTapDown: (_) => _scaleController.forward(),
        onTapUp: (_) => _scaleController.reverse(),
        onTapCancel: () => _scaleController.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B4513).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFF8B4513).withOpacity(0.8),
                                    const Color(0xFFA0522D).withOpacity(0.6),
                                  ],
                                ),
                              ),
                              child: const Center(
                                child: Icon(Icons.image, size: 60, color: Colors.white),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              top: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B4513).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.white, size: 14),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Nearby',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 16,
                              top: 16,
                              child: AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        widget.post.tag,
                                        style: const TextStyle(
                                          color: Color(0xFF8B4513),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.title,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2D1B0E),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: const Color(0xFF8B4513).withOpacity(0.7),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    widget.post.location,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFF8B4513).withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _EnhancedVoteButton(
                                  count: _displayVotes,
                                  isVoted: _isVoted,
                                  onTap: _handleVote,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EnhancedVoteButton extends StatefulWidget {
  final int count;
  final bool isVoted;
  final VoidCallback onTap;

  const _EnhancedVoteButton({
    required this.count,
    required this.isVoted,
    required this.onTap,
  });

  @override
  State<_EnhancedVoteButton> createState() => _EnhancedVoteButtonState();
}

class _EnhancedVoteButtonState extends State<_EnhancedVoteButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: widget.isVoted
                    ? const LinearGradient(
                        colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
                      )
                    : LinearGradient(
                        colors: [
                          const Color(0xFF8B4513).withOpacity(0.1),
                          const Color(0xFFA0522D).withOpacity(0.1),
                        ],
                      ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isVoted
                      ? const Color(0xFF8B4513)
                      : const Color(0xFF8B4513).withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: widget.isVoted
                    ? [
                        BoxShadow(
                          color: const Color(0xFF8B4513).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.isVoted ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: 18,
                    color: widget.isVoted ? Colors.white : const Color(0xFF8B4513),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${widget.count}',
                    style: TextStyle(
                      color: widget.isVoted ? Colors.white : const Color(0xFF8B4513),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VoteButton extends StatefulWidget {
  final int count;
  final VoidCallback onTap;

  const _VoteButton({required this.count, required this.onTap});

  @override
  State<_VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<_VoteButton> {
  int _displayCount = 0;

  @override
  void initState() {
    super.initState();
    _displayCount = widget.count;
  }

  @override
  void didUpdateWidget(covariant _VoteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      setState(() => _displayCount = widget.count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.how_to_vote_outlined, color: Color(0xFF1D4ED8), size: 18),
            const SizedBox(width: 6),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
              child: Text(
                '$_displayCount',
                key: ValueKey<int>(_displayCount),
                style: const TextStyle(
                  color: Color(0xFF1D4ED8),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: Color(0xFF3B82F6)),
            SizedBox(height: 16),
            Text('Profile Screen', style: TextStyle(fontSize: 18)),
            Text('This screen will show user profile information and settings.'),
          ],
        ),
      ),
    );
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 64, color: Color(0xFF3B82F6)),
            SizedBox(height: 16),
            Text('Settings Screen', style: TextStyle(fontSize: 18)),
            Text('This screen will contain app settings and preferences.'),
          ],
        ),
      ),
    );
  }
}
