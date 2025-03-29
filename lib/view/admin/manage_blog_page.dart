import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/view/admin/add_blog_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/blogs_model.dart';
import 'edit_blog_page.dart';

class ManageBlogPage extends StatefulWidget {
  const ManageBlogPage({super.key});

  @override
  State<ManageBlogPage> createState() => _ManageBlogPageState();
}

class _ManageBlogPageState extends State<ManageBlogPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _searchController = TextEditingController();
  List<Blogs> _filteredBlogs = [];
  List<Blogs> blogsList = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs() async {
    try {
      final response = await supabase.from('blogs').select('*');
      // log(response.toString());
      setState(() {
        blogsList = (response as List).map((blog) => Blogs(
          id: blog['id'],
          title: blog['title'],
          content: blog['content'],
          publishDate: blog['created_at'],
        )).toList();
        _filteredBlogs = List.from(blogsList);
      });
    }  catch (e) {
      log(e.toString());
      // TODO
    }
  }

  void _filterBlogs(String query) {
    setState(() {
      _filteredBlogs = blogsList.where((blogs) {
        final title = blogs.title.toLowerCase();
        final publishDate = blogs.publishDate.toLowerCase();
        final searchLower = query.toLowerCase();
        return title.contains(searchLower) || publishDate.contains(searchLower);
      }).toList();
    });
  }

  void _deleteBlog(Blogs blog) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text(S.of(context).confirm_delete),
        content:  Text(S.of(context).are_you_sure_you_want_to_delete_this_blog),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              await supabase.from('blogs').delete().eq('id', blog.id);
              setState(() {
                blogsList.remove(blog);
                _filteredBlogs = List.from(blogsList);
              });
              Navigator.pop(context);
            },
            child:  Text(S.of(context).delete, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xfff3f7f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).manage_blogs,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterBlogs,
                      decoration: InputDecoration(
                        hintText: S.of(context).search,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.indigo[900], size: 30),
                    onPressed: () async {
                      final newBlog = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  AddBlogPage(
                            blogsLength: blogsList.length,
                          ),
                        ),
                      );
                      if (newBlog != null) {
                        setState(() {
                          blogsList.add(newBlog);
                          _filteredBlogs = List.from(blogsList);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffeae9e9)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DataTable(
                    columnSpacing: 18.0,
                    dataRowHeight: 45,
                    headingRowHeight: 40,
                    headingTextStyle: const TextStyle(
                      color: Color(0xff2b2c2c),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    dataTextStyle: const TextStyle(
                      fontSize: 11,
                    ),
                    columns:  [
                      DataColumn(label: Text(S.of(context).blog_title)),
                      // DataColumn(label: Text('تاريخ النشر')),
                      DataColumn(label: Text(S.of(context).edit)),
                      DataColumn(label: Text(S.of(context).delete)),
                    ],
                    rows: _filteredBlogs.map((blogs) {
                      return DataRow(cells: [
                        DataCell(SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: Text(
                                overflow:  TextOverflow.ellipsis,
                                blogs.title))),
                        // DataCell(Text(blogs.publishDate)),
                        DataCell(IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBlogPage(
                                  blog: blogs,
                                ),
                              ),
                            );
                            setState(() {
                              _filteredBlogs = List.from(blogsList);
                            });
                          },
                        )),
                        DataCell(IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBlog(blogs),
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}