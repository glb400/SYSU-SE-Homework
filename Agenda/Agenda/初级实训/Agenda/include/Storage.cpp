#include "Path.hpp"
#include "Storage.hpp"
#include "Meeting.hpp"
#include "Date.hpp"
#include <vector>
#include <list>
#include <fstream>
#include <initializer_list>
#include <string>
#include <memory>
using namespace std;

shared_ptr<Storage> Storage::m_instance = nullptr;

Storage(){
	m_dirty = false;
}

std::shared_ptr<Storage> Storage::getInstance(void){
	if(m_instance == nullptr)
		m_instance = shared_ptr<Storage>(new Storage());
	return m_instance;
}

bool Storage::readFromFile(void){
	bool flag;
	ofstream userpath(Path::userPath);
	ofstream meetingpath(Path::meetingPath);
	
	if(userpath&&meetingpath)
		flag=1;
	else
		flag=0;
	
	string users;
	string meetings;
	
	userpath >> users;
	meetingpath >> meetings;
	
	int s_user = 0;
	int s_meetings = 0;
	
	User cur_user;
	for(int i=0;i<users.length();i++){
		if(users[i]=='"'){
			s_user++;
			for(int j=i+1;users[j]!='"'||j<users.length();j++);
			if(s_user == 1){
				cur_user.setName(users.substr(i+1,j-i));
			}
			else if(s_user == 2){
				cur_user.setPassword(users.substr(i+1,j-i));
			} 
			else if(s_user == 3){
				cur_user.setEmail(users.substr(i+1,j-i));
			}
			else if(s_user == 4){
				s_user = 0;
				cur_user.setPhone(users.substr(i+1,j-i));
				this->m_userList.push_back(cur_user);
			}
			i=j+1;
		}
	}
	userpath.close();
	
	Meeting cur_meeting;
	for(int i=0;i<meetings.length();i++){
		if(meetings[i]=='"'){
			s_meetings++;
			for(int j=i+1;meetings[j]!='"'||j<meetings.length();j++);
			if(s_meetings == 1){
				cur_meeting.setSponsor(meetings.substr(i+1,j-i));
			}
			else if(s_meetings == 2){
				vector<User> partiUser;
				string partis = meetings.substr(i+1,j-i);
				
				int mark=0;
				for(int tmp=0;tmp<partis.length();tmp++){
					if(partis[tmp] == '&'){
						partiUser.push_back(partis.substr(mark,tmp-mark+1));
						mark = tmp+1;
					}
				}
				partiUser.push_back(partis.substr(mark,tmp-mark+1));
				
				cur_meeting.setParticipator(partiUser);
			} 
			else if(s_meetings == 3){
				cur_meeting.setStartDate(Date::stringToDate(meetings.substr(i+1,j-i)));
			}
			else if(s_meetings == 4){
				cur_meeting.setEndDate(Date::stringToDate(meetings.substr(i+1,j-i)));
			}
			else if(s_meetings == 5){
				s_meetings = 0;
				cur_meeting.setTitle(meetings.substr(i+1,j-i));
				this->m_meetingList.push_back(cur_meeting);
			}
			i=j+1;
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
	ifstream userpath(Path::userPath);
	ifstream meetingpath(Path::meetingPath);
	
	if(userpath&&meetingpath)
		flag=1;
	else
		flag=0;
	
	string users;
	string meetings;
	for(auto it=userList.begin();it != userList.end();it++){
		users += "\"";
		users += userList[i].getName();
		users += "\",\"";
		users += userList[i].getPassword();
		users += "\",\"";
		users += userList[i].getEmail();
		users += "\",\"";
		users += userList[i].getPhone();
		users += "\"\n";
	}
	userpath << users;
	userpath.close();
	
	for(auto it=meetingList.begin();it != meetingList.end();it++){
		meetings += "\"";
		meetings += meetingList[i].getSponsor();
		meetings += "\",\"";
		vector<User> partis=meetingList[i].getParticipator();
		for(int i=0;i<partis.size();i++){
			meetings += partis[i];
			meetings += "&";
		}	
		meetings += "\",\"";
		meetings += Date::dateToString(meetingList[i].getStartDate());
		meetings += "\",\"";
		meetings += Date::dateToString(meetingList[i].getEndDate());
		meetings += "\",\"";
		meetings += meetingList.getTitle();
		meetings += "\"\n";
	}
	meetingpath << meetings;
	meetingpath.close();
	
	if(flag==1)
		return true;
	else
		return false;	
}

~Storage(){
	sync();
}

void Storage::createUser(const User &t_user){
	this->m_userList.push_back(t_user);
	return;
}

std::list<User> Storage::queryUser(std::function<bool(const User &)> filter) const{
	list<User> us;
	list<User>::iterator it;
	for(it = m_userList.begin();it != m_userList.end();it ++){
		if(filter(*it))
			us.push_back(*it);
	}
	return us;
}

int Storage::updateUser(std::function<bool(const User &)> filter,
                 std::function<void(User &)> switcher){
	int count = 0;
	list<User>::iterator it;
	for(it = m_userList.begin();it != m_userList.end();it ++){
		if(filter(*it)){
			switcher(*it);
			count ++;
		}
	}	
	return count;
}

int Storage::deleteUser(std::function<bool(const User &)> filter){
	int count = 0;
	list<User>::iterator it;
	for(it = m_userList.begin();it != m_userList.end();it ++){
		if(filter(*it)){
			m_userList.erase(it);
			count ++;
		}
	}
	return count;
}

void Storage::createMeeting(const Meeting &t_meeting){
	this->m_userList.push_back(t_meeting);
	return;	
}

std::list<Meeting> Storage::queryMeeting(
    std::function<bool(const Meeting &)> filter) const{
	list<Meeting> us;
	list<Meeting>::iterator it;
	for(it = m_meetingList.begin();it != m_meetingList.end();it ++){
		if(filter(*it))
			us.push_back(*it);
	}
	return us;
}

int Storage::updateMeeting(std::function<bool(const Meeting &)> filter,
                    std::function<void(Meeting &)> switcher){
	int count = 0;
	list<Meeting>::iterator it;
	for(it = m_meetingList.begin();it != m_meetingList.end();it ++){
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
	list<Meeting>::iterator it;
	for(it = m_meetingList.begin();it != m_meetingList.end();it ++){
		if(filter(*it)){
			m_meetingList.erase(it);
			count ++;
		}
	}
	m_dirty = 1;
	return count;	
}

bool Storage::sync(void){
	if(!m_dirty)
		return false;
	else{
		writeToFile();
	}
	return true;
}

