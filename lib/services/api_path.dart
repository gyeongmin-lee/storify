class APIPath {
  static List<String> _scopes = [
    'user-read-private',
    'user-read-email',
    'playlist-read-private'
  ];

  static String requestAuthorization(
          String clientId, String redirectUri, String state) =>
      'https://accounts.spotify.com/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&state=$state&scope=${_scopes.join('%20')}';

  static String requestToken = 'https://accounts.spotify.com/api/token';
  static String getCurrentUser = 'https://api.spotify.com/v1/me';
  static String getUserById(String userId) =>
      'https://api.spotify.com/v1/users/$userId';
  static String getListOfPlaylists = 'https://api.spotify.com/v1/me/playlists';
}
