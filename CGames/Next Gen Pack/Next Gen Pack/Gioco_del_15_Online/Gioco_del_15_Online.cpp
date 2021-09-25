#include <iostream>
#include <string>
#include <windows.h>
#include <fstream>
#include <conio.h>
#include <ctime>
#include <vector>

using namespace std;


struct Giocatore
{
	string nome;
	string punteggio;
};

fstream Classifica;
vector<Giocatore> giocatore; 

int i,j,k;
const int N=4;
const int M=4;
int board[N][M];

int mosse;
string messaggio1,messaggio2;
char scelta;
bool vinto=false;

string nome;


void menu()
{
	system("CLS");
	
	cout<<"\nBenvenuto "<<nome<<"!\n\n"<<endl;
	
	cout<<"\n1=Gioca"<<endl;
	cout<<"\n2=Hall of Fame"<<endl;
	cout<<"\n3=Esci\n"<<endl;
	
	cin>>scelta;
}


void showBoard()
{
	system("CLS");
	
	cout<<"\n"<<endl;
	cout<<"    +-----+-----+-----+-----+"<<endl;
	
	for(i=0; i<N; i++)
	{
		cout<<"    |     |     |     |     |"<<endl;
		cout<<"    |";
		
		for(j=0; j<M; j++)
		{
			if(board[i][j]<10)
			{
				cout<<"  ";
				if(board[i][j]==0)
					cout<<" "<<"  |";
				else
					cout<<board[i][j]<<"  |";
			}
			else if(board[i][j]<100)
			{
				cout<<" ";
				cout<<board[i][j]<<"  |";
			}
		}
		
		if(i==0)
			cout<<"\t\tMosse: "<<mosse;
		if(i==1)
			cout<<"\t\t"<<messaggio1;
		if(i==2)
			cout<<"\t\t"<<messaggio2;
		cout<<endl;
		cout<<"    |     |     |     |     |"<<endl;
		cout<<"    +-----+-----+-----+-----+"<<endl;
	}
}


void movSU()
{
	for(i=0; i<N; i++)
	{
		for(j=0; j<M; j++)
		{
			if(board[i][j]==0 && i!=0)
			{
				board[i][j]=board[i-1][j];
				board[i-1][j]=0;
				
				j=M;
				i=N;
				mosse++;
			}
		}
	}
}

void movGIU()
{
	for(i=0; i<N; i++)
	{
		for(j=0; j<M; j++)
		{
			if(board[i][j]==0 && i!=3)
			{
				board[i][j]=board[i+1][j];
				board[i+1][j]=0;
				
				j=M;
				i=N;
				mosse++;
			}
		}
	}
}

void movSX()
{
	for(i=0; i<N; i++)
	{
		for(j=0; j<M; j++)
		{
			if(board[i][j]==0 && j!=0)
			{
				board[i][j]=board[i][j-1];
				board[i][j-1]=0;
				
				j=M;
				i=N;
				mosse++;
			}
		}
	}
}

void movDX()
{
	for(i=0; i<N; i++)
	{
		for(j=0; j<M; j++)
		{
			if(board[i][j]==0 && j!=3)
			{
				board[i][j]=board[i][j+1];
				board[i][j+1]=0;
				
				j=M;
				i=N;
				mosse++;
			}
		}
	}
}


void Randomizza()
{	
	srand((unsigned)time(NULL));
	int mossa;
	
	
	board[0][0]=1;
	board[0][1]=2;
	board[0][2]=3;
	board[0][3]=4;
	board[1][0]=5;
	board[1][1]=6;
	board[1][2]=7;
	board[1][3]=8;
	board[2][0]=9;
	board[2][1]=10;
	board[2][2]=11;
	board[2][3]=12;
	board[3][0]=13;
	board[3][1]=14;
	board[3][2]=15;
	board[3][3]=0;
	
	for(mossa=0; mossa<1000; mossa++)
	{
		k=rand()%4;
		
		switch(k)
		{
			case 0:
			{
				movSU();
				break;
			}
			
			case 1:
			{
				movSX();
				break;
			}
			
			case 2:
			{
				movGIU();
				break;
			}
			
			case 3:
			{
				movDX();
				break;
			}
		}
	}
	
	mosse=0;
}


