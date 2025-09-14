import 'package:flutter/material.dart';

class ModernHomeScreen extends StatefulWidget {
  const ModernHomeScreen({super.key});

  @override
  State<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends State<ModernHomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            _ModernAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _ActionCardsGrid(),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Recent Issues', subtitle: 'Help your community'),
                  const SizedBox(height: 16),
                  _IssuesFeed(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.1),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.assistant, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CivicConnect',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Report • Track • Resolve',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _IconButton(
                    icon: Icons.notifications_outlined,
                    onTap: () {},
                    badge: true,
                  ),
                  const SizedBox(width: 8),
                  _IconButton(
                    icon: Icons.person_outline,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool badge;

  const _IconButton({required this.icon, required this.onTap, this.badge = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
        ),
        if (badge)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFFF4757),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionCardsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionCard(
        icon: Icons.upload_file,
        title: 'Upload',
        subtitle: 'Report Issue',
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        onTap: () {},
      ),
      _ActionCard(
        icon: Icons.assignment_outlined,
        title: 'My Complaints',
        subtitle: 'Track Status',
        gradient: const LinearGradient(
          colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
        ),
        onTap: () {},
      ),
      _ActionCard(
        icon: Icons.location_on_outlined,
        title: 'Nearby Issues',
        subtitle: 'View Local',
        gradient: const LinearGradient(
          colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
        ),
        onTap: () {},
      ),
      _ActionCard(
        icon: Icons.trending_up,
        title: 'Top Voted',
        subtitle: 'Popular Issues',
        gradient: const LinearGradient(
          colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
        ),
        onTap: () {},
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) => actions[index],
    );
  }
}

class _ActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  State<_ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<_ActionCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.gradient.colors.first.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(widget.icon, color: Colors.white, size: 20),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.subtitle,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
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
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See All'),
        ),
      ],
    );
  }
}

class _IssuesFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final issues = [
      _IssueData(
        id: '1',
        imageUrl: 'https://picsum.photos/seed/pothole1/400/300',
        title: 'Large pothole on Main Street',
        description: 'Deep pothole causing traffic delays and vehicle damage. Needs immediate attention.',
        distance: '0.2 km',
        riskLevel: 'High',
        votes: 24,
        timeAgo: '2h ago',
        category: 'Roads',
      ),
      _IssueData(
        id: '2',
        imageUrl: 'https://picsum.photos/seed/garbage1/400/300',
        title: 'Overflowing garbage bin',
        description: 'Garbage spilling onto sidewalk, attracting stray animals.',
        distance: '0.5 km',
        riskLevel: 'Medium',
        votes: 18,
        timeAgo: '4h ago',
        category: 'Sanitation',
      ),
      _IssueData(
        id: '3',
        imageUrl: 'https://picsum.photos/seed/water1/400/300',
        title: 'Water pipeline leakage',
        description: 'Continuous water leak flooding the street corner.',
        distance: '0.8 km',
        riskLevel: 'High',
        votes: 31,
        timeAgo: '6h ago',
        category: 'Utilities',
      ),
      _IssueData(
        id: '4',
        imageUrl: 'https://picsum.photos/seed/light1/400/300',
        title: 'Streetlight not working',
        description: 'Two streetlights are out, making the area unsafe at night.',
        distance: '1.2 km',
        riskLevel: 'Medium',
        votes: 15,
        timeAgo: '8h ago',
        category: 'Lighting',
      ),
    ];

    return Column(
      children: issues.map((issue) => _IssueCard(issue: issue)).toList(),
    );
  }
}

class _IssueCard extends StatefulWidget {
  final _IssueData issue;

  const _IssueCard({required this.issue});

  @override
  State<_IssueCard> createState() => _IssueCardState();
}

class _IssueCardState extends State<_IssueCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isVoted = false;
  int _voteCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _voteCount = widget.issue.votes;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleVote() {
    setState(() {
      _isVoted = !_isVoted;
      _voteCount += _isVoted ? 1 : -1;
    });
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IssueImage(issue: widget.issue),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _RiskBadge(level: widget.issue.riskLevel),
                            const Spacer(),
                            Text(
                              widget.issue.timeAgo,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.issue.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.issue.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF64748B),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.issue.distance,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const Spacer(),
                            _VoteButton(
                              count: _voteCount,
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
          );
        },
      ),
    );
  }
}

class _IssueImage extends StatelessWidget {
  final _IssueData issue;

  const _IssueImage({required this.issue});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getCategoryColor(issue.category).withOpacity(0.8),
                  _getCategoryColor(issue.category).withOpacity(0.6),
                ],
              ),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 60, color: Colors.white),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                issue.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Roads':
        return const Color(0xFF3B82F6);
      case 'Sanitation':
        return const Color(0xFF10B981);
      case 'Utilities':
        return const Color(0xFF8B5CF6);
      case 'Lighting':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF64748B);
    }
  }
}

class _RiskBadge extends StatelessWidget {
  final String level;

  const _RiskBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (level) {
      case 'High':
        color = const Color(0xFFEF4444);
        break;
      case 'Medium':
        color = const Color(0xFFF59E0B);
        break;
      default:
        color = const Color(0xFF10B981);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        level,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _VoteButton extends StatefulWidget {
  final int count;
  final bool isVoted;
  final VoidCallback onTap;

  const _VoteButton({
    required this.count,
    required this.isVoted,
    required this.onTap,
  });

  @override
  State<_VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<_VoteButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.isVoted
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isVoted
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF3B82F6).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.isVoted ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: 16,
                    color: widget.isVoted ? Colors.white : const Color(0xFF3B82F6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.count}',
                    style: TextStyle(
                      color: widget.isVoted ? Colors.white : const Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
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

class _IssueData {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String distance;
  final String riskLevel;
  final int votes;
  final String timeAgo;
  final String category;

  _IssueData({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.distance,
    required this.riskLevel,
    required this.votes,
    required this.timeAgo,
    required this.category,
  });
}

