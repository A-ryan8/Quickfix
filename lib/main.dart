import 'package:flutter/material.dart';
import 'upload_complaint_screen.dart';
import 'instagram_navigation.dart';

void main() {
  runApp(const CivicApp());
}

// ---------------- Theme ----------------
class AppGradients extends ThemeExtension<AppGradients> {
  final Gradient cardGradient;

  const AppGradients({
    required this.cardGradient,
  });

  @override
  AppGradients copyWith({Gradient? cardGradient}) {
    return AppGradients(cardGradient: cardGradient ?? this.cardGradient);
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;
    return this;
  }
}

final Color _primaryBlue = const Color(0xFF3B82F6);
final Color _secondaryGreen = const Color(0xFF10B981);
final Color _neutralBg = const Color(0xFFF7F9FC);

final ThemeData civicTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3B82F6),
    brightness: Brightness.light,
    primary: _primaryBlue,
    secondary: _secondaryGreen,
  ),
  scaffoldBackgroundColor: _neutralBg,
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    backgroundColor: _primaryBlue,
    foregroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 2,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryBlue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      elevation: 2,
      shadowColor: _primaryBlue.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _primaryBlue,
      side: BorderSide(color: _primaryBlue.withOpacity(0.55), width: 1.2),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _primaryBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 3,
    margin: const EdgeInsets.all(8),
    shadowColor: Colors.black.withOpacity(0.08),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    surfaceTintColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    hintStyle: TextStyle(color: Colors.grey.shade500),
    labelStyle: const TextStyle(fontWeight: FontWeight.w500),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: _primaryBlue, width: 1.6),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.6),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: _primaryBlue,
    unselectedItemColor: Colors.grey.shade500,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    showUnselectedLabels: false,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  extensions: <ThemeExtension<dynamic>>[
    const AppGradients(
      cardGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFEBF2FF),
          Color(0xFFE8FFF6),
        ],
      ),
    ),
  ],
);

// ---------------- App ----------------
class CivicApp extends StatelessWidget {
  const CivicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Civic Problem Resolver',
      theme: civicTheme,
      debugShowCheckedModeBanner: false,
      home: const InstagramStyleNavigation(),
      navigatorKey: navigatorKey,
      routes: {
        '/user': (context) => const UserDashboard(),
        '/upload': (context) => const UploadComplaintScreen(),
        '/main': (context) => const InstagramStyleNavigation(),
      },
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ---------------- Intro Slider ----------------
class _IssueItem {
  final IconData icon;
  final String title;
  final String subtitle;
  
  const _IssueItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class CivicIntroSlider extends StatefulWidget {
  final VoidCallback? onGetStarted;

  const CivicIntroSlider({Key? key, this.onGetStarted}) : super(key: key);

  @override
  State<CivicIntroSlider> createState() => _CivicIntroSliderState();
}

class _CivicIntroSliderState extends State<CivicIntroSlider> with TickerProviderStateMixin {
  late final PageController _pageController;
  int _currentPage = 0;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    Future.delayed(const Duration(milliseconds: 250), _fadeController.forward);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _pageController.animateToPage(
      index.clamp(0, 2),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _next() => _goTo(_currentPage + 1);
  void _back() => _goTo(_currentPage - 1);

  void _handleGetStarted(BuildContext context) {
    if (widget.onGetStarted != null) {
      widget.onGetStarted!();
      return;
    }
    const userRoute = '/user';
    Navigator.of(context).pushNamed(userRoute);
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = _primaryBlue;
    final Color secondaryGreen = _secondaryGreen;

    return Scaffold(
      backgroundColor: _neutralBg,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
              children: [
                _WelcomeScreen(
                  fadeAnimation: _fadeAnimation,
                  primaryBlue: primaryBlue,
                  secondaryGreen: secondaryGreen,
                ),
                _ProblemsScreen(primaryBlue: primaryBlue),
                _SolutionsScreen(
                  primaryBlue: primaryBlue,
                  secondaryGreen: secondaryGreen,
                  onGetStarted: () => _handleGetStarted(context),
                ),
              ],
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: _NavButton(
                            label: 'Back',
                            onPressed: _currentPage == 0 ? null : _back,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 4,
                      child: Center(
                        child: _PageIndicators(
                          count: 3,
                          currentIndex: _currentPage,
                          activeColor: primaryBlue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: _currentPage < 2
                              ? _PrimaryButton(label: 'Next', onPressed: _next)
                              : _CTAButton(
                                  label: 'Get Started',
                                  onPressed: () => _handleGetStarted(context),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}

class _WelcomeScreen extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Color primaryBlue;
  final Color secondaryGreen;

  const _WelcomeScreen({
    required this.fadeAnimation,
    required this.primaryBlue,
    required this.secondaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEBF2FF), Color(0xFFE8FFF6)],
        ),
      ),
      child: Center(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LogoBadge(primaryBlue: primaryBlue, secondaryGreen: secondaryGreen),
              const SizedBox(height: 18),
              Text(
                'AI Civic Problem Resolver',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Making Civic Complaints Easy & Fast',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF334155),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  final Color primaryBlue;
  final Color secondaryGreen;

  const _LogoBadge({required this.primaryBlue, required this.secondaryGreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [primaryBlue, secondaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Try to show provided logo asset; fall back to icon if it fails
          Image.asset(
            'web/icons/Icon-192.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.assistant, color: Colors.white, size: 54),
          ),
        ],
      ),
    );
  }
}

class _ProblemsScreen extends StatelessWidget {
  final Color primaryBlue;
  const _ProblemsScreen({required this.primaryBlue});

  @override
  Widget build(BuildContext context) {
    final List<_IssueItem> items = const [
      _IssueItem(icon: Icons.construction, title: 'Potholes', subtitle: 'Report road damage for quick repairs.'),
      _IssueItem(icon: Icons.delete_outline, title: 'Garbage', subtitle: 'Flag overflowing bins or littering.'),
      _IssueItem(icon: Icons.water_drop_outlined, title: 'Water Leakage', subtitle: 'Alert leaks to prevent wastage.'),
    ];

    return Container(
      color: const Color(0xFFEEF2F6),
      child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Common Civic Issues',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text('Spot a problem? Swipe to see how the app helps.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF475569))),
          const SizedBox(height: 16),
          ...items.map((e) => _InfoCard(icon: e.icon, title: e.title, subtitle: e.subtitle, accent: primaryBlue)),
        ],
        ),
      ),
    );
  }
}

class _SolutionsScreen extends StatelessWidget {
  final Color primaryBlue;
  final Color secondaryGreen;
  final VoidCallback onGetStarted;

