#include <iostream>
#include <vector>
#include <list>
#include <fstream>
#include <initializer_list>
#include <string>
#include <cstring>
#include <memory>
#include <iostream>
#include "AgendaUI.hpp"
using namespace std;
 
AgendaUI::AgendaUI(){
	startAgenda(); 
}

void AgendaUI::OperationLoop(void){
	string oper = "";
	while(oper[0] != 'q'){
		cout << "-----------------------------Agenda------------------------------" << endl;
		cout << "Action : " << endl;
		cout << "l   - log in Agenda by user name and password" << endl;
		cout << "r   - register an Agenda account" << endl;
		cout << "q   - quit Agenda" << endl;
		cout << "-----------------------------------------------------------------" << endl;
		cout << endl;
		cout << "Agenda : ~$ ";
		cin>>oper;
		if(oper[0]=='l')
			userLogIn();
		else if(oper[0]=='r')
			userRegister();
		else if(oper[0]=='q')
			quitAgenda();
	}
	return;
}

void AgendaUI::startAgenda(void){
	m_agendaService.startAgenda();
	return;
}

std::string AgendaUI::getOperation(){
	cout << "-----------------------------Agenda------------------------------" << endl;
	cout << "Action :" << endl;
	cout << "o   - log out Agenda" << endl;
	cout << "dc  - delete Agenda account" << endl;
	cout << "lu  - list all Agenda user" << endl;
	cout << "cm  - create a meeting" << endl;
	cout << "la  - list all meetings" << endl;
	cout << "las - list all sponsor meetings" << endl;
	cout << "lap - list all participate meetings" << endl;
	cout << "qm  - query meeting by title" << endl;
	cout << "qt  - query meeting by time interval" << endl;
	cout << "dm  - delete meeting by title" << endl;
	cout << "da  - delete all meetings" << endl;
	cout << "-----------------------------------------------------------------" << endl;
	cout << endl;
	cout << "Agenda@" << m_userName << " : # ";
	string oper;
	cin>>oper;
	return oper;
}

bool AgendaUI::executeOperation(std::string t_operation){
            if (t_operation == "o") {
                userLogOut();
                return false;
            }
            else if (t_operation == "dc") {
                deleteUser();
                return false;
            }
            else if (t_operation == "lu") {
                listAllUsers();
                return true;
            }
            else if (t_operation == "cm") {
                createMeeting();
                return true;
            }
            else if (t_operation == "la") {
                listAllMeetings();
                return true;
            }
            else if (t_operation == "las") {
                listAllSponsorMeetings();
                return true;
            }
            else if (t_operation == "lap") {
                listAllParticipateMeetings();
                return true;
            }
            else if (t_operation == "qm") {
                queryMeetingByTitle();
                return true;
            }
            else if (t_operation == "qt") {
                queryMeetingByTimeInterval();
                return true;
            }
            else if (t_operation == "dm") {
                deleteMeetingByTitle();
                return true;
            }
            else if (t_operation == "da") {
                deleteAllMeetings();
                return true;
            }
            return true;
}

void AgendaUI::userLogIn(void){
	cout << endl;
	cout << "[log in] [user name] [password]" << endl;
	cout << "[log in]";
	string userName,password;
	cin>>userName;
	cin>>password;
	if(m_agendaService.userLogIn(userName,password)){
		m_userName = userName;
		m_userPassword = password;
		cout << "[log in] succeed!" << endl;
		while(executeOperation(getOperation()));
	}
	else
		cout << "[error] log in failed!" << endl;
	return;
}

void AgendaUI::userRegister(void){
	cout << endl;
	cout << "[register] [user name] [password] [email] [phone]" << endl;
	cout << "[register]";
	string userName,password,email,phone;
	cin>>userName;
	cin>>password;
	cin>>email;
	cin>>phone;
	if(m_agendaService.userRegister(userName,password,email,phone)){
		cout << "succeed!" << endl;
		while(executeOperation(getOperation()));
	}
	else
		cout << "register fail!" << endl;
	return;
}

void AgendaUI::userLogOut(void){
	m_userName = "";
	m_userPassword = "";
	return;
}

void AgendaUI::quitAgenda(void){
	m_agendaService.quitAgenda();
	return;
}

