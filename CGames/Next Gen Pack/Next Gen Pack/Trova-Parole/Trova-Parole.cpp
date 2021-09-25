#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <ctime>
#include <windows.h>

using namespace std;


fstream Parole;
int i,j,k,h;
vector<string> parole;
char scelta;
char* fileName="Parole/parole.txt";

int numLettereIns=10;
vector<char> lettere;
vector<char> lettereObb;
string modePar="Singola";
string modeRic="Qualsiasi combinazione";
string modeEsp="Alfabetico";
bool singola=true;
bool normale=true;
bool alfabetico=true;
int numLetterePar=10;
int numLettereObb=0;
int minimo=1,massimo=10;

vector<string> paroleTrovate;



void CaricaParole(bool V)
{
	string line;
	parole.clear();
	
	Parole.open(fileName, ios::in);
	while(getline(Parole,line))
	{
		parole.push_back(line);
		
		if(V)
			cout<<line<<endl;
	}
	Parole.close();
}


void menu()
{
	system("CLS");
	cout<<"\nBenvenuto nel mio Trova-Parole!               by H3LL (Alessandro Morina)"<<endl;
	cout<<"\n                                              Ver. Final 4.2.3.8\n"<<endl;
	
	cout<<"\nScegli:"<<endl;
	cout<<"\n1=Trova-Parole!"<<endl;
	cout<<"\n2=Parametri"<<endl;
	cout<<"\n3=Esci\n"<<endl;
	
	cin>>scelta;
}


void impostazioni()
{
	bool esciImp=false;
	char lettera;
		
	
	do{
		system("CLS");
		
		cout<<"\nParametri:                                                      0= Indietro\n"<<endl;
		cout<<"\n1= Modalita' combinazioni: "<<modeRic<<endl;
		cout<<"\n2= Modalita' esposizione parole: "<<modeEsp<<endl;
		cout<<"\n3= Numero lettere da inserire: "<<numLettereIns<<endl;
		cout<<"\n4= Lettere: ";
		if(normale)
		{
			for(i=0; i<lettere.size(); i++)
			{
				cout<<lettere[i]<<" ";
			}
			
			cout<<endl;
		}
		else
		{
			cout<<"\n"<<endl;
			
			for(i=0; i<lettere.size();)
			{
				cout<<"\t    ";
				
				for(j=0; j<4 && i<lettere.size(); j++)
				{
					cout<<lettere[i]<<" ";
					i++;
				}
				
				cout<<"\n"<<endl;
			}
		}
		cout<<"\n5= Numero lettere obbligatorie: "<<numLettereObb<<endl;
		cout<<"\n6= Lettere obbligatorie: ";
		for(i=0; i<lettereObb.size(); i++)
		{
			cout<<lettereObb[i]<<" ";
		}
		cout<<"\n\n7= Parola Mode: "<<modePar<<endl;
		if(singola)
		{
			cout<<"\n8= Numero lettere parola: "<<numLetterePar<<endl;
		}
		else
		{
			cout<<"\n8= Lettere Min: "<<minimo<<" - Lettere Max: "<<massimo<<endl;
		}
		cout<<endl;
		
		cin>>scelta;
		
		switch(scelta)
		{
			case '0':
			{
				esciImp=true;
				break;
			}
			
			case '1':
			{
				if(normale)
				{
					normale=false;
					modeRic="Ruzzle Style";
				}
				else
				{
					normale=true;
					modeRic="Qualsiasi combinazione";
				}
				break;
			}
			
			case '2':
			{
				if(alfabetico)
				{
					alfabetico=false;
					modeEsp="Lunghezza";
				}
				else
				{
					alfabetico=true;
					modeEsp="Alfabetico";
				}
				break;
			}
			
			case '3':
			{
				system("CLS");
				cout<<"\nInserisci il numero di lettere da inserire (MIN 1 - MAX 26): ";
				do{
					cin>>numLettereIns;
				}while(numLettereIns < 1 || numLettereIns > 26);
				massimo=numLettereIns;
				break;
			}
			
			case '4':
			{
				lettere.clear();
				system("CLS");
				cout<<"\nInserisci le "<<numLettereIns<<" lettere (devono essere minuscole):"<<endl;
				for(i=0; i<numLettereIns; i++)
				{
					do{
						cin>>lettera;
					}while(lettera < 97 || lettera > 122);
					
					lettere.push_back(lettera);
				}
				break;
			}
			
			case '5':
			{
				system("CLS");
				cout<<"\nInserisci il numero di lettere obbligatorie da inserire (MIN 0 - MAX "<<numLettereIns<<"): ";
				do{
					cin>>numLettereObb;
				}while(numLettereObb < 0 || numLettereObb > numLettereIns);
				break;
			}
			
			case '6':
			{
				lettereObb.clear();
				system("CLS");
				cout<<"\nInserisci le "<<numLettereObb<<" lettere (devono essere minuscole):"<<endl;
				for(i=0; i<numLettereObb; i++)
				{
					do{
						cin>>lettera;
					}while(lettera < 97 || lettera > 122);
					
					lettereObb.push_back(lettera);
				}
				break;
			}
			
			case '7':
			{
				if(singola)
				{
					singola=false;
					modePar="Range";
				}
				else
				{
					singola=true;
					modePar="Singola";
				}
				break;
			}
			
			case '8':
			{
				if(singola)
				{
					system("CLS");
					cout<<"\nInserisci il numero di lettere della parola (MIN 1 - MAX "<<numLettereIns<<"): ";
					do{
						cin>>numLetterePar;
					}while(numLetterePar < 1 || numLetterePar > numLettereIns);
					break;
				}
				else
				{
					system("CLS");
					cout<<"\nInserisci il numero di lettere minime della parola (MIN 1 - MAX "<<numLettereIns<<"): ";
					do{
						cin>>minimo;
					}while(minimo < 1 || minimo > numLettereIns);
					cout<<"\nInserisci il numero di lettere massime della parola (MIN "<<minimo<<" - MAX "<<numLettereIns<<"): ";
					do{
						cin>>massimo;
					}while(massimo < minimo || massimo > numLettereIns);
					break;
				}
				break;
			}
			
			default:
			{
				system("CLS");
				cout<<"\nQuesta opzione non esiste rimbecillito.\n\n"<<endl;
				system("pause");
			}
		}
	}while(!esciImp);
}



