abstract class AuthInterface
{
  Future<bool> isLogged(String user, String password);
}