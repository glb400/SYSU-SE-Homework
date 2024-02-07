#include <vector>
#include <list>
#include <set>
#include <fstream>
#include <initializer_list>
#include <string>
#include <cstring>
#include <memory>
#include <iostream>
#include "AgendaService.hpp"

using namespace std;

AgendaService::AgendaService(){
	startAgenda();		
}

AgendaService::~AgendaService(){
	quitAgenda();
}

bool AgendaService::userLogIn(const std::string &userName, const std::string &password){
	list<User> us = m_storage->queryUser([userName,password](const User & user) -> bool{
		return userName == user.getName() && password == user.getPassword();
	});
	if(us.empty())
		return false;
	else
		return true;
}

bool AgendaService::userRegister(const std::string &userName, const std::string &password,
                    const std::string &email, const std::string &phone){	
	list<User> us = m_storage->queryUser([userName](const User & user) -> bool{
		return userName == user.getName();
	});
	if(us.empty()){
		m_storage->createUser(User(userName,password,email,phone));	
		return true;
	}
	else
		return false;
}

bool AgendaService::deleteUser(const std::string &userName, const std::string &password){
	list<User> us = m_storage->queryUser([userName,password](const User & user) -> bool{
		return userName == user.getName() && password == user.getPassword();
	});
	if(!us.empty()){
		m_storage->deleteUser([userName,password](const User & user) -> bool{
			return userName == user.getName() && password == user.getPassword();
		});
		m_storage->deleteMeeting([userName](const Meeting & meeting) -> bool{
			return userName == meeting.getSponsor();
		});
		m_storage->updateMeeting([userName](const Meeting & meeting) -> bool{
			return !meeting.isParticipator(userName);
		},[userName](Meeting & meeting) -> void{
			if(meeting.isParticipator(userName))
				meeting.removeParticipator(userName);
		});
		m_storage->deleteMeeting([](const Meeting & meeting) -> bool{
			return meeting.getParticipator().size() == 0;
		});
		return true;
	}
	else
		return false;
}

std::list<User> AgendaService::listAllUsers(void) const{
	list<User> us = m_storage->queryUser([](const User & user) -> bool{
		return true;	
	});
	return us;
}

bool AgendaService::createMeeting(const std::string &userName, const std::string &title,
                     const std::string &startDate, const std::string &endDate,
                     const std::vector<std::string> &participator){
	//judge Title
	list<Meeting> mt = m_storage->queryMeeting([title](const Meeting & meeting) -> bool{
		return title == meeting.getTitle();	
	});
	if(!mt.empty()){
		//cout << "1" << endl;
		return false;
	}
	
	//judge Date
	Date start(Date::stringToDate(startDate));
	Date end(Date::stringToDate(endDate));
	if(start>=end){
	//	cout << "2" << endl;		
		return false;
	}
	
	//judge Participator & Sponsor : exist && empty
	list<User> meetingSponsor = m_storage->queryUser([userName](const User & user) -> bool{
		return userName == user.getName();
	});
	if(meetingSponsor.empty() || !participator.size()){
		//cout << "3" << endl;
		return false;
	}
	for(auto i:participator){
		list<User> meetingParticipator = m_storage->queryUser([i](const User & user) -> bool{
			return i == user.getName();
		});
		if(meetingParticipator.empty()){
			//cout << "4" << endl;
			return false;
		}
	}
	
	//judge repeat
	set<string> check;
	for(auto i:	participator){
		check.insert(i);
		if(i == userName)
			return false;
	}
	if(check.size() != participator.size())
		return false;

	//judge other Meetings
	list<Meeting> meetingConflict = m_storage->queryMeeting([startDate,endDate](const Meeting & meeting) -> bool{
		Date inputStart(startDate);
		Date inputEnd(endDate);
		return !(meeting.getEndDate() < inputStart || meeting.getStartDate() > inputEnd); 
	});
	if(!meetingConflict.empty()){
		//cout << "5" << endl;
		for(auto i: meetingConflict){
			if(i.getSponsor() == userName || i.isParticipator(userName))
				return false;
		}
	}	

	m_storage->createMeeting(Meeting(userName,participator,startDate,endDate,title));
	return true;
}