  const _SolutionsScreen({
    required this.primaryBlue,
    required this.secondaryGreen,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    final features = const [
      (Icons.upload_file, 'Upload', 'Submit issues with photos & location.'),
      (Icons.assignment_outlined, 'My Issues', 'Track all your submitted reports.'),
      (Icons.location_on_outlined, 'Nearby Issues', 'View problems around you.'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Powerful Features',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text('Everything you need to report and resolve civic issues.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF475569))),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final double maxW = constraints.maxWidth;
              final int crossAxisCount = maxW >= 900
                  ? 4
                  : maxW >= 680
                      ? 3
                      : maxW >= 420
                          ? 2
                          : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: features.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  final f = features[index];
                  return _FeatureChip(
                    icon: f.$1,
                    title: f.$2,
                    subtitle: f.$3,
                    start: primaryBlue,
                    end: secondaryGreen,
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: _PrimaryButton(
              label: 'Get Started',
              onPressed: onGetStarted,
              background: secondaryGreen,
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final List<BoxShadow> baseShadow = [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
    ];
    final List<BoxShadow> hoverShadow = [
      BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 12, offset: const Offset(0, 6)),
    ];

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _hover = true),
        onTapUp: (_) => setState(() => _hover = false),
        onTapCancel: () => setState(() => _hover = false),
        child: AnimatedScale(
          scale: _hover ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFFA3D8FF), Color(0xFFFFFFFF)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: _hover ? hoverShadow : baseShadow,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: widget.accent.withOpacity(0.12),
                  child: Icon(widget.icon, color: widget.accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(widget.subtitle, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color start;
  final Color end;
  final VoidCallback? onTap;

  const _FeatureChip({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.start,
    required this.end,
    this.onTap,
  });

  @override
  State<_FeatureChip> createState() => _FeatureChipState();
}

class _FeatureChipState extends State<_FeatureChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final List<BoxShadow> baseShadow = [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
    ];
    final List<BoxShadow> hoverShadow = [
      BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 12, offset: const Offset(0, 6)),
    ];

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _hover = true),
        onTapUp: (_) => setState(() => _hover = false),
        onTapCancel: () => setState(() => _hover = false),
        child: AnimatedScale(
          scale: _hover ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Color(0xFF22C55E), Color(0xFFFFFFFF)],
              ),
              boxShadow: _hover ? hoverShadow : baseShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
                  child: Icon(widget.icon, color: widget.start),
          ),
          const SizedBox(height: 10),
                Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
                Text(widget.subtitle, style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 12)),
        ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? background;

  const _PrimaryButton({required this.label, this.onPressed, this.background});

  @override
  Widget build(BuildContext context) {
    final Color color = background ?? const Color(0xFF3B82F6);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _NavButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }
}

