abstract class ProfileRepository {
  Future<void> changeProfileDetails({
    required String name,
    required String email,
    required String surname,
    required String middlename,
  });
}
