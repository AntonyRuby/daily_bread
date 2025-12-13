import 'package:flutter/material.dart';
import 'package:daily_bread/services/bookmark_service.dart';

class BookScreen extends StatefulWidget {
  final Map<String, dynamic> bible;
  const BookScreen({Key? key, required this.bible}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final BookmarkService _bookmarkService = BookmarkService();
  Map<String, dynamic>? _lastPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLastPosition();
  }

  Future<void> _loadLastPosition() async {
    final position = await _bookmarkService.getBiblePosition();
    setState(() {
      _lastPosition = position;
      _isLoading = false;
    });
  }

  Future<void> _resumeReading() async {
    if (_lastPosition == null) return;
    
    final book = _lastPosition!['book'] as String;
    final chapter = _lastPosition!['chapter'] as int;
    final verse = _lastPosition!['verse'] as int;

    if (!mounted) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Verses(
          bible: widget.bible,
          book: book,
          chapter: chapter,
          initialScrollToVerse: verse,
        ),
      ),
    );
  }

  Future<void> _clearBookmark() async {
    await _bookmarkService.clearBibleBookmark();
    setState(() {
      _lastPosition = null;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bookmark cleared')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final books = widget.bible.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Holy Bible"),
        actions: [
          if (_lastPosition != null)
            IconButton(
              icon: const Icon(Icons.bookmark_remove),
              tooltip: 'Clear bookmark',
              onPressed: _clearBookmark,
            ),
        ],
      ),
      body: Column(
        children: [
          // Resume reading banner
          if (!_isLoading && _lastPosition != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: InkWell(
                  onTap: _resumeReading,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Continue Reading',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_lastPosition!['book']} ${_lastPosition!['chapter'] + 1}:${_lastPosition!['verse'] + 1}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          // Books list
          Expanded(
            child: ListView.separated(
              itemCount: books.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                final bookName = books[index];
                return ListTile(
                  title: Text(bookName, style: Theme.of(context).textTheme.titleMedium),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chapters(
                          bible: widget.bible,
                          book: bookName,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Chapters extends StatelessWidget {
  final String book;
  final Map<String, dynamic> bible;
  const Chapters({Key? key, required this.bible, required this.book})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bible[book] is a List of List of Strings (Chapters -> Verses)
    final chaptersList = bible[book] as List;
    
    return Scaffold(
        appBar: AppBar(
            title: Text(book),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
            ),
            itemCount: chaptersList.length,
            itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Verses(
                                    bible: bible, book: book, chapter: index)));
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                            "${index + 1}",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer
                            ),
                        ),
                    ),
                );
            }),
        );
  }
}

class Verses extends StatefulWidget {
  final Map<String, dynamic> bible;
  final String book;
  final int chapter;
  final int? initialScrollToVerse;
  
  const Verses({
    Key? key,
    required this.bible,
    required this.book,
    required this.chapter,
    this.initialScrollToVerse,
  }) : super(key: key);

  @override
  State<Verses> createState() => _VersesState();
}

class _VersesState extends State<Verses> {
  final BookmarkService _bookmarkService = BookmarkService();
  final ScrollController _scrollController = ScrollController();
  int _currentVerse = 0;

  @override
  void initState() {
    super.initState();
    _currentVerse = widget.initialScrollToVerse ?? 0;
    
    // Scroll to the initial verse after the frame is built
    if (widget.initialScrollToVerse != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToVerse(widget.initialScrollToVerse!);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToVerse(int verseIndex) {
    if (_scrollController.hasClients) {
      // Approximate height per verse item (adjust if needed)
      const double itemHeight = 80.0;
      final double offset = verseIndex * itemHeight;
      
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _savePosition(int verseIndex) async {
    await _bookmarkService.saveBiblePosition(
      widget.book,
      widget.chapter,
      verseIndex,
    );
    setState(() {
      _currentVerse = verseIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final versesList = widget.bible[widget.book][widget.chapter] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.book} ${widget.chapter + 1}"),
        actions: [
          if (widget.chapter < (widget.bible[widget.book] as List).length - 1)
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: "Next Chapter",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Verses(
                      bible: widget.bible,
                      book: widget.book,
                      chapter: widget.chapter + 1,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: versesList.length,
        itemBuilder: (BuildContext context, int index) {
          final isBookmarked = index == _currentVerse;
          
          return ListTile(
            leading: CircleAvatar(
              radius: 12,
              backgroundColor: isBookmarked
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              child: Text(
                "${index + 1}",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isBookmarked
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            title: SelectableText(
              versesList[index],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                height: 1.5,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: Theme.of(context).colorScheme.primary,
              ),
              tooltip: 'Mark position',
              onPressed: () => _savePosition(index),
            ),
            onTap: () => _savePosition(index),
          );
        },
      ),
      floatingActionButton: _currentVerse > 0
          ? FloatingActionButton.small(
              onPressed: () => _scrollToVerse(_currentVerse),
              tooltip: 'Go to bookmark',
              child: const Icon(Icons.bookmark),
            )
          : null,
    );
  }
}
