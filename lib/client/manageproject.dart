import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Manage_project extends StatefulWidget {
  const Manage_project({super.key});

  @override
  State<Manage_project> createState() => _Manage_projectState();
}

class _Manage_projectState extends State<Manage_project> {
  void bottomsheet_add(context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _budgetController = TextEditingController();
    final TextEditingController _deadlineController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _pdfController = TextEditingController();

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
                  _buildTextField(_deadlineController, "Deadline"),
                  _buildTextField(
                    _descriptionController,
                    "Description",
                    maxLines: 3,
                  ),

                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                      if (result != null) {
                        _pdfController.text = result.files.single.name;
                      }
                    },
                    child: AbsorbPointer(
                      child: _buildTextField(_pdfController, "Pick PDF"),
                    ),
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 63, 149, 66),
                        foregroundColor: const Color.fromARGB(
                          255,
                          244,
                          241,
                          241,
                        ),
                        minimumSize: Size(200, 50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process the data here
                          Navigator.pop(context); // close the bottom sheet
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                      left: 15,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Card(
                      color: Color.fromARGB(192, 82, 103, 94),
                      child: ListTile(
                        leading: Icon(
                          Icons.picture_as_pdf_outlined,
                          color: Colors.white,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Project Name',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Category :',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Budget :',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Deadline :',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Description :',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(children: [Text('Status :')]),
                          ],
                        ),
                      ),
                    ),
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
