abstract class ProfileRepository {
  Future<void> changeProfileDetails({
    required String name,
    required String surname,
    required String middlename,
  });
}