void OrdinamentoAlfabetico()
{
	string tmp;
	
	for(i=0; i<paroleTrovate.size()-1; i++)
	{
		for(j=i+1; j<paroleTrovate.size(); j++)
		{
			if(paroleTrovate[i] > paroleTrovate[j])
			{
				tmp=paroleTrovate[i];
				paroleTrovate[i]=paroleTrovate[j];
				paroleTrovate[j]=tmp;
			}
		}
	}
}


void OrdinamentoLunghezza()
{
	string tmp;
	
	for(i=0; i<paroleTrovate.size()-1; i++)
	{
		for(j=i+1; j<paroleTrovate.size(); j++)
		{
			if(paroleTrovate[i].size() > paroleTrovate[j].size())
			{
				tmp=paroleTrovate[i];
				paroleTrovate[i]=paroleTrovate[j];
				paroleTrovate[j]=tmp;
			}
		}
	}
}


bool ContieneGiusto(string par, vector<char> vLettere, vector<char> vLettereObb)
{
	bool ver=false;

	for(j=0; j<par.size(); j++)	
	{
		for(k=0; k<vLettere.size(); k++)
		{
			if(par[j] == vLettere[k])
			{
				vLettere.erase(vLettere.begin()+k);
				k=vLettere.size()+1;
				ver=true;
			}
			else
				ver=false;
		}
		
		if(ver == false)
			return false;
	}
	
	
	for(k=0; k<vLettereObb.size(); k++)
	{
		for(j=0; j<par.size(); j++)
		{
			if(par[j] == vLettereObb[k])
			{
				vLettereObb.erase(vLettereObb.begin()+k);
				j=par.size()+1;
				ver=true;
			}
			else
				ver=false;
		}
		
		if(ver == false)
			return false;
	}
	
	return true;
}


bool ContieneGiustoRuzzleStyle(string par, vector<char> vLettere, vector<char> vLettereObb)
{
	bool ver=false;
	vector<char> vLettere2=vLettere;
	int omg=0;
	
	for(k=0; k<vLettere2.size(); k++)
	{
		vLettere=vLettere2;
		
		if(par[0] == vLettere[k])
		{
			h=k;
			vLettere[h]=' ';
			
			for(j=1; j<par.size(); j++)
			{
				ver=false;
				
				if(!ver)
				{
					if(h-5>=0 && h%4!=0)
					{
						if(par[j] == vLettere[h-5])
						{
							vLettere[h-5]=' ';
							h=h-5;
							ver=true;
						}
					}
				}
				
				if(!ver)
				{
					if(h-4>=0)
					{
						if(par[j] == vLettere[h-4])
						{
							vLettere[h-4]=' ';
							h=h-4;
							ver=true;
						}
					}
				}
				
				if(!ver)
				{
					if(h-3>=0 && h%4!=3)
					{
						if(par[j] == vLettere[h-3])
						{
							vLettere[h-3]=' ';
							h=h-3;
							ver=true;
						}
					}
				}
				
				if(!ver)
				{
					if(h-1>=0 && h%4!=0)
					{
						if(par[j] == vLettere[h-1])
						{
							vLettere[h-1]=' ';
							h=h-1;
							ver=true;
						}
					}
				}
				
				if(!ver)
				{
					if(h+1<vLettere.size() && h%4!=3)
					{
						if(par[j] == vLettere[h+1])
						{
							vLettere[h+1]=' ';
							h=h+1;
							ver=true;
						}
					}
				}
				
				if(!ver)
				{
					if(h+3<vLettere.size() && h%4!=0)
					{
						if(par[j] == vLettere[h+3])
						{
							vLettere[h+3]=' ';
							h=h+3;
							ver=true;
						}
					}
				}
				
				if(!ver)
				{
					if(h+4<vLettere.size())
					{
						if(par[j] == vLettere[h+4])
						{
							vLettere[h+4]=' ';
							h=h+4;
							ver=true;
						}
					}
				}
				
				if(!ver)
				{
					if(h+5<vLettere.size() && h%4!=3)
					{
						if(par[j] == vLettere[h+5])
						{
							vLettere[h+5]=' ';
							h=h+5;
							ver=true;
						}
					}
				}
				
				if(ver==false)
					j=par.size();
			}
			
			if(ver==true)
			{
				k=vLettere2.size();
			}
				
		}
	}
	
	if(ver==false)
		return false;
	
	
	
	for(k=0; k<vLettereObb.size(); k++)
	{
		for(j=0; j<par.size(); j++)
		{
			if(par[j] == vLettereObb[k])
			{
				vLettereObb.erase(vLettereObb.begin()+k);
				j=par.size()+1;
				ver=true;
			}
			else
				ver=false;
		}
		
		if(ver == false)
			return false;
	}
	
	return true;
}


