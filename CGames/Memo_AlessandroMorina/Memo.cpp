#include <iostream>
#include <string>
#include <ctime>

using namespace std;

int i,j,k;
char scelta;

string nome;
char board[8][36][2];
int X,Y;
bool vinto=false;

bool fatto=false;
bool piazzato=false;
bool esiste=false;
char pedina;
char giaUsciti[8*36];
int N,M;

int Xcoor1,Ycoor1,Xcoor2,Ycoor2;
int tentativi=0;
int punti;

string Nomi[9];
int Punteggi[9];

int iTMP;
string sTMP;

char eccezione1=176,
	 eccezione2=177,
	 eccezione3=178,
	 eccezione4=219;

void reinizializzazione()
{
	fatto=false;
	piazzato=false;
	esiste=false;
	tentativi=0;
}


void ShowBoard()
{
	system("CLS");
	
	cout<<"\n   ";
	for(i=0; i<X; i++)
		cout<<" "<<i%10;
	cout<<endl;
	
	cout<<"\n   +";
	for(i=0; i<X; i++)
		cout<<"-+";
	cout<<endl;
	
	for(k=0; k<Y; k++)
	{
		cout<<k<<"  |";
		for(i=0; i<X;i++)
			cout<<board[k][i][0]<<"|";
		cout<<endl;
		
		cout<<"   +";
		for(i=0; i<X; i++)
			cout<<"-+";
		cout<<endl;
	}
}



void menu()
{
	system("CLS");
	cout<<"\nBenvenuto nel mio gioco di Memo-Alphanumerico!     by H3LL (Alessandro Morina)"<<endl;
	cout<<"\n                                                   Ver Final 1.0.4.0\n"<<endl;
	
	cout<<"\nFai la tua scelta:\n"<<endl;
	cout<<"\n1= Gioca"<<endl;
	cout<<"\n2= Classifica"<<endl;
	cout<<"\n3= Esci\n"<<endl;
	
	cin>>scelta;
}



