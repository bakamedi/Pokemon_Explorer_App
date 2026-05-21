abstract class DeviceRepository {
  Future<String?> readString({required String key});
  Future<void> writeString({required String key, required String value});
  Future<void> writeBool({required String key, required bool value});
  Future<bool?> readBool({required String key});
  Future<void> delete({required String key});
  Future<void> clear();
}