void trova_parole()
{
	srand((unsigned)time(NULL));
	
	int val,index;
	string parola="";
	paroleTrovate.clear();
	
	if(normale)
	{
		if(singola)
		{
			for(i=0; i<parole.size(); i++)
			{
				if(parole[i].size() == numLetterePar)
				{
					if(ContieneGiusto(parole[i], lettere, lettereObb))
					{
						paroleTrovate.push_back(parole[i]);
					}
				}
			}
		}
		else
		{
			for(i=0; i<parole.size(); i++)
			{
				if(parole[i].size() >= minimo && parole[i].size() <= massimo)
				{
					if(ContieneGiusto(parole[i], lettere, lettereObb))
					{
						paroleTrovate.push_back(parole[i]);
					}
				}
			}	
		}
	}
	else
	{
		if(singola)
		{
			for(i=0; i<parole.size(); i++)
			{
				if(parole[i].size() == numLetterePar)
				{
					if(ContieneGiustoRuzzleStyle(parole[i], lettere, lettereObb))
					{
						paroleTrovate.push_back(parole[i]);
					}
				}
			}
		}
		else
		{
			for(i=0; i<parole.size(); i++)
			{
				if(parole[i].size() >= minimo && parole[i].size() <= massimo)
				{
					if(ContieneGiustoRuzzleStyle(parole[i], lettere, lettereObb))
					{
						paroleTrovate.push_back(parole[i]);
					}
				}
			}	
		}
	}
	
	
	
	if(alfabetico)
	{
		OrdinamentoAlfabetico();
	}
	else
	{
		OrdinamentoLunghezza();
	}
	
	system("CLS");
	if(paroleTrovate.size() == 0)
	{
		cout<<"\nNessuna parola trovata..."<<endl;
	}
	else if(paroleTrovate.size() > 250 && normale)
	{
		cout<<"\nLe parole trovate sono davvero molte ("<<paroleTrovate.size()<<"),"<<endl;
		cout<<"cosi' tante che non ci stanno sullo schermo..."<<endl;
		cout<<"Cerca di essere piu' preciso nei Parametri."<<endl;
	}
	else
	{
		if(paroleTrovate.size()!=1)
			cout<<"\nHo trovato "<<paroleTrovate.size()<<" parole:\n"<<endl;
		else
			cout<<"\nHo trovato "<<paroleTrovate.size()<<" parola:\n"<<endl;
		
		for(i=0; i<paroleTrovate.size(); i++)
		{
			cout<<paroleTrovate[i]<<endl;
		}
	}
	cout<<"\n\n"<<endl;
	system("pause");
}


int main()
{
	bool esci=false;
	lettere.push_back('a');
	lettere.push_back('l');
	lettere.push_back('e');
	lettere.push_back('s');
	lettere.push_back('s');
	lettere.push_back('a');
	lettere.push_back('n');
	lettere.push_back('d');
	lettere.push_back('r');
	lettere.push_back('o');

	
	
	cout<<"\nPremi 'S' se vuoi che incominci a caricare tutte le parole che conosco"<<endl;
	cout<<"in modalita' SUPER VELOCE WOW."<<endl;
	cout<<"(modalita' efficiente )\n"<<endl;
	
	cout<<"Premi 'L' se vuoi che incominci a caricare tutte le parole che conosco"<<endl;
	cout<<"in maniera abbastanza lenta in modo che tu possa vedere il procedimento."<<endl;
	cout<<"(modalita' bella da vedere)\n"<<endl;
	
	do{
		cin>>scelta;
	}while(scelta!= 's' && scelta!= 'S' && scelta!= 'l' && scelta!= 'L');

	if(scelta=='s' || scelta=='S')
		CaricaParole(false);
	else
		CaricaParole(true);
		
		
	do{
		menu();
		
		switch(scelta)
		{
			case '1':
			{
				system("CLS");
				cout<<"\nSto cercando..."<<endl;
				trova_parole();
				break;
			}
			
			case '2':
			{
				impostazioni();
				break;
			}
			
			case '3':
			{
				esci=true;
				break;
			}
			
			default:
			{
				system("CLS");
				cout<<"\nQuesta opzione non esiste idiota.\n\n"<<endl;
				system("pause");
			}
		}
	
	}while(!esci);
}
