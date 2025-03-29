import 'package:flutter/material.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EditSpecialistPage extends StatefulWidget {
  final Specialist specialist;

  const EditSpecialistPage({super.key, required this.specialist});

  @override
  _EditSpecialistPageState createState() => _EditSpecialistPageState();
}

class _EditSpecialistPageState extends State<EditSpecialistPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? specialization;
  String? qualification;
  String accountStatus = 'قيد المراجعة';

  @override
  void initState() {
    super.initState();
    nameController.text = widget.specialist.name;
    emailController.text = widget.specialist.email;
    specialization = widget.specialist.specialty;
    qualification = widget.specialist.qualification;
    accountStatus = widget.specialist.active == true ? 'نشط' : 'غير نشط';
        /*? S.of(context).active
        : S.of(context).not_active;*/
  }

  void _submitForm() async {
    final updatedSpecialist = {
      'name': nameController.text,
      'email': emailController.text,
      'specialty': specialization,
      'qualification': qualification,
      // 'active': accountStatus == 'نشط',
    };

    await supabase
        .from('specialists')
        .update(updatedSpecialist)
        .match({'id': widget.specialist.id});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).successfully_updated)),
    );
    Navigator.pop(context);
  }

  Future<void> _launchPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).could_not_launch_pdf)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xfff3f7f9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Image.asset(
              'assets/jisserLogo.jpeg',
              width: 40,
              height: 40,
            ),
          ),
          actions: const [SizedBox(width: 48)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  S.of(context).edit_specialist_account,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF08174A),
                  ),
                ),
                const SizedBox(height: 50),
                buildLabeledField(
                    ': ${S.of(context).specialist_name}', nameController),
                const SizedBox(height: 16),
                buildLabeledField(': ${S.of(context).email}', emailController),
                const SizedBox(height: 16),
                buildLabeledDropdown(' : ${S.of(context).specialization}',
                    Specialist.specialties, specialization, (value) {
                      setState(() {
                        specialization = value;
                      });
                    }),
                const SizedBox(height: 16),
                buildLabeledDropdown(': ${S.of(context).qualification}',
                    Specialist.qualifications, qualification, (value) {
                      setState(() {
                        qualification = value;
                      });
                    }),
                const SizedBox(height: 16),
                if (widget.specialist.pdfUrl.isNotEmpty)
                  ElevatedButton(
                    onPressed: () => _launchPdf(widget.specialist.pdfUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff105793),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                    ),
                    child: Text(S.of(context).show_qualification_file,
                        style: const TextStyle(color: Colors.white)),
                  ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    ': ${S.of(context).status_account}  ',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildStatusButton(S.of(context).active),
                    const SizedBox(width: 8),
                    buildStatusButton(S.of(context).not_active),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff105793),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32),
                  ),
                  child: Text(S.of(context).edit,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabeledField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget buildLabeledDropdown(String label, List<String> items,
      String? selectedValue, Function(String?) onChanged) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xff105793)),
            iconEnabledColor: const Color(0xff105793),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(value),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget buildStatusButton(String status) {
    final isSelected = status == accountStatus;
    final supabase = Supabase.instance.client;

    Future<void> updateSpecialistStatus(bool isActive) async {
      try {
        // Update the specialist's status in Supabase
        await supabase.from('specialists').update({'active': isActive}).eq('id',
            widget.specialist.id); // Assuming you have access to specialist.id

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isActive ? 'تم تفعيل المتخصص بنجاح' : 'تم إلغاء تفعيل المتخصص',
                textAlign: TextAlign.right,
              ),
              backgroundColor: isActive ? Colors.green : Colors.red,
            ),
          );
        }
      } catch (e) {
        print('Error updating specialist status: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'حدث خطأ أثناء تحديث حالة المتخصص',
                textAlign: TextAlign.right,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    return GestureDetector(
      onTap: () async {
        setState(() {
          accountStatus = status;
        });

        // Update Supabase when status changes
        if (status == 'نشط') {
          await updateSpecialistStatus(true);
        } else if (status == 'غير نشط') {
          await updateSpecialistStatus(false);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff105793) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xff9e9e9e)),
        ),
        child: Text(
          status,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
