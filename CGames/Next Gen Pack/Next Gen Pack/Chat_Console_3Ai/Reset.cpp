#include <fstream>

using namespace std;

fstream Output;
fstream Utenti;

int main()
{
	Output.open("Output.txt", ios::out);
	Output << "";
	Output.close();
	
	Utenti.open("Utenti.txt", ios::out);
	Utenti << "";
	Utenti.close();
}
