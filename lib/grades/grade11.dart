import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Grade11Page extends StatefulWidget {
  @override
  _Grade11PageState createState() => _Grade11PageState();
}

class _Grade11PageState extends State<Grade11Page> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<String> folders = [];
  String? currentFolder; // Keeps track of the current folder

  @override
  void initState() {
    super.initState();
    _fetchFolders();
  }

  Future<void> _fetchFolders({String? folder}) async {
    try {
      // Fetch the list of files from Supabase bucket (replace 'bucket-name' with your actual bucket name)
      final List<FileObject> objects =
          await supabase.storage.from('pdfs').list(path: folder);

      // Extract folder names
      Set<String> uniqueFolders = {};
      for (var file in objects) {
        if (file.name.contains('/')) {
          // Consider folders by splitting on '/'
          final folderName = file.name.split('/').first;
          uniqueFolders.add(folderName);
        }
      }

      setState(() {
        folders = uniqueFolders.toList();
        currentFolder = folder;
      });
    } catch (e) {
      print('Error fetching folders: $e');
    }
  }

  Future<void> _openFolder(String folderName) async {
    final newPath =
        currentFolder == null ? folderName : '$currentFolder/$folderName';
    _fetchFolders(folder: newPath);
  }

  Future<void> _goBack() async {
    if (currentFolder != null && currentFolder!.contains('/')) {
      // Go back to parent folder
      final parentFolder =
          currentFolder!.substring(0, currentFolder!.lastIndexOf('/'));
      _fetchFolders(folder: parentFolder);
    } else {
      // Go to the root
      _fetchFolders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(currentFolder == null ? 'Folders' : 'Folder: $currentFolder'),
        backgroundColor: Colors.black87,
        leading: currentFolder != null
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _goBack,
              )
            : null,
      ),
      body: folders.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: folders.length,
              itemBuilder: (context, index) {
                final folder = folders[index];
                return ListTile(
                  leading: Icon(Icons.folder, color: Colors.amberAccent),
                  title: Text(
                    folder,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => _openFolder(folder),
                );
              },
            ),
    );
  }
}