void AgendaUI::deleteUser(void){
	m_agendaService.deleteUser(m_userName,m_userPassword);
	userLogOut();
	return;
}

void AgendaUI::listAllUsers(void){
	printUsers(m_agendaService.listAllUsers());
	return;
}

void AgendaUI::createMeeting(void){
	int number;
	cout << endl;
	cout << "[create meeting] [the number of participator]" << endl;
	cout << "[create meeting] ";
	cin >> number;
	vector<string> partis;
	for(int i=0;i<number;i++){
		cout << "[create meeting] " << "[please enter the participator " << i << " ]" << endl;
		cout << "[create meeting] ";
		string parti;
		cin >> parti;
		partis.push_back(parti);
	}
	string title,startTime,endTime;  
	cout << "[create meeting] [title] [start time(yyyy-mm-dd/hh:mm)] [end time(yyyy-mm-dd/hh:mm)]" << endl;	 
	cin >> title;
	cin >> startTime;
	cin >> endTime;
	cout << "[create meeting] ";
	if(m_agendaService.createMeeting(m_userName,title,startTime,endTime,partis))
		cout << "succeed!" << endl;
	else
		cout << "error!" << endl;
	return;
} 

void AgendaUI::listAllMeetings(void){
	cout << endl;
	cout << "[list all meetings]" << endl;
	cout << endl;
	printMeetings(m_agendaService.listAllMeetings(m_userName));
	return;
}

void AgendaUI::listAllSponsorMeetings(void){
	cout << endl;
	cout << "[list all sponsor meetings]" << endl;
	cout << endl;
	printMeetings(m_agendaService.listAllSponsorMeetings(m_userName));
	return;
}

void AgendaUI::listAllParticipateMeetings(void){
	cout << endl;
	cout << "[list all participator meetings]" << endl;
	cout << endl;
	printMeetings(m_agendaService.listAllParticipateMeetings(m_userName));
	return;
}

void AgendaUI::queryMeetingByTitle(void){
	cout << endl;
	cout << "[query meeting] [title]" << endl;
	cout << "[query meeting] ";
	string title;
	cin >> title;
	printMeetings(m_agendaService.meetingQuery(m_userName,title));
	return;
}

void AgendaUI::queryMeetingByTimeInterval(void){
	cout << endl;
	cout << "[query meeting] [start time(yyyy-mm-dd/hh:mm)] [end time(yyyy-mm-dd/hh:mm)]" << endl;
	cout << "[query meeting] ";
	string startTime,endTime;
	cin >> startTime;
	cin >> endTime;
	cout << "[query meeting]" << endl;
	cout << endl;
	printMeetings(m_agendaService.meetingQuery(m_userName,startTime,endTime));
	return;
}

void AgendaUI::deleteMeetingByTitle(void){
	cout << endl;
	cout << "[delete meeting] [title]" << endl;
	cout << "[delete meeting] ";
	string title;
	cin >> title;
	cout << endl;
	if(m_agendaService.deleteMeeting(m_userName,title))
		cout << "[delete meeting by title] succeed!" << endl;
	else
		cout << "[error] delete meeting fail" << endl;
	return;
}

void AgendaUI::deleteAllMeetings(void){
	m_agendaService.deleteAllMeetings(m_userName);
	cout << endl;
	cout << "[delete all meetings] succeed!" << endl;
	return;
}

void AgendaUI::printMeetings(std::list<Meeting> t_meetings){
	cout << "title" << "      " << "sponsor" << "      " << "start time" << "      " << "end time" << "      " << "participators" << endl;
	for(auto it = t_meetings.begin();it != t_meetings.end();it++){
		cout << it->getTitle() << "      " << it->getSponsor() << "      " << Date::dateToString(it->getStartDate()) << "      " << Date::dateToString(it->getEndDate());
		vector<string> partis = it->getParticipator();
		for(int i=0;i<partis.size();i++){
			cout << partis[i];
			if(i!=(partis.size()-1))
				cout << ",";
		}
		cout << endl;
	}
	return;
}
    
void AgendaUI::printUsers(std::list<User> t_users){
	cout << "name" << "      " << "email" << "      " << "phone" << endl;
	for(auto it = t_users.begin();it != t_users.end();it ++){
		cout << it->getName() << "      " << it->getEmail() << "      " << it->getPhone() << endl;
	} 
	return;
}

