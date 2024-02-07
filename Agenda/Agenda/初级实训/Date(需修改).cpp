#include "Date.hpp"
#include "User.hpp"
#include <initializer_list>
#include <string>
#include <sstream>
#include <list>
#include <cstring>
#include <fstream>
#include <memory>
#include <vector>
using namespace std;
 
int StringtoInt(std::string s){
  std::stringstream sstr;
  int answer;
  sstr << s;
  sstr >> answer;
  return answer;
}

std::string InttoString(int input){
  std::stringstream sstr;
  std::string ano_answer = "0";
  std::string s;
  sstr<<input;
  sstr>>s;
  if(input >= 10){
  	return s;
  }
  else
    ano_answer += s;
  return  ano_answer;
} 

Date::Date(){
  this->m_year = 0;
  this->m_month = 0;
  this->m_day = 0;
  this->m_hour = 0;
  this->m_minute = 0;
}

Date::Date(int t_year, int t_month, int t_day, int t_hour, int t_minute){
  this->m_year = t_year;
  this->m_month = t_month;
  this->m_day = t_day;
  this->m_hour = t_hour;
  this->m_minute = t_minute;

}

Date::Date(const std::string & dateString){
  Date tmp = stringToDate(dateString);
  this->m_year = tmp.m_year;
  this->m_month = tmp.m_month;
  this->m_day = tmp.m_day;
  this->m_hour = tmp.m_hour;
  this->m_minute = tmp.m_minute;
}

int Date::getYear(void) const{
  return this->m_year;
}

void Date::setYear(const int t_year){
  this->m_year = t_year; 
}

int Date::getMonth(void) const{
  return this->m_month;
}

void Date::setMonth(const int t_month){
  this->m_month = t_month;
}

int Date::getDay(void) const{
  return this->m_day;
}

void Date::setDay(const int t_day){
  this->m_day = t_day;
}

int Date::getHour(void) const{
  return this->m_hour;
}

void Date::setHour(const int t_hour){
  this->m_hour = t_hour;
}

int Date::getMinute(void) const{
  return this->m_minute;
}

void Date::setMinute(const int t_minute){
  this->m_minute = t_minute;
}

bool Date::isValid(const Date &t_date){
  if(t_date.m_year>9999||t_date.m_year<1000){
  	return false;
  }
  else if(t_date.m_month>12||t_date.m_month<1){
	return false;
  }
  else if(t_date.m_hour>23||t_date.m_hour<0){
  	return false;
  }
  else if(t_date.m_minute>59||t_date.m_minute<0){
    return false;
  }
  else{
  	if(t_date.m_month==1||t_date.m_month==3||t_date.m_month==5||t_date.m_month==7||t_date.m_month==8||t_date.m_month==10||t_date.m_month==12){
    	if(t_date.m_day<1||t_date.m_day>31) 
			return false;
  	}
  	else if(t_date.m_month==4||t_date.m_month==6||t_date.m_month==9||t_date.m_month==11){
    	if(t_date.m_day<1||t_date.m_day>30) 
			return false;
  	}
 	else if(t_date.m_month==2){
    	if((t_date.m_year%4==0&&(t_date.m_year%100!=0))||(t_date.m_year%400==0)){
      		if(t_date.m_day<1||t_date.m_day>29)
        		return false;
    	} 
    	else{
     		if(t_date.m_day<1||t_date.m_day>28)
        		return false;
    	}
  	}
  }
  return true;
}

bool formatCheck(std::string str){
  if(str[4]!='-'||str[7]!='-'||str[10]!='/'||str[13]!=':') 
  	return false;
  for(int i=0;i<16;++i){
  	if(i==4||i==7||i==10||i==13)
  		continue;
    if(str[i]<'0'||str[i]>'9') 
		return false;
  }
  return true;
}

