import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  PocketBaseService._();
  static final PocketBaseService _i = PocketBaseService._();
  factory PocketBaseService() => _i;

  // เปลี่ยน URL ให้ตรงสภาพแวดล้อมของคุณ
  // Android Emulator: http://10.0.2.2:8090
  // Windows/Chrome:   http://127.0.0.1:8090
  final pb = PocketBase('http://127.0.0.1:8090');

  // ---------- Auth ----------
  Future<void> login({required String email, required String password}) async {
    await pb.collection('users').authWithPassword(email, password);
  }

  bool get isLoggedIn => pb.authStore.isValid;
  String? get userEmail => pb.authStore.model?.getStringValue('email');
  Future<void> logout() async => pb.authStore.clear();

  // ---------- Character CRUD ----------
  Future<List<RecordModel>> listCharacters() async {
    final result = await pb.collection('character').getList(
      page: 1,
      perPage: 50,
      sort: '-created',
    );
    return result.items;
  }

  Future<RecordModel> getCharacter(String id) async {
    return await pb.collection('character').getOne(id);
  }

  Future<RecordModel> addCharacter({
    required String name,
    required String role,
    required int power,
  }) async {
    final data = {'name': name, 'role': role, 'power': power};
    return await pb.collection('character').create(body: data);
  }

  Future<RecordModel> updateCharacter({
    required String id,
    required String name,
    required String role,
    required int power,
  }) async {
    final data = {'name': name, 'role': role, 'power': power};
    return await pb.collection('character').update(id, body: data);
  }

  Future<void> deleteCharacter(String id) async {
    await pb.collection('character').delete(id);
  }
}
