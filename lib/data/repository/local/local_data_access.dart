abstract class LocalDataAccess {
  void clearAccessToken();

  String getAccessToken();

  void setAccessToken(String accessToken);

  String getRefreshToken();

  void setRefreshToken(String accessToken);

  String getUserId();

  void setUserId(String userId);

  String getUserName();

  void setUsername(String username);

  String getPassword();

  void setPassword(String password);

  bool getAccountRemember();

  void setAccountRemember(bool accountRemember);

  void clearData();
}