bool AgendaService::addMeetingParticipator(const std::string &userName,
                              const std::string &title,
                              const std::string &participator){
	int count = 0; 
	count = m_storage->updateMeeting([userName,title](const Meeting & meeting) -> bool{
		return userName == meeting.getSponsor() && title == meeting.getTitle();
	},[participator](Meeting & meeting) -> void{
		if(!meeting.isParticipator(participator))
			meeting.addParticipator(participator);
		return;
	});
	if(count) return true;
	else return false;
}

bool AgendaService::removeMeetingParticipator(const std::string &userName,
                                 const std::string &title,
                                 const std::string &participator){
	int count = 0; 
	count = m_storage->updateMeeting([userName,title](const Meeting & meeting) -> bool{
		return userName == meeting.getSponsor() && title == meeting.getTitle();
	},[participator](Meeting & meeting) -> void{
		meeting.removeParticipator(participator);
	});
	if(count) return true;
	else return false;	
}

bool AgendaService::quitMeeting(const std::string &userName, const std::string &title){	
	int count = 0; 
	count = m_storage->updateMeeting([userName,title](const Meeting & meeting) -> bool{
		return meeting.isParticipator(userName) && meeting.getSponsor() != userName && title == meeting.getTitle();
	},[userName](Meeting & meeting) -> void{
		meeting.removeParticipator(userName);
	});
	m_storage->deleteMeeting([](const Meeting & meeting) -> bool{
			return meeting.getParticipator().size() == 0;
		});
	if(count) return true;
	else return false;
}

std::list<Meeting> AgendaService::meetingQuery(const std::string &userName,
                                  const std::string &title) const{
	list<Meeting>  mt = m_storage->queryMeeting([userName,title](const Meeting & meeting) -> bool{
		return title == meeting.getTitle() && (userName == meeting.getSponsor() || meeting.isParticipator(userName));
	});
	return mt;
}

std::list<Meeting> AgendaService::meetingQuery(const std::string &userName,
                                  const std::string &startDate,
                                  const std::string &endDate) const{
	list<Meeting>  mt = m_storage->queryMeeting([userName,startDate,endDate](const Meeting & meeting) -> bool{
		return (((meeting.getStartDate() >= Date::dateToString(startDate) && meeting.getStartDate() <= Date::dateToString(endDate)) 
			|| (meeting.getEndDate() >= Date::dateToString(startDate) && meeting.getEndDate() <= Date::dateToString(endDate))) && (userName == meeting.getSponsor() || meeting.isParticipator(userName)));
	});
	return mt;
}

std::list<Meeting> AgendaService::listAllMeetings(const std::string &userName) const{
	list<Meeting> mt = m_storage->queryMeeting([userName](const Meeting & meeting) -> bool{
		return userName == meeting.getSponsor() || meeting.isParticipator(userName);
	});
	return mt;
}

std::list<Meeting> AgendaService::listAllSponsorMeetings(const std::string &userName) const{
	list<Meeting> mt = m_storage->queryMeeting([userName](const Meeting & meeting) -> bool{	
		return userName == meeting.getSponsor();
	});
	return mt;
}

std::list<Meeting> AgendaService::listAllParticipateMeetings(
      const std::string &userName) const{
	list<Meeting> mt = m_storage->queryMeeting([userName](const Meeting & meeting) -> bool{
		return meeting.isParticipator(userName);
	});
	return mt;  
}

bool AgendaService::deleteMeeting(const std::string &userName, const std::string &title){
	int count = 0;
	count = m_storage->deleteMeeting([userName,title](const Meeting & meeting) -> bool{
		return userName == meeting.getSponsor() && title == meeting.getTitle();
	});
	if(count)return true;
	else return false;
}

bool AgendaService::deleteAllMeetings(const std::string &userName){	
	int count = 0;
	count = m_storage->deleteMeeting([userName](const Meeting & meeting) -> bool{
		return userName == meeting.getSponsor(); 
	});
	if(count) return true;
	else return false;
}

void AgendaService::startAgenda(void){
	m_storage = Storage::getInstance();
}

void AgendaService::quitAgenda(void){
	m_storage->sync();
}
