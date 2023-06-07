abstract class LocalDataAccess {
  void clearAccessToken();

  void clearRefreshToken();

  Future<String> getIdToken();

  Future setIdToken(String idToken);

  Future<String> getAccessToken();

  Future setAccessToken(String accessToken);

  Future<String> getRefreshToken();

  Future setRefreshToken(String accessToken);

  String getUserId();

  void setUserId(String userId);

  String getUserName();

  void setUsername(String username);

  String getPassword();

  void setPassword(String password);

  bool getAccountRemember();

  void setAccountRemember(bool accountRemember);

  Future<void> clearData();
}
