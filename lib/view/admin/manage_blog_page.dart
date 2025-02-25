import 'package:flutter/material.dart';
import 'package:jisser_app/view/admin/add_blog_page.dart';

import '../../model/blogs_model.dart';
import 'edit_blog_page.dart';


class ManageBlogPage extends StatefulWidget {
  const ManageBlogPage({super.key});

  @override
  State<ManageBlogPage> createState() => _ManageBlogPageState();
}

class _ManageBlogPageState extends State<ManageBlogPage> {
  TextEditingController _searchController = TextEditingController();
  List<Blogs> _filteredBlogs = [];


  @override
  void initState() {
    super.initState();
    _filteredBlogs = List.from(blogsList); // Ensure a fresh copy of the list
  }

  void _filterBlogs(String query) {
    setState(() {
      _filteredBlogs = blogsList.where((blogs) {
        final title = blogs.title.toLowerCase();
        final publishDate  = blogs.publishDate.toLowerCase();
        final searchLower = query.toLowerCase();
        return title.contains(searchLower)|| publishDate.contains(searchLower);
      }).toList();
    });
  }
  void _deleteBlog(Blogs blog) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد أنك تريد حذف هذه المقالة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                blogsList.remove(blog);
                _filteredBlogs = List.from(blogsList);
              });
              Navigator.pop(context);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child:
              Text(
                'إدارة المدونة',
                style: TextStyle(
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
                        hintText: 'بحث',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle,color: Colors.indigo[900],size: 30 ,),
                    onPressed: () async {
                      // Navigate to AddBlogPage and wait for the result
                      final newBlog = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddBlogPage(),
                        ),
                      );
                      // Check if newBlog is not null and add it to the list
                      if (newBlog != null) {
                        setState(() {
                          // Add the new blog to blogsList
                          blogsList.add(newBlog);
                          _filteredBlogs = List.from(blogsList); // Refresh the list
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
                    columns: const [
                      DataColumn(label: Text('العنوان')),
                      DataColumn(label: Text('تاريخ النشر')),
                      DataColumn(label: Text('تعديل')),
                      DataColumn(label: Text('حذف')),
                    ],
                    rows: _filteredBlogs.map((blogs) {
                      return DataRow(cells: [
                        DataCell(Text(blogs.title)),
                        DataCell(Text(blogs.publishDate)),
                        DataCell(IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () async {
                            // Navigate to the edit page and pass the current specialist
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBlogPage(
                                  blog: blogs, // Pass the current specialist data
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
