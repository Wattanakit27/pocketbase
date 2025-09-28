import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  bool _loading = true;
  List<RecordModel> items = [];

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final list = await context.read<PocketBaseService>().listCharacters();
      setState(() => items = list);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('โหลดข้อมูลล้มเหลว: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _delete(String id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: const Text('คุณต้องการลบรายการนี้หรือไม่?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('ยกเลิก')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('ลบ')),
        ],
      ),
    );
    if (ok != true) return;

    try {
      await context.read<PocketBaseService>().deleteCharacter(id);
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ลบสำเร็จ')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ลบไม่สำเร็จ: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<PocketBaseService>().logout();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final it = items[i];
                  return Card(
                    child: ListTile(
                      title: Text(it.data['name'] ?? ''),
                      subtitle: Text('role: ${it.data['role'] ?? '-'}   •   power: ${it.data['power'] ?? 0}'),
                      trailing: Wrap(spacing: 8, children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.pushNamed(
                              context,
                              '/edit',
                              arguments: it,
                            );
                            if (!mounted) return;
                            _load();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _delete(it.id),
                        ),
                      ]),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          if (!mounted) return;
          _load();
        },
        icon: const Icon(Icons.add),
        label: const Text('เพิ่มตัวละคร'),
      ),
    );
  }
}
