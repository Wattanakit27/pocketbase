import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/pocketbase_service.dart';

class AddCharacterPage extends StatefulWidget {
  const AddCharacterPage({super.key});

  @override
  State<AddCharacterPage> createState() => _AddCharacterPageState();
}

class _AddCharacterPageState extends State<AddCharacterPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _role = TextEditingController();
  final _power = TextEditingController();
  bool _saving = false;

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await context.read<PocketBaseService>().addCharacter(
            name: _name.text.trim(),
            role: _role.text.trim(),
            power: int.tryParse(_power.text.trim()) ?? 0,
          );
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('บันทึกสำเร็จ')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('บันทึกไม่สำเร็จ: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มตัวละคร')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'name'),
                    validator: (v) => (v == null || v.isEmpty) ? 'ระบุชื่อ' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _role,
                    decoration: const InputDecoration(labelText: 'role'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _power,
                    decoration: const InputDecoration(labelText: 'power (number)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก')),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: _saving ? null : _submit,
                        icon: _saving
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.save),
                        label: const Text('บันทึก'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
