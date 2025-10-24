import 'dart:io';
import 'package:cutzhub/client/registration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Manage_project extends StatefulWidget {
  const Manage_project({super.key});

  @override
  State<Manage_project> createState() => _Manage_projectState();
}

// ------------------- GLOBALS -------------------
int? prid;
File? _selectedPdfPath;
Dio dio = Dio();
ValueNotifier<List<dynamic>> projectDataNotifier = ValueNotifier([]);
final _formKey = GlobalKey<FormState>();
 Future<void> get_project(context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? loginid = prefs.getInt('login_id');

      if (loginid == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User not logged in')));
        return;
      }

      final response = await dio.get('$baseurl/Manageproject_Api/$loginid');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is List) {
          projectDataNotifier.value = List.from(response.data);
        } else if (response.data is Map &&
            response.data['data'] != null &&
            response.data['data'] is List) {
          projectDataNotifier.value = List.from(response.data['data']);
        } else {
          projectDataNotifier.value = [];
        }

        if (projectDataNotifier.value.isNotEmpty) {
          prid = int.parse(projectDataNotifier.value[0]['id'].toString());
          print("First project id: $prid");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch projects')),
        );
      }
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }
final TextEditingController _nameController = TextEditingController();
final TextEditingController _categoryController = TextEditingController();
final TextEditingController _budgetController = TextEditingController();
final TextEditingController _deadlineController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();

// ------------------- MAIN CLASS -------------------
class _Manage_projectState extends State<Manage_project> {
  // ✅ Post project (upload)
  Future<void> post_project(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? loginid = prefs.getInt('login_id');

      if (loginid == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User not logged in')));
        return;
      }

      FormData formData = FormData.fromMap({
        'Title': _nameController.text,
        'Category': _categoryController.text,
        'Budget': _budgetController.text,
        'Deadline': _deadlineController.text,
        'Description': _descriptionController.text,
        'Attachment': _selectedPdfPath != null
            ? await MultipartFile.fromFile(
                _selectedPdfPath!.path,
                filename: _selectedPdfPath!.path.split('/').last,
              )
            : null,
      });

      final response = await dio.post(
        '$baseurl/Manageproject_Api/$loginid',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Project added successfully')),
        );

        _nameController.clear();
        _categoryController.clear();
        _budgetController.clear();
        _deadlineController.clear();
        _descriptionController.clear();

        setState(() {
          _selectedPdfPath = null;
        });

        // ✅ Refresh list after adding project
        await get_project(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add project')),
        );
      }
    } catch (e) {
      print('Error uploading project: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred')),
      );
    }
  }

  // ✅ Get projects
 

  // ✅ Date picker field
  Widget _buildDatePickerField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: Icon(Icons.calendar_today, color: Colors.white70),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter $label' : null,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(foregroundColor: Colors.green),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (pickedDate != null) {
            controller.text =
                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          }
        },
      ),
    );
  }

  // ✅ Add project bottom sheet
  void bottomsheet_add(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(_nameController, "Project Name"),
                  _buildTextField(_categoryController, "Category"),
                  _buildTextField(
                    _budgetController,
                    "Budget",
                    keyboardType: TextInputType.number,
                  ),
                  _buildDatePickerField(_deadlineController, "Deadline"),
                  _buildTextField(
                    _descriptionController,
                    "Description",
                    maxLines: 3,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );

                      if (result != null && result.files.single.path != null) {
                        setState(() {
                          _selectedPdfPath = File(result.files.single.path!);
                        });
                      }
                    },
                    child: Text(
                      _selectedPdfPath == null ? "Pick PDF" : "Change PDF",
                    ),
                  ),
                  if (_selectedPdfPath != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Selected PDF: ${_selectedPdfPath!.path.split('/').last}',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 63, 149, 66),
                        foregroundColor: Colors.white,
                        minimumSize: Size(200, 50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          post_project(context);
                        }
                      },
                      child: Text("Add"),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ Text field builder
  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    get_project(context);
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  // ✅ Helper widget for info rows
  Widget _infoRow(String label, dynamic value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text('$label :', style: TextStyle(color: Colors.white)),
        ),
        Expanded(
          child: Text(
            ' ${value ?? ''}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 26, 26),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            Text(
              'ADD & MANAGE PROJECT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                bottomsheet_add(context);
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 10),
                    Text('NEW PROJECT', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<dynamic>>(
                valueListenable: projectDataNotifier,
                builder: (context, projects, _) {
                  if (projects.isEmpty) {
                    return Center(
                      child: Text(
                        'No projects found',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Card(
                          color: const Color.fromARGB(192, 82, 103, 94),
                          child: ListTile(
                            leading: Icon(Icons.picture_as_pdf_outlined,
                                color: Colors.white),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                project['Title'] ?? 'Project Title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                _infoRow('Category', project['Category']),
                                SizedBox(height: 10),
                                _infoRow('Budget', project['Budget']),
                                SizedBox(height: 10),
                                _infoRow('Deadline', project['Deadline']),
                                SizedBox(height: 10),
                                _infoRow('Description', project['Description']),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