class _PageIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;

  const _PageIndicators({
    required this.count,
    required this.currentIndex,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final bool active = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: active ? 22 : 8,
          decoration: BoxDecoration(
            color: active ? activeColor : const Color(0xFFCBD5E1),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}

class _CTAButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _CTAButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF10B981)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x333B82F6),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// ---------------- User Dashboard ----------------
class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _DashboardHome(fadeAnimation: _fadeAnimation),
          const _ProfileScreen(),
          const _SettingsScreen(),
        ],
      ),
      bottomNavigationBar: _CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const _DashboardHome({required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: CustomScrollView(
        slivers: [
          _DashboardAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _WelcomeSection(),
                const SizedBox(height: 24),
                _QuickActionsGrid(),
                const SizedBox(height: 24),
                _RecentActivitySection(),
                const SizedBox(height: 24),
                _StatsSection(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF333333),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(color: Color(0xFF333333)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.assistant, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome back!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
                        ),
                        Text(
                          'AI Civic Resolver',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
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

class _WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEBF2FF), Color(0xFFE8FFF6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryBlue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report Issues Easily',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Help make your community better by reporting civic issues quickly and efficiently.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.trending_up, color: _primaryBlue, size: 28),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionCard(
        icon: Icons.upload_file,
        title: 'Upload Complaint',
        description: 'Report new civic issues with photos and location',
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        ),
        onTap: () => _navigateToUpload(context),
      ),
      _ActionCard(
        icon: Icons.assignment_outlined,
        title: 'My Issues',
        description: 'Track all your submitted reports and their status',
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
        onTap: () => _navigateToMyIssues(context),
      ),
      _ActionCard(
        icon: Icons.location_on_outlined,
        title: 'Nearby Issues',
        description: 'View and vote on issues around your location',
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        ),
        onTap: () => _navigateToNearbyIssues(context),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.8,
        mainAxisSpacing: 16,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) => actions[index],
    );
  }

  void _navigateToUpload(BuildContext context) {
    Navigator.of(context).pushNamed('/upload');
  }

  void _navigateToMyIssues(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const _MyIssuesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToNearbyIssues(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const _NearbyIssuesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

class _ActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
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
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.title,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.description,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withOpacity(0.8),
                          size: 16,
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
          color: _secondaryGreen,
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
          color: _secondaryGreen,
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
                color: _primaryBlue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Resolved',
                value: '8',
                icon: Icons.check_circle_outline,
                color: _secondaryGreen,
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
          color: isActive ? _primaryBlue.withOpacity(0.1) : Colors.transparent,
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
                color: isActive ? _primaryBlue : const Color(0xFF94A3B8),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isActive ? _primaryBlue : const Color(0xFF94A3B8),
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
class _UploadScreen extends StatefulWidget {
  const _UploadScreen();

  @override
  State<_UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<_UploadScreen> with TickerProviderStateMixin {
  int _currentStep = 0;
  bool _cameraPermissionGranted = false;
  bool _locationPermissionGranted = false;
  String _description = '';
  String? _capturedImagePath;
  String? _selectedLocation;
  bool _isProcessing = false;
  bool _isAnonymous = false;
  bool _showSuccess = false;

  late AnimationController _stepController;
  late AnimationController _processingController;
  late AnimationController _successController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _stepController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _processingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _successController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _stepController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _stepController, curve: Curves.elasticOut),
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _stepController, curve: Curves.easeOutCubic),
    );

    _stepController.forward();
  }

  @override
  void dispose() {
    _stepController.dispose();
    _processingController.dispose();
    _successController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 6) {
      setState(() {
        _currentStep++;
      });
      _stepController.reset();
      _stepController.forward();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _stepController.reset();
      _stepController.forward();
    }
  }

  void _requestPermissions() {
    setState(() {
      _cameraPermissionGranted = true;
      _locationPermissionGranted = true;
    });
    Future.delayed(const Duration(milliseconds: 500), _nextStep);
  }

  void _captureImage() {
    setState(() {
      _capturedImagePath = 'camera_captured_image.jpg';
    });
    _nextStep();
  }

  void _selectLocation() {
    setState(() {
      _selectedLocation = 'Current Location: 123 Main St, City';
    });
    _nextStep();
  }

  void _generateDescription() {
    setState(() {
      _description = 'Pothole detected on Main Street with significant depth. Road surface shows visible damage and poses safety risk to vehicles.';
      _descriptionController.text = _description;
    });
  }

  void _uploadComplaint() {
    setState(() {
      _isProcessing = true;
    });
    _processingController.forward();
    
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _isProcessing = false;
        _currentStep = 4; // Move to AI processing step
      });
      _stepController.reset();
      _stepController.forward();
    });
  }

  void _selectIdentity(bool isAnonymous) {
    setState(() {
      _isAnonymous = isAnonymous;
    });
    _nextStep();
  }

  void _submitComplaint() {
    setState(() {
      _showSuccess = true;
    });
    _successController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Complaint'),
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: AnimatedBuilder(
        animation: _stepController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(_slideAnimation),
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _buildCurrentStep(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildPermissionStep();
      case 1:
        return _buildCameraStep();
      case 2:
        return _buildLocationStep();
      case 3:
        return _buildDescriptionStep();
      case 4:
        return _buildAIProcessingStep();
      case 5:
        return _buildIdentityStep();
      case 6:
        return _buildSuccessStep();
      default:
        return _buildPermissionStep();
    }
  }

  Widget _buildPermissionStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              ),
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: _primaryBlue.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.security, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 30),
          Text(
            'Permissions Required',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'To submit a complaint, we need access to your camera and location.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _PermissionCard(
            icon: Icons.camera_alt,
            title: 'Camera Access',
            description: 'Take photos of the issue',
            isGranted: _cameraPermissionGranted,
          ),
          const SizedBox(height: 16),
          _PermissionCard(
            icon: Icons.location_on,
            title: 'Location Access',
            description: 'Pin the exact location',
            isGranted: _locationPermissionGranted,
          ),
          const SizedBox(height: 24),
          _ActionButton(
            text: 'Grant Permissions',
            onPressed: _requestPermissions,
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
              ),
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: _secondaryGreen.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.camera_alt, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 30),
          Text(
            'Capture Photo',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Take a clear photo of the issue to help us understand the problem better.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: _capturedImagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)],
                        ),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, color: Colors.white, size: 40),
                            SizedBox(height: 8),
                            Text('Photo Captured!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.grey, size: 40),
                        SizedBox(height: 8),
                        Text('Tap to capture', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
          ),
          const Spacer(),
          _ActionButton(
            text: _capturedImagePath != null ? 'Continue' : 'Capture Photo',
            onPressed: _captureImage,
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
              ),
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.location_on, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 30),
          Text(
            'Select Location',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Pin the exact location where you observed the issue.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: _selectedLocation != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: Colors.white, size: 40),
                            const SizedBox(height: 8),
                            const Text('Location Selected!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(_selectedLocation!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.grey, size: 40),
                        SizedBox(height: 8),
                        Text('Tap to select location', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
          ),
          const Spacer(),
          _ActionButton(
            text: _selectedLocation != null ? 'Continue' : 'Select Location',
            onPressed: _selectLocation,
            gradient: const LinearGradient(
              colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.edit_note, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 30),
          Text(
            'Describe the Issue',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Provide details about the problem you observed.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Describe the issue in detail...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton.icon(
              onPressed: _generateDescription,
              icon: const Icon(Icons.auto_awesome, color: Colors.white),
              label: const Text('Generate Description Automatically', style: TextStyle(color: Colors.white)),
            ),
          ),
          const Spacer(),
          _ActionButton(
            text: 'Continue',
            onPressed: _uploadComplaint,
            gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIProcessingStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          AnimatedBuilder(
            animation: _processingController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_processingController.value * 0.1),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
                    ),
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.psychology, color: Colors.white, size: 60),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Text(
            'AI Processing Report',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Our AI is analyzing your complaint and generating insights...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _AIProcessingCard(
            title: 'Problem Categories',
            categories: ['Road Infrastructure', 'Safety Hazard', 'Public Works'],
            progress: _processingController.value,
          ),
          const SizedBox(height: 20),
          _AIProcessingCard(
            title: 'Risk Assessment',
            riskLevel: 'Medium',
            riskScore: 0.7,
            progress: _processingController.value,
          ),
          const Spacer(),
          _ActionButton(
            text: 'Continue',
            onPressed: _nextStep,
            gradient: const LinearGradient(
              colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
              ),
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 30),
          Text(
            'Choose Identity',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'How would you like to submit this complaint?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _IdentityCard(
            title: 'Known Identity',
            description: 'Submit with your name and contact details',
            icon: Icons.person,
            isSelected: !_isAnonymous,
            onTap: () => _selectIdentity(false),
          ),
          const SizedBox(height: 16),
          _IdentityCard(
            title: 'Anonymous',
            description: 'Submit without revealing your identity',
            icon: Icons.visibility_off,
            isSelected: _isAnonymous,
            onTap: () => _selectIdentity(true),
          ),
          const Spacer(),
          _ActionButton(
            text: 'Submit Complaint',
            onPressed: _submitComplaint,
            gradient: const LinearGradient(
              colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStep() {
    return AnimatedBuilder(
      animation: _successController,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Transform.scale(
                scale: 1.0 + (_successController.value * 0.2),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(75),
                    boxShadow: [
                      BoxShadow(
                        color: _secondaryGreen.withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.white, size: 80),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Issue Submitted Successfully!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your complaint has been received and will be processed by our team. You will receive updates on the status.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _ActionButton(
                text: 'Done',
                onPressed: () => Navigator.of(context).pop(),
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isGranted;

  const _PermissionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isGranted,
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
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isGranted ? _secondaryGreen.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isGranted ? _secondaryGreen : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
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
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isGranted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isGranted ? _secondaryGreen : Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;

  const _ActionButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _AIProcessingCard extends StatelessWidget {
  final String title;
  final List<String>? categories;
  final String? riskLevel;
  final double? riskScore;
  final double progress;

  const _AIProcessingCard({
    required this.title,
    this.categories,
    this.riskLevel,
    this.riskScore,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (categories != null) ...[
            ...categories!.map((category) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF06B6D4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(category, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            )),
          ],
          if (riskLevel != null && riskScore != null) ...[
            Row(
              children: [
                Text('Risk Level: ', style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  riskLevel!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _getRiskColor(riskScore!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress * riskScore!,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(_getRiskColor(riskScore!)),
            ),
          ],
        ],
      ),
    );
  }

  Color _getRiskColor(double score) {
    if (score < 0.3) return _secondaryGreen;
    if (score < 0.7) return Colors.orange;
    return Colors.red;
  }
}

class _IdentityCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _IdentityCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? _primaryBlue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primaryBlue : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? _primaryBlue.withOpacity(0.1) : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? _primaryBlue : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? _primaryBlue : const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? _primaryBlue : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class _MyIssuesScreen extends StatefulWidget {
  const _MyIssuesScreen();

  @override
  State<_MyIssuesScreen> createState() => _MyIssuesScreenState();
}

class _MyIssuesScreenState extends State<_MyIssuesScreen> with TickerProviderStateMixin {
  late AnimationController _listController;
  late AnimationController _cardController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<IssueData> _issues = [
    IssueData(
      id: '1',
      title: 'Pothole on Main Street',
      description: 'Large pothole causing traffic issues and vehicle damage',
      imageUrl: 'assets/pothole.jpg',
      status: IssueStatus.inProgress,
      dateSubmitted: DateTime.now().subtract(const Duration(days: 2)),
      location: '123 Main St, Downtown',
    ),
    IssueData(
      id: '2',
      title: 'Broken Street Light',
      description: 'Street light not working, creating safety concerns at night',
      imageUrl: 'assets/streetlight.jpg',
      status: IssueStatus.pending,
      dateSubmitted: DateTime.now().subtract(const Duration(days: 5)),
      location: '456 Oak Ave, Residential',
    ),
    IssueData(
      id: '3',
      title: 'Garbage Collection Issue',
      description: 'Garbage bins overflowing, attracting pests and creating odor',
      imageUrl: 'assets/garbage.jpg',
      status: IssueStatus.resolved,
      dateSubmitted: DateTime.now().subtract(const Duration(days: 10)),
      location: '789 Pine St, Commercial',
    ),
    IssueData(
      id: '4',
      title: 'Water Leak on Sidewalk',
      description: 'Water leaking from underground pipe, creating slippery conditions',
      imageUrl: 'assets/waterleak.jpg',
      status: IssueStatus.inProgress,
      dateSubmitted: DateTime.now().subtract(const Duration(days: 1)),
      location: '321 Elm St, Downtown',
    ),
    IssueData(
      id: '5',
      title: 'Damaged Traffic Sign',
      description: 'Stop sign knocked down, creating traffic safety hazard',
      imageUrl: 'assets/trafficsign.jpg',
      status: IssueStatus.pending,
      dateSubmitted: DateTime.now().subtract(const Duration(hours: 6)),
      location: '654 Maple Dr, Intersection',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _listController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _listController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _listController, curve: Curves.easeOutCubic));

    _listController.forward();
  }

  @override
  void dispose() {
    _listController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _editIssue(IssueData issue) {
    _cardController.forward().then((_) {
      _cardController.reverse();
      _showEditDialog(issue);
    });
  }

  void _deleteIssue(IssueData issue) {
    _cardController.forward().then((_) {
      setState(() {
        _issues.removeWhere((item) => item.id == issue.id);
      });
      _cardController.reverse();
      _showDeleteConfirmation();
    });
  }

  void _showEditDialog(IssueData issue) {
    showDialog(
      context: context,
      builder: (context) => _EditIssueDialog(issue: issue),
    );
  }

  void _showDeleteConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Issue deleted successfully'),
        backgroundColor: _secondaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Issues'),
        backgroundColor: _secondaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0FDF4), Color(0xFFECFDF5)],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: AnimatedBuilder(
                animation: _listController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildIssuesList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Reported Issues',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_issues.length} issues reported • ${_issues.where((i) => i.status == IssueStatus.resolved).length} resolved',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesList() {
    if (_issues.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _issues.length,
      itemBuilder: (context, index) {
        final issue = _issues[index];
        return AnimatedBuilder(
          animation: _cardController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 - (_cardController.value * 0.05),
              child: _IssueCard(
                issue: issue,
                onEdit: () => _editIssue(issue),
                onDelete: () => _deleteIssue(issue),
                animationDelay: Duration(milliseconds: index * 100),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: _secondaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.assignment_outlined,
              size: 60,
              color: _secondaryGreen.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Issues Reported',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start by reporting an issue to help improve your community',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.add),
            label: const Text('Report New Issue'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _secondaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheet(),
    );
  }
}

class IssueData {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final IssueStatus status;
  final DateTime dateSubmitted;
  final String location;

  IssueData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.dateSubmitted,
    required this.location,
  });
}

enum IssueStatus { pending, inProgress, resolved }

class _IssueCard extends StatefulWidget {
  final IssueData issue;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Duration animationDelay;

  const _IssueCard({
    required this.issue,
    required this.onEdit,
    required this.onDelete,
    required this.animationDelay,
  });

  @override
  State<_IssueCard> createState() => _IssueCardState();
}

class _IssueCardState extends State<_IssueCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showIssueDetails(),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageSection(),
                        const SizedBox(height: 12),
                        _buildContentSection(),
                        const SizedBox(height: 12),
                        _buildStatusSection(),
                        const SizedBox(height: 12),
                        _buildActionSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: _getStatusGradient(),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: _getStatusGradient(),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: _StatusBadge(status: widget.issue.status),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.issue.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.issue.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF64748B),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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
            Expanded(
              child: Text(
                widget.issue.location,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              _formatDate(widget.issue.dateSubmitted),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getStatusColor(),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _getStatusText(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            text: 'Edit',
            onPressed: widget.onEdit,
            gradient: LinearGradient(
              colors: [_primaryBlue, _primaryBlue.withOpacity(0.8)],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            text: 'Delete',
            onPressed: widget.onDelete,
            gradient: const LinearGradient(
              colors: [Colors.red, Color(0xFFDC2626)],
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient _getStatusGradient() {
    switch (widget.issue.status) {
      case IssueStatus.pending:
        return const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        );
      case IssueStatus.inProgress:
        return const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        );
      case IssueStatus.resolved:
        return const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        );
    }
  }

  Color _getStatusColor() {
    switch (widget.issue.status) {
      case IssueStatus.pending:
        return Colors.orange;
      case IssueStatus.inProgress:
        return _primaryBlue;
      case IssueStatus.resolved:
        return _secondaryGreen;
    }
  }

  String _getStatusText() {
    switch (widget.issue.status) {
      case IssueStatus.pending:
        return 'Pending Review';
      case IssueStatus.inProgress:
        return 'In Progress';
      case IssueStatus.resolved:
        return 'Resolved';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return 'Just now';
    }
  }

  void _showIssueDetails() {
    showDialog(
      context: context,
      builder: (context) => _IssueDetailsDialog(issue: widget.issue),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final IssueStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getStatusColor(),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            _getStatusText(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case IssueStatus.pending:
        return Colors.orange;
      case IssueStatus.inProgress:
        return _primaryBlue;
      case IssueStatus.resolved:
        return _secondaryGreen;
    }
  }

  String _getStatusText() {
    switch (status) {
      case IssueStatus.pending:
        return 'Pending';
      case IssueStatus.inProgress:
        return 'In Progress';
      case IssueStatus.resolved:
        return 'Resolved';
    }
  }
}


class _EditIssueDialog extends StatefulWidget {
  final IssueData issue;

  const _EditIssueDialog({required this.issue});

  @override
  State<_EditIssueDialog> createState() => _EditIssueDialogState();
}

class _EditIssueDialogState extends State<_EditIssueDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.issue.title);
    _descriptionController = TextEditingController(text: widget.issue.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Issue',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Issue updated successfully')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IssueDetailsDialog extends StatelessWidget {
  final IssueData issue;

  const _IssueDetailsDialog({required this.issue});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    issue.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(issue.description),
            const SizedBox(height: 16),
            Text(
              'Location',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(issue.location),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getStatusText(),
                style: TextStyle(
                  color: _getStatusColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (issue.status) {
      case IssueStatus.pending:
        return Colors.orange;
      case IssueStatus.inProgress:
        return _primaryBlue;
      case IssueStatus.resolved:
        return _secondaryGreen;
    }
  }

  String _getStatusText() {
    switch (issue.status) {
      case IssueStatus.pending:
        return 'Pending Review';
      case IssueStatus.inProgress:
        return 'In Progress';
      case IssueStatus.resolved:
        return 'Resolved';
    }
  }
}

class _FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Issues',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          _FilterOption(
            title: 'All Issues',
            count: 5,
            isSelected: true,
            onTap: () {},
          ),
          _FilterOption(
            title: 'Pending',
            count: 2,
            isSelected: false,
            onTap: () {},
          ),
          _FilterOption(
            title: 'In Progress',
            count: 2,
            isSelected: false,
            onTap: () {},
          ),
          _FilterOption(
            title: 'Resolved',
            count: 1,
            isSelected: false,
            onTap: () {},
          ),
          const SizedBox(height: 4),
        ],
        ),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String title;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterOption({
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? _primaryBlue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          count.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

class _NearbyIssuesScreen extends StatefulWidget {
  const _NearbyIssuesScreen();

  @override
  State<_NearbyIssuesScreen> createState() => _NearbyIssuesScreenState();
}

class _NearbyIssuesScreenState extends State<_NearbyIssuesScreen> with TickerProviderStateMixin {
  late AnimationController _listController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<NearbyIssueData> _nearbyIssues = [
    NearbyIssueData(
      id: '1',
      title: 'Broken Traffic Light',
      description: 'Traffic light at Main St & Oak Ave has been malfunctioning for 3 days, causing traffic congestion and safety concerns.',
      imageUrl: 'assets/traffic_light.jpg',
      location: 'Main St & Oak Ave, Downtown',
      distance: '0.2 km away',
      votes: 23,
      timeAgo: '2 hours ago',
      category: 'Traffic & Safety',
      reporterName: 'Sarah M.',
      isVoted: false,
    ),
    NearbyIssueData(
      id: '2',
      title: 'Pothole on Elm Street',
      description: 'Large pothole causing damage to vehicles. Needs immediate attention before it gets worse.',
      imageUrl: 'assets/pothole.jpg',
      location: 'Elm Street, Residential Area',
      distance: '0.5 km away',
      votes: 45,
      timeAgo: '4 hours ago',
      category: 'Road Infrastructure',
      reporterName: 'Mike R.',
      isVoted: true,
    ),
    NearbyIssueData(
      id: '3',
      title: 'Garbage Collection Missed',
      description: 'Garbage bins not collected on scheduled day. Overflowing bins attracting pests and creating odor.',
      imageUrl: 'assets/garbage.jpg',
      location: 'Pine Street, Commercial District',
      distance: '0.8 km away',
      votes: 12,
      timeAgo: '6 hours ago',
      category: 'Waste Management',
      reporterName: 'Lisa K.',
      isVoted: false,
    ),
    NearbyIssueData(
      id: '4',
      title: 'Street Light Out',
      description: 'Street light not working, making the area dark and unsafe for pedestrians at night.',
      imageUrl: 'assets/streetlight.jpg',
      location: 'Maple Drive, Residential',
      distance: '1.2 km away',
      votes: 31,
      timeAgo: '1 day ago',
      category: 'Public Safety',
      reporterName: 'David L.',
      isVoted: false,
    ),
    NearbyIssueData(
      id: '5',
      title: 'Water Leak on Sidewalk',
      description: 'Water leaking from underground pipe, creating slippery conditions and water waste.',
      imageUrl: 'assets/waterleak.jpg',
      location: 'Cedar Avenue, Downtown',
      distance: '1.5 km away',
      votes: 18,
      timeAgo: '2 days ago',
      category: 'Water & Utilities',
      reporterName: 'Emma W.',
      isVoted: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _listController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _listController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _listController, curve: Curves.easeOutCubic));

    _listController.forward();
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  void _toggleVote(NearbyIssueData issue) {
    setState(() {
      issue.isVoted = !issue.isVoted;
      issue.votes += issue.isVoted ? 1 : -1;
    });
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _NearbyFilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Issues'),
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: AnimatedBuilder(
                animation: _listController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildIssuesFeed(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Issues Near You',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_nearbyIssues.length} issues reported in your area • Help your community by voting',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesFeed() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _nearbyIssues.length,
      itemBuilder: (context, index) {
        final issue = _nearbyIssues[index];
        return Container(
          key: ValueKey(issue.id),
          margin: const EdgeInsets.only(bottom: 20),
          child: _IssueFeedCard(
            issue: issue,
            onVote: () => _toggleVote(issue),
            animationDelay: Duration(milliseconds: index * 150),
          ),
        );
      },
    );
  }
}

class NearbyIssueData {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String location;
  final String distance;
  int votes;
  final String timeAgo;
  final String category;
  final String reporterName;
  bool isVoted;

  NearbyIssueData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.distance,
    required this.votes,
    required this.timeAgo,
    required this.category,
    required this.reporterName,
    required this.isVoted,
  });
}

class _IssueFeedCard extends StatefulWidget {
  final NearbyIssueData issue;
  final VoidCallback onVote;
  final Duration animationDelay;

  const _IssueFeedCard({
    required this.issue,
    required this.onVote,
    required this.animationDelay,
  });

  @override
  State<_IssueFeedCard> createState() => _IssueFeedCardState();
}

class _IssueFeedCardState extends State<_IssueFeedCard> with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _voteController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _voteScaleAnimation;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _voteController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeInOut),
    );
    _voteScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _voteController, curve: Curves.elasticOut),
    );

    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _cardController.forward();
      }
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    _voteController.dispose();
    super.dispose();
  }

  void _handleVote() {
    _voteController.forward().then((_) {
      _voteController.reverse();
    });
    widget.onVote();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cardController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(),
                  _buildContentSection(),
                  _buildActionSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        gradient: _getCategoryGradient(),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: _getCategoryGradient(),
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: _CategoryBadge(category: widget.issue.category),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.issue.distance,
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

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: _primaryBlue.withOpacity(0.1),
                child: Text(
                  widget.issue.reporterName[0],
                  style: TextStyle(
                    color: _primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.issue.reporterName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      widget.issue.timeAgo,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.issue.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
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
                Icons.location_on,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.issue.location,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _voteController,
            builder: (context, child) {
              return Transform.scale(
                scale: _voteScaleAnimation.value,
                child: GestureDetector(
                  onTap: _handleVote,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: widget.issue.isVoted 
                          ? _primaryBlue 
                          : _primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: widget.issue.isVoted 
                            ? _primaryBlue 
                            : _primaryBlue.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.issue.isVoted ? Icons.thumb_up : Icons.thumb_up_outlined,
                          size: 18,
                          color: widget.issue.isVoted ? Colors.white : _primaryBlue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.issue.votes}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: widget.issue.isVoted ? Colors.white : _primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.comment_outlined,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Comment',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.share_outlined,
                  size: 18,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  'Share',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _getCategoryGradient() {
    switch (widget.issue.category) {
      case 'Traffic & Safety':
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
        );
      case 'Road Infrastructure':
        return const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        );
      case 'Waste Management':
        return const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
        );
      case 'Public Safety':
        return const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        );
      case 'Water & Utilities':
        return const LinearGradient(
          colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF6B7280), Color(0xFF4B5563)],
        );
    }
  }
}

class _CategoryBadge extends StatelessWidget {
  final String category;

  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: _getCategoryColor(),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (category) {
      case 'Traffic & Safety':
        return Colors.red;
      case 'Road Infrastructure':
        return Colors.orange;
      case 'Waste Management':
        return Colors.purple;
      case 'Public Safety':
        return _primaryBlue;
      case 'Water & Utilities':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }
}

class _NearbyFilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter & Sort',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          _FilterOption(
            title: 'All Categories',
            count: 12,
            isSelected: true,
            onTap: () {},
          ),
          _FilterOption(
            title: 'Traffic & Safety',
            count: 4,
            isSelected: false,
            onTap: () {},
          ),
          _FilterOption(
            title: 'Road Infrastructure',
            count: 3,
            isSelected: false,
            onTap: () {},
          ),
          _FilterOption(
            title: 'Waste Management',
            count: 2,
            isSelected: false,
            onTap: () {},
          ),
          _FilterOption(
            title: 'Public Safety',
            count: 2,
            isSelected: false,
            onTap: () {},
          ),
          _FilterOption(
            title: 'Water & Utilities',
            count: 1,
            isSelected: false,
            onTap: () {},
          ),
          const SizedBox(height: 20),
          Text(
            'Sort by',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _SortOption(
            title: 'Most Recent',
            isSelected: true,
            onTap: () {},
          ),
          _SortOption(
            title: 'Most Voted',
            isSelected: false,
            onTap: () {},
          ),
          _SortOption(
            title: 'Nearest',
            isSelected: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: _primaryBlue)
          : Icon(Icons.radio_button_unchecked, color: Colors.grey),
      onTap: onTap,
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
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: _primaryBlue),
            const SizedBox(height: 16),
            const Text('Profile Screen', style: TextStyle(fontSize: 18)),
            const Text('This screen will show user profile information and settings.'),
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
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 64, color: _primaryBlue),
            const SizedBox(height: 16),
            const Text('Settings Screen', style: TextStyle(fontSize: 18)),
            const Text('This screen will contain app settings and preferences.'),
          ],
        ),
      ),
    );
  }
}
