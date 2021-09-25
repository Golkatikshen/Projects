#include <iostream>
#include <string>
#include <conio.h>
#include <fstream>
#include <vector>
#include <cstdlib>

using namespace std;


int i,j,k;
string msg,line;
string nome="";

vector<string>output;
vector<string>utenti;

fstream Output;
fstream Utenti;

bool esci=false;
bool admin=false;
int ibanned;
bool bannato=false;


void leggiFileOutput()
{
	Output.open("Output.txt", ios::in);
	
	output.clear();
	
	while(getline(Output,line))
	{
		output.push_back(line);
		
		if(output.size()>20)
		{
			output.erase(output.begin());
		}
	}
	
	Output.close();
}

void leggiFileUtenti()
{
	Utenti.open("Utenti.txt", ios::in);
	
	utenti.clear();
	
	while(getline(Utenti,line))
	{
		utenti.push_back(line);
	}
	
	Utenti.close();
}


bool esisteGia()
{
	for(i=0; i<utenti.size(); i++)
	{
		if(utenti[i] == nome || utenti[i] == "[ADMIN]"+nome)
			return true;
	}
	return false;
}


void toglimi()
{
	int idel;
	fstream Old;
	
	for(i=0; i<utenti.size(); i++)
	{
		if(nome == utenti[i])
			idel=i;
	}
	
	i=0;
	Utenti.open("Utenti.txt", ios::in);
	Old.open("Old.txt", ios::out);
	while(getline(Utenti,line))
	{
		if(i!=idel)
			Old << line << "\n";
		i++;
	}
	
	Utenti.close();
	Old.close();

	remove("Utenti.txt");
	rename("Old.txt", "Utenti.txt");
	
	Output.open("Output.txt", ios::out | ios::app);
	Output << ">>>>>>>>>>> " + nome + " si e' disconnesso... <<<<<<<<<<<\n";
	Output.close();
}


void BecameAdmin()
{
	int idel;
	fstream Old;
	
	for(i=0; i<utenti.size(); i++)
	{
		if(nome == utenti[i])
			idel=i;
	}
	
	i=0;
	Utenti.open("Utenti.txt", ios::in);
	Old.open("Old.txt", ios::out);
	while(getline(Utenti,line))
	{
		if(i==idel)
			Old << "[ADMIN]" + line << "\n";
		else
			Old << line <<"\n";
		i++;
	}
	
	Utenti.close();
	Old.close();

	remove("Utenti.txt");
	rename("Old.txt", "Utenti.txt");
	
	Output.open("Output.txt", ios::out | ios::app);
	Output << ">>>>>>>>>>> " + nome + " e' diventato ADMIN! <<<<<<<<<<<\n";
	Output.close();
	
	nome = "[ADMIN]"+nome;
}


void TheBanner(int ibanned)
{
	fstream Old;
	
	i=0;
	Utenti.open("Utenti.txt", ios::in);
	Old.open("Old.txt", ios::out);
	while(getline(Utenti,line))
	{
		if(i==ibanned)
			Old << "[BANNED]" + line << "\n";
		else
			Old << line << "\n";
		i++;
	}
	
	Utenti.close();
	Old.close();

	remove("Utenti.txt");
	rename("Old.txt", "Utenti.txt");
	
	Output.open("Output.txt", ios::out | ios::app);
	Output << ">>>>>>>>>>> " + utenti[ibanned] + " e' stato BANNATO! <<<<<<<<<<<\n";
	Output.close();
}


void showScreen()
{
	system("CLS");
	
	cout<<endl;
	leggiFileUtenti();
	for(i=0; i<utenti.size(); i++)
	{
		cout<<utenti[i]<<" - ";
	}
	cout<<"\n\n------------+-----------------+-------------------+----------------------------"<<endl;
	if(utenti.size()<10)
		cout<<" Online: "<<utenti.size()<<"  |                 | ver Final 2.3.2.0 | by H3LL (Alessandro Morina)"<<endl;
	else
		cout<<" Online: "<<utenti.size()<<" |                 | ver Final 2.3.2.0 | by H3LL (Alessandro Morina)"<<endl;
	cout<<"------------+-----------------+-------------------+----------------------------\n\n"<<endl;
	
	leggiFileOutput();
	for(i=0; i<output.size(); i++)
	{
		cout<<output[i]<<"\n"<<endl;
	}
}


bool checkBannato()
{
	for(i=0; i<utenti.size(); i++)
	{
		if("[BANNED]"+nome == utenti[i])
		{
			return true;
		}
	}
	return false;
}


