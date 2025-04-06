import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final supabase = Supabase.instance.client;

  // Controllers for employee
  final TextEditingController hrpnController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController profilePicController = TextEditingController();

  DateTime? dob;
  DateTime? doj;
  String? selectedBranch;

  // Controllers for family member
  final TextEditingController fmNameController = TextEditingController();
  final TextEditingController fmRelationController = TextEditingController();
  DateTime? fmDob;
  final TextEditingController fmGenderController = TextEditingController();
  final TextEditingController fmPhoneController = TextEditingController();
  String? selectedEmployeeEmail;

  // Medical History Fields
  final TextEditingController allergyController = TextEditingController();
  final TextEditingController surgeryController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();

  List<String> employeeEmails = [];

  @override
  void initState() {
    super.initState();
    fetchEmployeeEmails();
  }

  Future<void> fetchEmployeeEmails() async {
    final res = await supabase.from('employee').select('email');
    setState(() {
      employeeEmails = List<String>.from(res.map((e) => e['email']));
    });
  }

  Future<void> registerEmployee() async {
    final hrpn = int.tryParse(hrpnController.text);
    if (hrpn == null || dob == null || doj == null || selectedBranch == null)
      return;

    await supabase.from('employee').insert({
      'hrpn': hrpn,
      'name': nameController.text,
      'dob': dob!.toIso8601String(),
      'gender': genderController.text,
      'blood_group': bloodGroupController.text,
      'height': double.tryParse(heightController.text),
      'weight': double.tryParse(weightController.text),
      'phone': phoneController.text,
      'email': emailController.text,
      'profile_picture': profilePicController.text,
      'date_of_joining': doj!.toIso8601String(),
      'branch': selectedBranch,
    });
  }

  Future<void> registerFamilyMember() async {
    if (selectedEmployeeEmail == null || fmDob == null) return;

    final employee =
        await supabase
            .from('employee')
            .select('id')
            .eq('email', selectedEmployeeEmail ?? '')
            .maybeSingle();
    if (employee == null) return;

    final employeeId = employee['id'];

    final inserted =
        await supabase
            .from('family_members')
            .insert({
              'name': fmNameController.text,
              'relation': fmRelationController.text,
              'dob': fmDob!.toIso8601String(),
              'gender': fmGenderController.text,
              'contact_info': {'phone': fmPhoneController.text},
            })
            .select()
            .single();

    await supabase.from('medical_history').insert({
      'employee_id': employeeId,
      'family_member_id': inserted['id'],
      'person_type': 'Family',
      'record_date': DateTime.now().toIso8601String(),
      'allergy': allergyController.text,
      'surgery': surgeryController.text,
      'blood_pressure': bpController.text,
      'bmi': double.tryParse(bmiController.text),
    });
  }

  Future<void> selectDate(
    BuildContext context,
    DateTime? initial,
    void Function(DateTime) onPicked,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Register Employee",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: hrpnController,
              decoration: const InputDecoration(labelText: "HRPN"),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: "Gender"),
            ),
            TextField(
              controller: bloodGroupController,
              decoration: const InputDecoration(labelText: "Blood Group"),
            ),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: "Height"),
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: "Weight"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: profilePicController,
              decoration: const InputDecoration(
                labelText: "Profile Picture URL",
              ),
            ),
            ListTile(
              title: Text(dob == null ? "Pick DOB" : "DOB: ${dob!.toLocal()}"),
              trailing: const Icon(Icons.date_range),
              onTap:
                  () =>
                      selectDate(context, dob, (d) => setState(() => dob = d)),
            ),
            ListTile(
              title: Text(
                doj == null
                    ? "Pick Date of Joining"
                    : "Joining: ${doj!.toLocal()}",
              ),
              trailing: const Icon(Icons.date_range),
              onTap:
                  () =>
                      selectDate(context, doj, (d) => setState(() => doj = d)),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Branch'),
              value: selectedBranch,
              items:
                  [
                        'HQ',
                        'A COY',
                        'B COY',
                        'C COY',
                        'D COY',
                        'E COY',
                        'F COY',
                        'SAF',
                        'MT',
                        'WIRELESS',
                        'OFFICE STAFF',
                        'MEDICAL',
                      ]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) => setState(() => selectedBranch = val),
            ),
            ElevatedButton(
              onPressed: registerEmployee,
              child: const Text("Submit Employee"),
            ),
            const Divider(height: 40),

            const Text(
              "Add Family Member",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownSearch<String>(
              items: employeeEmails,
              popupProps: const PopupProps.menu(showSearchBox: true),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Select Employee by Email",
                ),
              ),
              onChanged: (val) => setState(() => selectedEmployeeEmail = val),
            ),
            TextField(
              controller: fmNameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: fmRelationController,
              decoration: const InputDecoration(labelText: "Relation"),
            ),
            TextField(
              controller: fmGenderController,
              decoration: const InputDecoration(labelText: "Gender"),
            ),
            TextField(
              controller: fmPhoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
            ListTile(
              title: Text(
                fmDob == null ? "Pick DOB" : "DOB: ${fmDob!.toLocal()}",
              ),
              trailing: const Icon(Icons.date_range),
              onTap:
                  () => selectDate(
                    context,
                    fmDob,
                    (d) => setState(() => fmDob = d),
                  ),
            ),

            const SizedBox(height: 20),
            const Text("Medical History", style: TextStyle(fontSize: 16)),
            TextField(
              controller: allergyController,
              decoration: const InputDecoration(labelText: "Allergy"),
            ),
            TextField(
              controller: surgeryController,
              decoration: const InputDecoration(labelText: "Surgery"),
            ),
            TextField(
              controller: bpController,
              decoration: const InputDecoration(labelText: "Blood Pressure"),
            ),
            TextField(
              controller: bmiController,
              decoration: const InputDecoration(labelText: "BMI"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: registerFamilyMember,
              child: const Text("Add Family Member"),
            ),
          ],
        ),
      ),
    );
  }
}
