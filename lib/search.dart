import 'dart:async';
import 'package:flutter/material.dart';
import 'package:daily_bread/services/data_service.dart';
import 'package:daily_bread/models/saint.dart';
import 'package:daily_bread/saintOfTheDay.dart';

class SearchPage extends StatefulWidget {
  // We can ignore the passed list and use DataService, but keeping parameter for compatibility if needed.
  // Actually, let's make it optional.
  final Map<String, dynamic>? saintlist;
  const SearchPage({Key? key, this.saintlist}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _SearchPageState extends State<SearchPage> {
  final _debouncer = Debouncer(milliseconds: 300);
  List<Saint> allSaints = [];
  List<Saint> filteredSaints = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load from DataService
    allSaints = DataService().getAllSaints();
    // Sort alphabetically
    allSaints.sort((a, b) => a.name.compareTo(b.name));
    filteredSaints = allSaints;

    _searchController.addListener(() {
        _debouncer.run(() {
            setState(() {
                final query = _searchController.text.toLowerCase();
                if (query.isEmpty) {
                    filteredSaints = allSaints;
                } else {
                    filteredSaints = allSaints.where((s) => s.name.toLowerCase().contains(query)).toList();
                }
            });
        });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Saints Dictionary"),
        ),
        body: Column(
            children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            labelText: "Search Saints",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                            filteredSaints = allSaints;
                                        });
                                    },
                                )
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                        ),
                    ),
                ),
                Expanded(
                    child: filteredSaints.isEmpty
                        ? Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    const Icon(Icons.search_off, size: 64, color: Colors.grey),
                                    const SizedBox(height: 16),
                                    Text(
                                        "No saints found",
                                        style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                ],
                            ),
                        )
                        : ListView.builder(
                            itemCount: filteredSaints.length,
                            itemBuilder: (BuildContext context, int index) {
                                final saint = filteredSaints[index];
                                return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    leading: Hero(
                                        tag: "list_${saint.imagePath}",
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(saint.imagePath),
                                            onBackgroundImageError: (e, s) {},
                                            child: null, // Fallback handled by errorBuilder usually, but here AssetImage doesn't have it direct. 
                                                         // Ideally we'd use a widget with error builder, but CircleAvatar is simpler.
                                        ),
                                    ),
                                    title: Text(saint.name, style: Theme.of(context).textTheme.titleMedium),
                                    subtitle: Text(saint.period, maxLines: 1, overflow: TextOverflow.ellipsis),
                                    onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SaintPage(saint: {
                                                      "img": saint.imagePath,
                                                      "about": saint.about,
                                                      "name": saint.name,
                                                      "period": saint.period,
                                                    })));
                                    },
                                );
                            }),
                )
            ],
        ),
    );
  }
}
