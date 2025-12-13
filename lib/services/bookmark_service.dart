import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkService {
  static const String _bookmarksKey = 'bookmarked_verses';
  
  // Add a verse to bookmarks
  Future<void> addBookmark(String date, String verse) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    
    bookmarks[date] = verse;
    
    await prefs.setString(_bookmarksKey, json.encode(bookmarks));
  }
  
  // Remove a verse from bookmarks
  Future<void> removeBookmark(String date) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    
    bookmarks.remove(date);
    
    await prefs.setString(_bookmarksKey, json.encode(bookmarks));
  }
  
  // Get all bookmarks
  Future<Map<String, String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getString(_bookmarksKey);
    
    if (bookmarksJson == null) {
      return {};
    }
    
    final Map<String, dynamic> decoded = json.decode(bookmarksJson);
    return decoded.map((key, value) => MapEntry(key, value.toString()));
  }
  
  // Check if a date is bookmarked
  Future<bool> isBookmarked(String date) async {
    final bookmarks = await getBookmarks();
    return bookmarks.containsKey(date);
  }
  
  // Toggle bookmark status
  Future<bool> toggleBookmark(String date, String verse) async {
    final isCurrentlyBookmarked = await isBookmarked(date);
    
    if (isCurrentlyBookmarked) {
      await removeBookmark(date);
      return false;
    } else {
      await addBookmark(date, verse);
      return true;
    }
  }
  
  // Bible Reading Bookmark Methods
  static const String _biblePositionKey = 'bible_reading_position';
  
  // Save Bible reading position
  Future<void> saveBiblePosition(String book, int chapter, int verse) async {
    final prefs = await SharedPreferences.getInstance();
    final position = {
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'timestamp': DateTime.now().toIso8601String(),
    };
    await prefs.setString(_biblePositionKey, json.encode(position));
  }
  
  // Get Bible reading position
  Future<Map<String, dynamic>?> getBiblePosition() async {
    final prefs = await SharedPreferences.getInstance();
    final positionJson = prefs.getString(_biblePositionKey);
    
    if (positionJson == null) {
      return null;
    }
    
    return json.decode(positionJson) as Map<String, dynamic>;
  }
  
  // Check if Bible bookmark exists
  Future<bool> hasBibleBookmark() async {
    final position = await getBiblePosition();
    return position != null;
  }
  
  // Clear Bible bookmark
  Future<void> clearBibleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_biblePositionKey);
  }
}
