import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../db/db_helper.dart';

class StoryFormPage extends StatefulWidget {
  final Story? story;

  const StoryFormPage({super.key, this.story});

  @override
  State<StoryFormPage> createState() => _StoryFormPageState();
}

class _StoryFormPageState extends State<StoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _genreCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.story != null) {
      _titleCtrl.text = widget.story!.title;
      _imageCtrl.text = widget.story!.imageUrl;
      _authorCtrl.text = widget.story!.author;
      _genreCtrl.text = widget.story!.genre;
      _contentCtrl.text = widget.story!.content;
    }
  }

  void _saveStory() async {
    if (_formKey.currentState!.validate()) {
      final newStory = Story(
        id: widget.story?.id,
        title: _titleCtrl.text,
        imageUrl: _imageCtrl.text,
        author: _authorCtrl.text,
        genre: _genreCtrl.text,
        content: _contentCtrl.text,
      );

      print('Saving story: ${newStory.toMap()}');

      if (widget.story == null) {
        await DBHelper().insertStory(newStory);
        print('Story inserted');
      } else {
        await DBHelper().updateStory(newStory);
        print('Story updated');
      }

      Navigator.pop(context);
    } else {
      print('Form tidak valid');
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _imageCtrl.dispose();
    _authorCtrl.dispose();
    _genreCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'My Stories',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value!.isEmpty ? 'Title is required!' : null,
              ),
              TextFormField(
                controller: _imageCtrl,
                decoration:
                const InputDecoration(labelText: 'Image URL'),
              ),
              TextFormField(
                controller: _authorCtrl,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              TextFormField(
                controller: _genreCtrl,
                decoration: const InputDecoration(labelText: 'Genre'),
              ),
              TextFormField(
                controller: _contentCtrl,
                decoration: const InputDecoration(labelText: 'Story'),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveStory,
                child: const Text('Save')
              )
            ],
          ),
        ),
      ),
    );
  }
}