void gioca()
{
	//FASE INIZIALE
	system("CLS");
	cout<<"\nInserisci il tuo nome: ";
	cin>>nome;
	
	cout<<"\n\nOra inserisci le dimensioni del campo\n"<<endl;
	cout<<"(MAX 36x8) (Le caselle non possono essere dispari):\n"<<endl;
	
	do{
		cout<<"\nLarghezza: ";
		do{
			cin>>X;
		}while(X<0 || X>36);
		cout<<"\nAltezza: ";
		do{
			cin>>Y;
		}while(Y<0 || Y>8);
	}while((X*Y)%2==1);
	
	cout<<"\n\n"<<endl;
	system("pause");
	
	
	
	
	//INIZIALIZZAZIONE VALORI TABELLA
	srand((unsigned)time(NULL));
	
	for(i=0; i<8*36; i++)
	{
		giaUsciti[i]=' ';
	}
	
	for(i=0; i<Y; i++)
	{
		for(j=0; j<X; j++)
		{
			board[i][j][0]=' ';
			board[i][j][1]=' ';
		}
	}
	
	k=0;
	fatto=false;
	while(fatto==false)
	{
		esiste=true;
		while(esiste==true)
		{
			pedina=rand()%222+33;
			
			esiste=false;
	
			if(pedina==eccezione1 || pedina==eccezione2 || pedina==eccezione3 || pedina==eccezione4)
			{
				esiste=true;
			}
			else
			{
				for(i=0; i<k; i++)
				{
					if(pedina==giaUsciti[i])
						esiste=true;
				}
			}
		}
		
		piazzato=false;
		while(piazzato==false)
		{
			N=rand()%Y;
			M=rand()%X;
			if(board[N][M][1]==' ')
			{
				board[N][M][1]=pedina;
				piazzato=true;
			}
		}
		
		piazzato=false;
		while(piazzato==false)
		{
			N=rand()%Y;
			M=rand()%X;
			if(board[N][M][1]==' ')
			{
				board[N][M][1]=pedina;
				piazzato=true;
			}
		}
		
		giaUsciti[k]=pedina;
		k++;
		
		fatto=true;
		for(i=0; i<Y; i++)
		{
			for(j=0; j<X; j++)
			{
				if(board[i][j][1]==' ')
				 fatto=false;
			}
		}
	}
	
	
	//INIZIO GIOCO
	do{
		system("CLS");
		
		ShowBoard();
		
		do{
			cout<<"\nInserisci la coordinata Y: ";
			do{
				cin>>Ycoor1;	
			}while(Ycoor1<0 || Ycoor1>=Y);
			
			cout<<"\nInserisci la coordinata X: ";
			do{
				cin>>Xcoor1;	
			}while(Xcoor1<0 || Xcoor1>=X);
		}while(board[Ycoor1][Xcoor1][0]!=' ');
		
		board[Ycoor1][Xcoor1][0]=board[Ycoor1][Xcoor1][1];
		
		
		ShowBoard();
		
		do{
			cout<<"\nInserisci la coordinata Y: ";
			do{
				cin>>Ycoor2;	
			}while(Ycoor2<0 || Ycoor2>=Y);
			
			cout<<"\nInserisci la coordinata X: ";
			do{
				cin>>Xcoor2;
			}while(Xcoor2<0 || Xcoor2>=X);
		}while(board[Ycoor2][Xcoor2][0]!=' ');
		
		board[Ycoor2][Xcoor2][0]=board[Ycoor2][Xcoor2][1];
		
		
		ShowBoard();
		
		cout<<endl;
		system("pause");
		
		
		if(board[Ycoor1][Xcoor1][0]==board[Ycoor2][Xcoor2][0])
		{
			board[Ycoor1][Xcoor1][0]=178;
			board[Ycoor2][Xcoor2][0]=178;
		}
		else
		{
			board[Ycoor1][Xcoor1][0]=' ';
			board[Ycoor2][Xcoor2][0]=' ';
		}
		
		tentativi++;
		
		
		vinto=true;
		for(i=0; i<Y; i++)
		{
			for(j=0; j<X; j++)
			{
				if(board[i][j][0]==' ')
					vinto=false;
			}
		}
		
	}while(vinto==false);
	
	
	system("CLS");
	cout<<"\n"<<nome<<",\n"<<endl;
	cout<<"Avevi "<<X*Y<<" caselle.\n"<<endl;
	cout<<"Hai finito in "<<tentativi<<" tentativi.\n"<<endl;
	punti=X*Y*2-tentativi;
	cout<<"Hai totalizzato "<<punti<<" punti.\n\n"<<endl;
	system("pause");
	
	
	Nomi[8]=nome;
	Punteggi[8]=punti;
	
	for(i=0; i<8; i++)
	{
		for(j=i+1; j<9; j++)
		{
			if(Punteggi[i]<Punteggi[j])
			{
				iTMP=Punteggi[i];
				Punteggi[i]=Punteggi[j];
				Punteggi[j]=iTMP;
				
				sTMP=Nomi[i];
				Nomi[i]=Nomi[j];
				Nomi[j]=sTMP;
			}
		}
	}
}



void classifica()
{
	system("CLS");
	
	cout<<"\nClassifica: \n"<<endl;
	
	cout<<"1. "<<Nomi[0]<<" - Pt. "<<Punteggi[0]<<"\n"<<endl;
	cout<<"2. "<<Nomi[1]<<" - Pt. "<<Punteggi[1]<<"\n"<<endl;
	cout<<"3. "<<Nomi[2]<<" - Pt. "<<Punteggi[2]<<"\n"<<endl;
	cout<<"4. "<<Nomi[3]<<" - Pt. "<<Punteggi[3]<<"\n"<<endl;
	cout<<"5. "<<Nomi[4]<<" - Pt. "<<Punteggi[4]<<"\n"<<endl;
	cout<<"6. "<<Nomi[5]<<" - Pt. "<<Punteggi[5]<<"\n"<<endl;
	cout<<"7. "<<Nomi[6]<<" - Pt. "<<Punteggi[6]<<"\n"<<endl;
	cout<<"8. "<<Nomi[7]<<" - Pt. "<<Punteggi[7]<<"\n\n\n"<<endl;
	
	system("pause");
}



int main()
{
	bool esci = false;
	
	for(i=0; i<9; i++)
	{
		Punteggi[i]=0;
		Nomi[i]="---";
	}
	
	do{
		reinizializzazione();
		
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
				classifica();
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
				cout<<"\nRitardato non vedi che puoi scegliere solo da 1 a 3?\n\n"<<endl;
				system("pause");
			}
		}
		
	}while(esci==false);
}
