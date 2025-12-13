import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:daily_bread/services/data_service.dart';
import 'package:daily_bread/services/bookmark_service.dart';
import 'package:daily_bread/models/verse.dart';
import 'package:daily_bread/models/saint.dart';
import 'package:daily_bread/bible.dart';
import 'package:daily_bread/dailyMassReadings.dart';
import 'package:daily_bread/saintOfTheDay.dart';
import 'package:daily_bread/search.dart';
import 'package:daily_bread/pages/bookmarks_page.dart';
import 'package:daily_bread/services/language_service.dart';
import 'package:daily_bread/services/notification_service.dart';
import 'package:share_plus/share_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageService().loadLocale();
  await DataService().loadData(locale: LanguageService().currentLocale.languageCode);
  await NotificationService.scheduleNotifications();
  runApp(const DailyBreadApp());
}

class DailyBreadApp extends StatelessWidget {
  const DailyBreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LanguageService(),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Daily Bread",
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6A1B9A), // Deep Purple
              primary: const Color(0xFF6A1B9A),
              secondary: const Color(0xFFFFB300), // Amber
              tertiary: const Color(0xFF4A148C),
              surface: const Color(0xFFFAF8FF),
              brightness: Brightness.light,
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.1),
              backgroundColor: const Color(0xFF6A1B9A),
              foregroundColor: Colors.white,
              titleTextStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            cardTheme: CardTheme(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            textTheme: const TextTheme(
              headlineSmall: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C2C2C),
                height: 1.5,
              ),
              titleLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C2C2C),
              ),
              titleMedium: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C2C2C),
              ),
              bodyMedium: TextStyle(
                fontSize: 16,
                color: Color(0xFF555555),
              ),
              labelSmall: TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
                letterSpacing: 0.5,
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              backgroundColor: Colors.white,
              indicatorColor: const Color(0xFF6A1B9A).withOpacity(0.15),
              labelTextStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          home: const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  DateTime _currentDate = DateTime.now();
  final BookmarkService _bookmarkService = BookmarkService();
  bool _isBookmarked = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _checkBookmarkStatus();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkBookmarkStatus() async {
    final dateString = DateFormat("yyyy-MM-dd").format(_currentDate);
    final isBookmarked = await _bookmarkService.isBookmarked(dateString);
    if (!mounted) return;
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  Future<void> _toggleBookmark() async {
    final dateString = DateFormat("yyyy-MM-dd").format(_currentDate);
    final verse = DataService().getVerse(dateString);

    if (verse != null) {
      final newState =
          await _bookmarkService.toggleBookmark(dateString, verse.text);
      if (!mounted) return;
      setState(() {
        _isBookmarked = newState;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(newState ? 'Verse bookmarked' : 'Bookmark removed'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _previousDay() {
    setState(() {
      _currentDate = _currentDate.subtract(const Duration(days: 1));
    });
    _animationController.reset();
    _animationController.forward();
    _checkBookmarkStatus();
  }

  void _nextDay() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: 1));
    });
    _animationController.reset();
    _animationController.forward();
    _checkBookmarkStatus();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2026, 12, 31),
    );
    if (picked != null && picked != _currentDate) {
      setState(() {
        _currentDate = picked;
      });
      _animationController.reset();
      _animationController.forward();
      _checkBookmarkStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat("yyyy-MM-dd").format(_currentDate);
    final verse = DataService().getVerse(dateString);
    final saint = DataService().getSaintForDate(dateString);

    // Fallback if data is missing for the specific date
    if (verse == null || saint == null) {
      return Scaffold(
          appBar: AppBar(title: const Text("Thought for the day")),
          body: const Center(child: Text("No data available for this date.")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thought for the day'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (String value) async {
              final locale = Locale(value);
              await LanguageService().setLocale(locale);
              await DataService().reloadForLocale(value);
              setState(() {}); // Rebuild UI with new data
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'en',
                child: Text('English'),
              ),
              const PopupMenuItem<String>(
                value: 'ta',
                child: Text('தமிழ் (Tamil)'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: _previousDay,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: _nextDay,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildLandscape(context, verse, saint);
          } else {
            return _buildPortrait(context, verse, saint);
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _navigateTo(index, context);
        },
        selectedIndex:
            0, // Always 0 as these act as actions, not persistent tabs in this design
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'Readings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Saints',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Bible',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookmarksPage()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.bookmark),
      ),
    );
  }

  void _navigateTo(int index, BuildContext context) {
    // 0 is Home (do nothing)
    if (index == 1) {
      // Mass Readings
      final reading = DataService()
          .getDailyReading(DateFormat("yyyy-MM-dd").format(_currentDate));
      if (reading != null) {
        // We need to map our strong typed model back to Map for the legacy screen until we refactor it
        // OR, better, refactor the screen now. But for strict steps:
        // Let's pass the raw JSON map for now as 'dailyMassReadings.dart' expects it
        // Actually, I can construct the map it expects.
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MassReadings(dailyreadings: {
                      "day": reading.day,
                      "first": reading.firstTitle,
                      "first_reading": reading.firstReading,
                      "psalm": reading.psalmTitle,
                      "psalm_reading": reading.psalmReading,
                      "second": reading.secondTitle,
                      "second_reading": reading.secondReading,
                      "gospel": reading.gospelTitle,
                      "gospel_reading": reading.gospelReading,
                    })));
      }
    } else if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  SearchPage(saintlist: {}))); // TODO: Pass full list
    } else if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BookScreen(bible: DataService().bible)));
    }
  }

  Widget _buildPortrait(BuildContext context, Verse verse, Saint saint) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          // Date Header with gradient background
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat("EEEE").format(_currentDate),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat("dd MMMM yyyy").format(_currentDate),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),

          // Verse Card
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Card(
                    elevation: 6,
                    shadowColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.02),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.format_quote,
                            size: 32,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(height: 16),
                          SelectableText(
                            verse.text,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  height: 1.6,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => Share.share(verse.text),
                                icon: const Icon(Icons.share, size: 18),
                                label: const Text('Share'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                onPressed: _toggleBookmark,
                                icon: Icon(
                                  _isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  size: 18,
                                ),
                                label: Text(_isBookmarked ? 'Saved' : 'Save'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isBookmarked
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                  foregroundColor: _isBookmarked
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
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
            ),
          ),

          // Saint of the Day Card
          Container(
            margin: const EdgeInsets.all(16),
            child: Card(
              elevation: 6,
              shadowColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  _openSaintPage(context, saint);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                        Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            saint.imagePath,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saint of the Day",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              saint.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context, Verse verse, Saint saint) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat("EEEE, dd MMMM yyyy").format(_currentDate),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Text(
                    verse.text,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () => Share.share(verse.text),
                  icon: const Icon(Icons.share)),
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              _openSaintPage(context, saint);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(saint.imagePath,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) =>
                        const Icon(Icons.person, size: 100)),
                const SizedBox(height: 16),
                Text(saint.name,
                    style: Theme.of(context).textTheme.headlineSmall),
                Text(saint.period,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openSaintPage(BuildContext context, Saint saint) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaintPage(
          saint: {
            "name": saint.name,
            "period": saint.period,
            "img": saint.imagePath,
            "about": saint.about,
          },
        ),
      ),
    );
  }
}