Date Date::stringToDate(const std::string & t_dateString){
  if(t_dateString.size()!=16||!formatCheck(t_dateString)){ 
    Date ans = Date(0,0,0,0,0);
    return ans;
  }
  int year = StringtoInt(t_dateString.substr(0,4));
  int month = StringtoInt(t_dateString.substr(5,2));
  int day = StringtoInt(t_dateString.substr(8,2));
  int hour = StringtoInt(t_dateString.substr(11,2));
  int min = StringtoInt(t_dateString.substr(14,2));
  Date tmp = Date(year,month,day,hour,min);
  return tmp;
}

std::string Date::dateToString(const Date & t_date){
  std::string str;
  if(isValid(t_date)){
  	  str += InttoString(t_date.m_year);
  	  str += "-";
  	  str += InttoString(t_date.m_month);
  	  str += "-";
	  str += InttoString(t_date.m_day);	 
	  str += "/";
	  str += InttoString(t_date.m_hour);
	  str += ":";
	  str += InttoString(t_date.m_minute);
  }
  else{
  	str = "0000-00-00/00:00";
  }
  return str;
}

Date & Date::operator =(const Date &t_date){
  this->m_year = t_date.m_year;
  this->m_month = t_date.m_month;
  this->m_day = t_date.m_day;
  this->m_hour = t_date.m_hour;
  this->m_minute = t_date.m_minute;
}

bool Date::operator ==(const Date &t_date) const{
  if(this->m_year == t_date.m_year){
    if(this->m_month == t_date.m_month){
      if(this->m_day == t_date.m_day){
        if(this->m_hour == t_date.m_hour){
          if(this->m_minute == t_date.m_minute){
            return true;
          }
        }
      }
    }
  }
  return false;
}


bool Date::operator >(const Date &t_date) const{
  if(this->m_year > t_date.m_year) return true;
  if(this->m_year < t_date.m_year) return false;
  if(this->m_month > t_date.m_month) return true;
  if(this->m_month < t_date.m_month) return false;
  if(this->m_day > t_date.m_day) return true;
  if(this->m_day < t_date.m_day) return false;
  if(this->m_hour > t_date.m_hour) return true;
  if(this->m_hour < t_date.m_hour) return false;
  if(this->m_minute > t_date.m_minute) return true;
  if(this->m_minute < t_date.m_minute) return false;
  return false;
}
bool Date::operator <(const Date &t_date) const{
  if(this->m_year < t_date.m_year) return true;
  if(this->m_year > t_date.m_year) return false;
  if(this->m_month < t_date.m_month) return true;
  if(this->m_month > t_date.m_month) return false;
  if(this->m_day < t_date.m_day) return true;
  if(this->m_day > t_date.m_day) return false;
  if(this->m_hour < t_date.m_hour) return true;
  if(this->m_hour > t_date.m_hour) return false;
  if(this->m_minute < t_date.m_minute) return true;
  if(this->m_minute > t_date.m_minute) return false;
  return false;
}
bool Date::operator >=(const Date &t_date) const{
  if(this->m_year >= t_date.m_year) return true;
  if(this->m_year < t_date.m_year) return false;
  if(this->m_month >= t_date.m_month) return true;
  if(this->m_month < t_date.m_month) return false;
  if(this->m_day >= t_date.m_day) return true;
  if(this->m_day < t_date.m_day) return false;
  if(this->m_hour >= t_date.m_hour) return true;
  if(this->m_hour < t_date.m_hour) return false;
  if(this->m_minute >= t_date.m_minute) return true;
  if(this->m_minute < t_date.m_minute) return false;
}
bool Date::operator <=(const Date &t_date) const{
  if(this->m_year <= t_date.m_year) return true;
  if(this->m_year > t_date.m_year) return false;
  if(this->m_month <= t_date.m_month) return true;
  if(this->m_month > t_date.m_month) return false;
  if(this->m_day <=t_date.m_day) return true;
  if(this->m_day > t_date.m_day) return false;
  if(this->m_hour <= t_date.m_hour) return true;
  if(this->m_hour > t_date.m_hour) return false;
  if(this->m_minute <= t_date.m_minute) return true;
  if(this->m_minute > t_date.m_minute) return false;
}
