import 'package:flutapp/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import '../../widgets/dropdown_widget.dart';
import '../../core/storage/local_storage.dart';
import '../home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../core/state/app_state.dart';

class DepartmentBatchScreen extends StatefulWidget {
  const DepartmentBatchScreen({super.key});

  @override
  State<DepartmentBatchScreen> createState() =>
      _DepartmentBatchScreenState();
}

class _DepartmentBatchScreenState
    extends State<DepartmentBatchScreen> {
  String? dept;
  String? batch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropdown(
              hint: "Select Department",
              items: ["CSE", "BBA"],
              value: dept,
              onChanged: (val) => setState(() => dept = val),
            ),
            const SizedBox(height: 20),
            CustomDropdown(
              hint: "Select Batch",
              items: ["63", "64"],
              value: batch,
              onChanged: (val) => setState(() => batch = val),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (dept != null && batch != null) {
                  await LocalStorage.saveUserSelection(dept!, batch!);

                  context.read<AppState>().setUser(dept!, batch!);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainNav()),
                  );
                }
              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}