import 'package:flutter/material.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/blogs_model.dart';

class AddBlogPage extends StatefulWidget {
  final int blogsLength;
  const AddBlogPage({super.key, required this.blogsLength});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

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
        _dateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  void _addBlog() async {
    final newBlog = Blogs(
      id: 0,
      title: _titleController.text,
      content: _contentController.text,
      publishDate: _dateController.text,
    );

    await supabase.from('blogs').insert({
      'title': newBlog.title,
      'content': newBlog.content,
      "color": "#EAF7FA",
      'created_at': newBlog.publishDate,
    });

    Navigator.pop(
      context,
    );
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
                  S.of(context).add_new_blog,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text('${S.of(context).blog_title}:',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
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
                    Text('${S.of(context).publish_date}:',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _dateController,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today,
                                color: Colors.indigo[900], size: 24),
                            onPressed: _pickDate,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
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
                Text('${S.of(context).content}:',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _contentController,
                  textAlign: TextAlign.right,
                  maxLines: 11,
                  decoration: InputDecoration(
                    hintText: S.of(context).mental_disorder,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: _addBlog,
                    child: Text(
                      S.of(context).adding,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
