import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

// Post Model
class Post {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'imageUrl': imageUrl};
  }
}

// Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Social Media',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FeedScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Feed Screen: List posts
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final CollectionReference postsCollection = FirebaseFirestore.instance
      .collection('posts');

  Future<void> _deletePost(Post post) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Delete Post'),
            content: Text('Are you sure you want to delete this post?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Yes'),
              ),
            ],
          ),
    );

    if (shouldDelete ?? false) {
      try {
        await postsCollection.doc(post.id).delete();
        if (post.imageUrl != null) {
          await FirebaseStorage.instance.refFromURL(post.imageUrl!).delete();
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Post deleted')));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete post')));
      }
    }
  }

  Future<void> _downloadImage(String url) async {
    // Ask for storage permission on Android
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Storage permission is needed to download image'),
        ),
      );
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;

      final directory =
          await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/downloaded_${DateTime.now().millisecondsSinceEpoch}.png';

      final file = File(path);
      await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image downloaded successfully to $path')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to download image')));
    }
  }

  void _navigateToUpload() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UploadScreen()));
  }

  void _navigateToUpdate(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UpdateScreen(post: post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Social Feed', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToUpload,
            color: Colors.white,
            iconSize: 26,
            tooltip: 'Add Post',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text('Error loading posts'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) return Center(child: Text('No posts yet'));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, index) {
              final post = Post.fromFirestore(docs[index]);
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading:
                      post.imageUrl != null
                          ? GestureDetector(
                            onLongPress: () => _downloadImage(post.imageUrl!),
                            child: Image.network(
                              post.imageUrl!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                          : Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: Icon(Icons.image, color: Colors.grey[700]),
                          ),
                  title: Text(post.title),
                  subtitle: Text(post.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _navigateToUpdate(post),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletePost(post),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Upload Screen
class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  XFile? _selectedImage;

  final picker = ImagePicker();
  final postsCollection = FirebaseFirestore.instance.collection('posts');

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = picked; // store the XFile directly
      });
    }
  }

  Widget buildImagePreview() {
    if (_selectedImage == null) return SizedBox.shrink();

    if (kIsWeb) {
      return FutureBuilder<Uint8List>(
        future: _selectedImage!.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Image.memory(snapshot.data!, height: 150, fit: BoxFit.cover);
          } else {
            return SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    } else {
      return Image.file(
        File(_selectedImage!.path),
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }

  Future<String?> _uploadImage(XFile image) async {
    final fileName = 'posts/${DateTime.now().millisecondsSinceEpoch}.png';
    final ref = FirebaseStorage.instance.ref().child(fileName);

    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      await ref.putData(bytes, SettableMetadata(contentType: 'image/png'));
    } else {
      await ref.putFile(File(image.path));
    }

    return await ref.getDownloadURL();
  }

  Future<void> _uploadPost() async {
    if (_titleController.text.isEmpty || _descController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Title and description required')));
      return;
    }

    String? imageUrl;
    if (_selectedImage != null) {
      // Calls the new _uploadImage method which handles web/mobile
      imageUrl = await _uploadImage(_selectedImage!);
    }

    await postsCollection.add({
      'title': _titleController.text,
      'description': _descController.text,
      'imageUrl': imageUrl,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Post')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Post Title'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Post Description'),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              _selectedImage != null
                  ? buildImagePreview()
                  : SizedBox(
                    height: 150,
                    child: Center(child: Text('No Image Selected')),
                  ),

              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.photo),
                label: Text('Select Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _uploadPost, child: Text('Upload')),
            ],
          ),
        ),
      ),
    );
  }
}

// Update Screen
class UpdateScreen extends StatefulWidget {
  final Post post;

  UpdateScreen({required this.post});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  File? _newImageFile;
  String? _currentImageUrl;

  final picker = ImagePicker();
  final postsCollection = FirebaseFirestore.instance.collection('posts');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descController = TextEditingController(text: widget.post.description);
    _currentImageUrl = widget.post.imageUrl;
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _newImageFile = File(picked.path);
        _currentImageUrl = null; // will replace old image
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    final fileName = 'posts/${DateTime.now().millisecondsSinceEpoch}.png';
    final ref = FirebaseStorage.instance.ref().child(fileName);
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  Future<void> _updatePost() async {
    if (_titleController.text.isEmpty || _descController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Title and description required')));
      return;
    }

    String? imageUrl = _currentImageUrl;

    if (_newImageFile != null) {
      // Delete old image if exists
      if (_currentImageUrl != null) {
        try {
          await FirebaseStorage.instance.refFromURL(_currentImageUrl!).delete();
        } catch (e) {
          print('Error deleting old image: $e');
        }
      }
      imageUrl = await _uploadImage(_newImageFile!);
    }

    await postsCollection.doc(widget.post.id).update({
      'title': _titleController.text,
      'description': _descController.text,
      'imageUrl': imageUrl,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget =
        _newImageFile != null
            ? Image.file(_newImageFile!, height: 150)
            : _currentImageUrl != null
            ? Image.network(_currentImageUrl!, height: 150)
            : SizedBox(height: 150, child: Center(child: Text('No Image')));

    return Scaffold(
      appBar: AppBar(title: Text('Update Post')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Post Title'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Post Description'),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              imageWidget,
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.photo),
                label: Text('Change Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _updatePost, child: Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}
