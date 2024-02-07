#include "Path.hpp"
#include "Storage.hpp"
#include <vector>
#include <list>
#include <fstream>
#include <initializer_list>
#include <string>
#include <memory>
#include <iostream>
using namespace std;

shared_ptr<Storage> Storage::m_instance = nullptr;

Storage::Storage(){
	readFromFile();
	m_dirty = false;
}

std::shared_ptr<Storage> Storage::getInstance(void){
	Storage * s = new Storage;
	if(m_instance == nullptr){
		m_instance = shared_ptr<Storage>(s);		
	}
	return m_instance;
}

bool Storage::readFromFile(void){
	bool flag;
	ifstream userpath(Path::userPath);
	ifstream meetingpath(Path::meetingPath);

	if(userpath&&meetingpath)
		flag=1;
	else
		flag=0;

	string users;
	string meetings;

	string usersRow;
	string meetingsRow;

	while(getline(userpath,usersRow))
		users += usersRow;

	while(getline(meetingpath,meetingsRow))
		meetings += meetingsRow;

	int s_user = 0;
	int s_meetings = 0;

	User cur_user;

	for(int i=0;i<users.length();i++){
		if(users[i]=='"'){
			s_user++;
			int j;				
			for(j=i+1;users[j]!='"'&&j<users.length();j++);
			if(s_user == 1){
				cur_user.setName(users.substr(i+1,j-i-1));
			}
			else if(s_user == 2){
				cur_user.setPassword(users.substr(i+1,j-i-1));
			} 
			else if(s_user == 3){
				cur_user.setEmail(users.substr(i+1,j-i-1));
			}
			else if(s_user == 4){
				s_user = 0;
				cur_user.setPhone(users.substr(i+1,j-i-1));
				this->m_userList.push_back(cur_user);
			}
			i=j;
		}
	}
	userpath.close();

	Meeting cur_meeting;
	for(int i=0;i<meetings.length();i++){
		if(meetings[i]=='"'){
			s_meetings++;
			int j;			
			for(j=i+1;meetings[j]!='"'&&j<meetings.length();j++);
			if(s_meetings == 1){
				cur_meeting.setSponsor(meetings.substr(i+1,j-i-1));
			}
			else if(s_meetings == 2){
				vector<string> partiUser;
				string partis = meetings.substr(i+1,j-i-1);

				int mark=0;
				int tmp;
				for(tmp=0;tmp<partis.length();tmp++){
					if(partis[tmp] == '&'){
						partiUser.push_back(partis.substr(mark,tmp-mark));
						mark = tmp+1;
					}
				}
				partiUser.push_back(partis.substr(mark,tmp-mark));
				cur_meeting.setParticipator(partiUser);
			} 
			else if(s_meetings == 3){
				cur_meeting.setStartDate(Date::stringToDate(meetings.substr(i+1,j-i-1)));
			}
			else if(s_meetings == 4){
				cur_meeting.setEndDate(Date::stringToDate(meetings.substr(i+1,j-i-1)));
			}
			else if(s_meetings == 5){
				s_meetings = 0;
				cur_meeting.setTitle(meetings.substr(i+1,j-i-1));
				this->m_meetingList.push_back(cur_meeting);
			}
			i=j;
		}
	}
	meetingpath.close();

	if(flag==1)
		return true;
	else
		return false;
}

bool Storage::writeToFile(void){
	bool flag;
	ofstream userpath(Path::userPath,ios::trunc);
	ofstream meetingpath(Path::meetingPath,ios::trunc);

	if(userpath&&meetingpath)
		flag=1;
	else
		flag=0;

	string users;
	string meetings;

	for(auto it=m_userList.begin();it != m_userList.end();it++){
		users += "\"";
		users += it->getName();
		users += "\",\"";
		users += it->getPassword();
		users += "\",\"";
		users += it->getEmail();
		users += "\",\"";
		users += it->getPhone();
		users += "\"\n";
	}
	userpath << users;
	userpath.close();

	for(auto it=m_meetingList.begin();it != m_meetingList.end();it++){
		meetings += "\"";
		meetings += it->getSponsor();
		meetings += "\",\"";
		vector<string> partis=it->getParticipator();
		for(int i=0;i<partis.size();i++){
			meetings += partis[i];
			if(i!=partis.size()-1)
			meetings += "&";
		}	
		meetings += "\",\"";
		meetings += Date::dateToString(it->getStartDate());
		meetings += "\",\"";
		meetings += Date::dateToString(it->getEndDate());
		meetings += "\",\"";
		meetings += it->getTitle();
		meetings += "\"\n";
	}
	meetingpath << meetings;
	meetingpath.close();

	if(flag==1)
		return true;
	else
		return false;	
}

Storage::~Storage(){
	sync();
}

void Storage::createUser(const User &t_user){
	this->m_userList.push_back(t_user);
	m_dirty = 1;
	return;
}

std::list<User> Storage::queryUser(std::function<bool(const User &)> filter) const{
	list<User> us;
	for(auto it = m_userList.begin();it != m_userList.end();it ++){
		if(filter(*it))
			us.push_back(*it);
	}
	return us;
}

int Storage::updateUser(std::function<bool(const User &)> filter,
                 std::function<void(User &)> switcher){
	int count = 0;
	for(auto it = m_userList.begin();it != m_userList.end();it ++){
		if(filter(*it)){
			switcher(*it);
			count ++;
		}
	}	
	m_dirty = 1;
	return count;
}

int Storage::deleteUser(std::function<bool(const User &)> filter){
	int count = 0;
	list<User> n_userList;
	for(auto it = this->m_userList.begin();it != this->m_userList.end();it ++){	
		if(filter(*it)){
			count ++;
		}
		else{
			n_userList.push_back(*it);
		}
	}
	this->m_userList = n_userList;
	m_dirty = 1;
	return count;
}

void Storage::createMeeting(const Meeting &t_meeting){
	this->m_meetingList.push_back(t_meeting);
	m_dirty = 1;
	return;	
}

std::list<Meeting> Storage::queryMeeting(
    std::function<bool(const Meeting &)> filter) const{
	list<Meeting> us;
	for(auto it = m_meetingList.begin();it != m_meetingList.end();it ++){
		if(filter(*it))
			us.push_back(*it);
	}
	return us;
}

int Storage::updateMeeting(std::function<bool(const Meeting &)> filter,
                    std::function<void(Meeting &)> switcher){
	int count = 0;
	for(auto it = m_meetingList.begin();it != m_meetingList.end();it ++){
		if(filter(*it)){
			switcher(*it);
			count ++;
		}
	}	
	m_dirty = 1;
	return count;
}

int Storage::deleteMeeting(std::function<bool(const Meeting &)> filter){
	int count = 0;
	list<Meeting> n_meetingList;
	for(auto it = this->m_meetingList.begin();it != this->m_meetingList.end();it ++){
		if(filter(*it)){
			count ++;
		}
		else{
			n_meetingList.push_back(*it);		
		}
	}
	this->m_meetingList = n_meetingList;
	m_dirty = 1;
	return count;	
}

bool Storage::sync(void){
	if(!m_dirty)
		return false;
	else{
		writeToFile();
		m_dirty = false;
	}
	return true;
}