void checkVittoria()
{
	if(	board[0][0]==1 &&
		board[0][1]==2 &&
		board[0][2]==3 &&
		board[0][3]==4 &&
		board[1][0]==5 &&
		board[1][1]==6 &&
		board[1][2]==7 &&
		board[1][3]==8 &&
		board[2][0]==9 &&
		board[2][1]==10 &&
		board[2][2]==11 &&
		board[2][3]==12 &&
		board[3][0]==13 &&
		board[3][1]==14 &&
		board[3][2]==15 &&
		board[3][3]==0	)
	{
		vinto=true;
		messaggio2="HAI VINTO!";
	}

}


void gioca()
{	
	vinto=false;
	messaggio1="";
	messaggio2="";
	
	system("CLS");
	
	cout<<"\nCome giocare:\n"<<endl;
	cout<<"\nComandi: W/A/S/D oppure 8/4/2/6 per muovere la casella vuota."<<endl;
	cout<<"\nRegolamento: Se non sai giocare al gioco del 15 sei stupido...\n\n"<<endl;
	system("pause");
	
	Randomizza();
	
	while(!vinto)
	{
		showBoard();
		
		cout<<"\n\n\n"<<endl;
		scelta=getch();
		
		switch(scelta)
		{
			case 'w':
			case 'W':
			case '8':
			{
				movSU();
				break;
			}
			
			case 'a':
			case 'A':
			case '4':
			{
				movSX();
				break;
			}
			
			case 's':
			case 'S':
			case '2':
			{
				movGIU();
				break;
			}
			
			case 'd':
			case 'D':
			case '6':
			{
				movDX();
				break;
			}
		}
		
		checkVittoria();
	}
	
	Classifica.open("Classifica.txt", ios::out | ios::app);
	Classifica << "0"+nome << "\n" << mosse << "\n";
	Classifica.close();
	
	showBoard();
	cout<<"\n\n\n"<<endl;
	system("pause");
}


bool esiste(string line)
{
	for(i=0; i<giocatore.size(); i++)
	{
		if(giocatore[i].nome==line)
			return true;
	}
	
	return false;
}

void checkPunteggio(string vNome, string line)
{
	for(i=0; i<giocatore.size(); i++)
	{
		if(giocatore[i].nome == vNome)
		{
			if(giocatore[i].punteggio > line)
			{
				giocatore[i].punteggio=line;
			}
		}
	}
}

void halloffame()
{
	string line,vNome;
	bool ver=false;
	Giocatore nuovo,tmp;
	
	giocatore.clear();
	
	Classifica.open("Classifica.txt", ios::in);
	while(getline(Classifica,line))
	{
		if(line[0]=='0')
		{
			line.erase(line.begin());
			
			if(esiste(line))
			{
				ver=true;
				vNome=line;
			}
			else
			{
				ver=false;
				nuovo.nome=line;
			}
		}
		else
		{
			if(ver)
			{
				checkPunteggio(vNome, line);
			}
			else
			{
				nuovo.punteggio=line;
				giocatore.push_back(nuovo);
			}
		}
	}
	Classifica.close();
	
	
	int value1,value2;
	for(i=0; i<giocatore.size()-1; i++)
	{
		for(j=i+1; j<giocatore.size(); j++)
		{
			value1=atoi(giocatore[i].punteggio.c_str());
			value2=atoi(giocatore[j].punteggio.c_str());
			if(value1 > value2)
			{
				tmp=giocatore[i];
				giocatore[i]=giocatore[j];
				giocatore[j]=tmp;
			}
		}
	}
	
	
	system("CLS");
	
	for(i=0; i<giocatore.size(); i++)
	{
		cout<<i+1<<". "<<giocatore[i].nome<<" - "<<giocatore[i].punteggio<<endl;;
	}
	
	cout<<"\n\n"<<endl;
	system("pause");
}


int main()
{
	bool esci=false;
	
	cout<<"\nBenvenuto nel mio gioco del 15 Online!         by H3LL (Alessandro Morina)"<<endl;
	cout<<"\n                                               ver. Final 1.1.1.0\n"<<endl;
	
	cout<<"\nInserisci il tuo nickname (MAX 12 lettere): ";
	do{
		cin>>nome;
	}while(nome.size()>12 || nome.size()==0);
	
	
	do{
		menu();
		
		switch(scelta)
		{
			case '1':
			{
				gioca();
				break;
			}
			
			case '2':
			{
				halloffame();
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
				cout<<"\nQuesta opzione non esiste, sei scemo?\n\n"<<endl;
				system("pause");
			}
		}
	}while(!esci);
}











