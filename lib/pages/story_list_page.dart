import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../db/db_helper.dart';
import 'story_form_page.dart';
import 'story_detail_page.dart';

class StoryListPage extends StatefulWidget {
  const StoryListPage({super.key});

  @override
  State<StoryListPage> createState() => _StoryListPageState();
}

class _StoryListPageState extends State<StoryListPage> {
  List<Story> _stories = [];

  void _loadStories() async {
    final data = await DBHelper().getStories();
    setState(() {
      _stories = data;
    });
  }

  void _deleteStory(int id) async {
    await DBHelper().deleteStory(id);
    _loadStories();
  }

  void _navigateToForm({Story? story}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StoryFormPage(story: story),
      ),
    );
    _loadStories();
  }

  void _navigateToDetail(Story story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StoryDetailPage(story: story),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'My Stories',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // ✅ Center only the app bar title
      ),
      body: _stories.isEmpty
          ? const Center(child: Text('No Stories Yet.'))
          : ListView.builder(
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          final shortContent = story.content.split(' ').take(30).join(' ') +
              (story.content.split(' ').length > 30 ? '...' : '');

          return Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (story.imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            story.imageUrl,
                            width: 80,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'By ${story.author}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'read') {
                            _navigateToDetail(story);
                          } else if (value == 'edit') {
                            _navigateToForm(story: story);
                          } else if (value == 'delete') {
                            _deleteStory(story.id!);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'read',
                            child: Row(
                              children: [
                                Icon(Icons.visibility, color: Colors.black54),
                                SizedBox(width: 8),
                                Text('Read'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.black54),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.black54),
                                SizedBox(width: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    shortContent,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