void toglimiBannato()
{
	int idel;
	fstream Old;
	
	for(i=0; i<utenti.size(); i++)
	{
		if("[BANNED]"+nome == utenti[i])
			idel=i;
	}
	
	i=0;
	Utenti.open("Utenti.txt", ios::in);
	Old.open("Old.txt", ios::out);
	while(getline(Utenti,line))
	{
		if(i!=idel)
			Old << line << "\n";
		i++;
	}
	
	Utenti.close();
	Old.close();

	remove("Utenti.txt");
	rename("Old.txt", "Utenti.txt");
	
	Output.open("Output.txt", ios::out | ios::app);
	Output << ">>>>>>>>>>> " + nome + " si e' disconnesso con disonore... <<<<<<<<<<<\n";
	Output.close();
	
	bannato=true;
}


void togliBannati()
{
	int idel;
	fstream Old;
	string lineName;
	
	Utenti.open("Utenti.txt", ios::in);
	Old.open("Old.txt", ios::out);
	while(getline(Utenti,line))
	{
		lineName=line;
		line.erase(line.begin()+8,line.end());
		if(line!="[BANNED]")
			Old << lineName << "\n";
	}
	
	Utenti.close();
	Old.close();
	
	remove("Utenti.txt");
	rename("Old.txt", "Utenti.txt");
}


string vLine,vLine2;
void checkLastLine()
{
	Output.open("Output.txt", ios::in);
	Output.seekg (-40, ios::end);
	Output >> vLine;
	Output.close();
}


void onExit()
{
	if(nome!="" && !bannato)
		toglimi();
}


int main()
{
	atexit(onExit);
	char bottonePremuto;
	
	cout<<"Chat sviluppata usando il file-stream, C++ e un server connesso LAN"<<endl;
	cout<<"\n\nComandi (ricordateli bene...):"<<endl;
	cout<<"\nt = attiva chat - digita e poi premi invio"<<endl;
	cout<<"\n/e = esci dall chat (molto preferibile rispetto alla x in alto a destra)"<<endl;
	cout<<"\n/n = disattiva chat in caso l'avessi attivata per sbaglio"<<endl;
	cout<<"\nConsiglio: metti full screen la console (coprira' solo mezzo schermo)"<<endl;
	cout<<"\nAvviso: a volte bisogna premere 't' 2 volte per scrivere nella chat..."<<endl;
	cout<<"\n\n\nInserisci il tuo nickname (MAX 12 lettere): ";
	
	do{
		cin>>nome;	
	}while(nome.size()>12 || nome.size()==0 || esisteGia());
	
	output.push_back(">>>>>>>>>>> " + nome + " si e' connesso! <<<<<<<<<<<\n");
	Output.open("Output.txt", ios::out | ios::app);
	Output << ">>>>>>>>>>> " + nome + " si e' connesso! <<<<<<<<<<<\n";
	Output.close();
	Utenti.open("Utenti.txt", ios::out | ios::app);
	Utenti << nome << "\n";
	Utenti.close();
	
	checkLastLine();
	vLine2 = vLine;
	
	showScreen();
	
	do
	{	
		if(kbhit())
		{
			bottonePremuto = getch();
			if(bottonePremuto=='t' || bottonePremuto=='T')
			{
				cout<<": ";
				getline(cin,msg);
				
				if(msg=="/adminpowercometome" && !admin)
				{
					admin=true;
					BecameAdmin();
					showScreen();
				}
				else if(msg=="/ban" && admin)
				{
					cout<<"Inserisci l'ip da bannare: ";
					cin>>ibanned;
					TheBanner(ibanned);
					showScreen();
				}
				else if(msg=="/reset" && admin)
				{
					system("Reset.exe");
				}
				else if(msg=="/checkbannati" && admin)
				{
					togliBannati();
				}
				else if(msg=="/e")
				{
					return 0;
				}
				else if(msg=="/n" || msg=="" || msg==" " || msg=="  " || msg=="   " || msg=="    " || msg=="     " || msg=="      ")
				{
					showScreen();
				}
				else
				{
					msg= nome + ": " + msg + "\n";
					Output.open("Output.txt", ios::out | ios::app);
					Output << msg;
					Output.close();
				}
			}
		}
		else
		{
			checkLastLine();
			
			if(vLine != vLine2)
			{
				showScreen();
				vLine2 = vLine;
			}
			
			if(checkBannato())
			{
				toglimiBannato();
				return 0;
			}
		}
	}while(!esci);
}












