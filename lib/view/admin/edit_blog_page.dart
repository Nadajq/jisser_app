import 'package:flutter/material.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/blogs_model.dart';

class EditBlogPage extends StatefulWidget {
  final Blogs blog;
  const EditBlogPage({Key? key, required this.blog}) : super(key: key);

  @override
  State<EditBlogPage> createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _contentController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog.title);
    _dateController = TextEditingController(text: widget.blog.publishDate);
    _contentController = TextEditingController(text: widget.blog.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  void _updateBlog() async {
    final updatedBlog = Blogs(
      id: widget.blog.id,
      title: _titleController.text,
      content: _contentController.text,
      publishDate: _dateController.text,
    );

    await supabase.from('blogs').update({
      'title': updatedBlog.title,
      'content': updatedBlog.content,
      'created_at': updatedBlog.publishDate,
    }).eq('id', updatedBlog.id);

    Navigator.pop(context, updatedBlog);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFEAF7FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Image.asset('assets/jisserLogo.jpeg', width: 40, height: 40),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  S.of(context).edit_blog,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text('${S.of(context).blog_title}:', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text('${S.of(context).publish_date}:', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _dateController,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today, color: Colors.indigo[900], size: 24),
                            onPressed: _pickDate,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('${S.of(context).content}:', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _contentController,
                  textAlign: TextAlign.right,
                  maxLines: 11,
                  decoration: InputDecoration(
                    hintText: S.of(context).mental_disorder,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: _updateBlog,
                    child:  Text(
                      S.of(context).edit,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}