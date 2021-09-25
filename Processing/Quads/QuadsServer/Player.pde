class Player
{
  String name;
  String ip;
  int c;
  Client client;
  
  Player(Client _client)
  {
    client = _client;
    ip = client.ip();
    name = "";
  }
}