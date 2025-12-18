import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/bookmark_service.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final BookmarkService _bookmarkService = BookmarkService();
  Map<String, String> _bookmarks = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await _bookmarkService.getBookmarks();
    setState(() {
      _bookmarks = bookmarks;
      _isLoading = false;
    });
  }

  Future<void> _removeBookmark(String date) async {
    await _bookmarkService.removeBookmark(date);
    await _loadBookmarks();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bookmark removed'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Verses'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarks.isEmpty
              ? _buildEmptyState()
              : _buildBookmarksList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            'No Bookmarks Yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the bookmark icon on verses\nto save them here',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarksList() {
    // Sort bookmarks by date (newest first)
    final sortedEntries = _bookmarks.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedEntries.length,
      itemBuilder: (context, index) {
        final entry = sortedEntries[index];
        final date = entry.key;
        final verse = entry.value;
        
        DateTime? parsedDate;
        try {
          parsedDate = DateTime.parse(date);
        } catch (e) {
          parsedDate = null;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      parsedDate != null
                          ? DateFormat('EEEE, dd MMMM yyyy').format(parsedDate)
                          : date,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => _removeBookmark(date),
                      tooltip: 'Remove bookmark',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  verse,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
