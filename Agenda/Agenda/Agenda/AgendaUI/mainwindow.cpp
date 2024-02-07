#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <AgendaService.h>
#include <QApplication>
#include <QLibrary>
#include <QDebug>
#include <QMessageBox>
#include <QAction>
#include <QMenuBar>
#include <QStatusBar>
#include <QToolBar>
#include <QTextEdit>
#include <QLineEdit>
#include <QPushButton>
#include <QList>

#include <list>
#include <string>
#include <cstring>
#include <vector>
#include <iostream>
using namespace std;

AgendaService agenda;

QPushButton * pushButton1;
QPushButton * pushButton2;
QPushButton * pushButton3;
QPushButton * pushButton4;
QPushButton * pushButton5;
QPushButton * pushButton6;
QPushButton * pushButton7;
QPushButton * pushButton8;
QPushButton * pushButton9;
QPushButton * pushButton10;
QPushButton * pushButton11;
QPushButton * pushButton12;
QPushButton * pushButton13;
QPushButton * pushButton14;
QPushButton * pushButton15;
QTextEdit * textEdit1;
QTextEdit * textEdit2;
QTextEdit * textEdit3;
QTextEdit * textEdit4;
QTextEdit * textEdit5;
QTextEdit * textEdit6;
QTextEdit * textEdit7;
QTextEdit * textEdit8;
QTextEdit * textEdit9;
QTextEdit * textEdit10;
QTextEdit * textEdit11;
QTextEdit * textEdit12;
QTextEdit * textEdit13;
QTextEdit * textEdit14;
QTextEdit * textEdit15;
QTextEdit * textEdit16;
QTextEdit * textEdit17;
QTextEdit * textEdit18;
QTextEdit * textEdit19;
QTextEdit * textEdit20;
QTextEdit * textEdit21;
QTextEdit * textEdit22;
QTextEdit * textEdit23;
QTextEdit * textEdit24;
QTextEdit * textEdit25;

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    setWindowTitle(tr("Qt AgendaUI"));

    QAction * uR = new QAction(QIcon(":/images/doc-open"), tr("&Open..."), this);
    uR->setStatusTip(tr("User Register"));

    //userRegister
    pushButton1 = new QPushButton(tr("userRegister"),this);
    pushButton1->setGeometry(QRect(50,50,150,30));
    textEdit1 = new QTextEdit(tr("userInformation::For example:Burns|5543358|459559296@qq.com|17711272466"),this);
    textEdit1->setGeometry(QRect(50,100,400,150));
    connect(pushButton1,&QPushButton::clicked,this,&MainWindow::userRegister);

    //listAllUsers
    pushButton2 = new QPushButton(tr("listAllUsers"),this);
    pushButton2->setGeometry(QRect(50,270,150,30));
    textEdit2 = new QTextEdit(tr("listAllUsers"),this);
    textEdit2->setGeometry(QRect(50,330,400,150));
    connect(pushButton2,&QPushButton::clicked,this,&MainWindow::listAllUsers);

    //userLogIn
    pushButton3 = new QPushButton(tr("userLogIn"),this);
    pushButton3->setGeometry(QRect(50,500,150,30));
    textEdit4 = new QTextEdit(tr("userLogIn Input:"),this);
    textEdit4->setGeometry(QRect(250,500,200,30));
    textEdit3 = new QTextEdit(tr(""),this);
    textEdit3->setGeometry(QRect(50,550,400,150));
    connect(pushButton3,&QPushButton::clicked,this,&MainWindow::userLogIn);

    //deleteUser
    pushButton4 = new QPushButton(tr("deleteUser"),this);
    pushButton4->setGeometry(QRect(50,720,150,30));
    textEdit6 = new QTextEdit(tr("deleteUser Input:"),this);
    textEdit6->setGeometry(QRect(250,720,200,30));
    textEdit5 = new QTextEdit(tr(""),this);
    textEdit5->setGeometry(QRect(50,770,400,150));
    connect(pushButton4,&QPushButton::clicked,this,&MainWindow::deleteUser);

    //createMeeting
    pushButton5 = new QPushButton(tr("createMeeting"),this);
    pushButton5->setGeometry(QRect(500,50,150,30));
    textEdit7 = new QTextEdit(tr("MeetingInformation::For example:Burns|Burns'Meeting1|2018-10-31/17:15|2018-10-31/17:45|Kevin&BossGuo(store in vector)"),this);
    textEdit7->setGeometry(QRect(500,100,400,150));
    connect(pushButton5,&QPushButton::clicked,this,&MainWindow::createMeeting);

    //addMeetingParticipator
    pushButton6 = new QPushButton(tr("addMeetingParticipator"),this);
    pushButton6->setGeometry(QRect(500,270,200,30));
    textEdit8 = new QTextEdit(tr("addMeetingParticipator:sponsor|title|participatorName"),this);
    textEdit8->setGeometry(QRect(500,330,400,150));
    connect(pushButton6,&QPushButton::clicked,this,&MainWindow::addMeetingParticipator);

    //removeMeetingParticipator
    pushButton7 = new QPushButton(tr("removeMeetingParticipator"),this);
    pushButton7->setGeometry(QRect(500,500,200,30));
    textEdit9 = new QTextEdit(tr("removeMeetingParticipator:sponsor|title|participatorName"),this);
    textEdit9->setGeometry(QRect(500,550,400,150));
    connect(pushButton7,&QPushButton::clicked,this,&MainWindow::removeMeetingParticipator);

    //quitMeeting
    pushButton8 = new QPushButton(tr("quitMeeting"),this);
    pushButton8->setGeometry(QRect(500,720,150,30));
    textEdit11 = new QTextEdit(tr("quitMeeting Input:"),this);
    textEdit11->setGeometry(QRect(750,720,200,30));
    textEdit10 = new QTextEdit(tr(""),this);
    textEdit10->setGeometry(QRect(500,770,400,150));
    connect(pushButton8,&QPushButton::clicked,this,&MainWindow::quitMeeting);

    //meetingQueryByTitle
    pushButton9 = new QPushButton(tr("MeetingQueryByTitle"),this);
    pushButton9->setGeometry(QRect(1000,50,200,30));
    textEdit12 = new QTextEdit(tr("For example:sponsor's Name or Participator's Name|Title"),this);
    textEdit12->setGeometry(QRect(1000,100,400,150));
    connect(pushButton9,&QPushButton::clicked,this,&MainWindow::meetingQueryByTitle);

    //meetingQueryByTime
    pushButton10 = new QPushButton(tr("MeetingQueryByTime"),this);
    pushButton10->setGeometry(QRect(1000,270,200,30));
    textEdit13 = new QTextEdit(tr("For example:sponsor's Name or Participator's Name|StartTime|EndTime"),this);
    textEdit13->setGeometry(QRect(1000,330,400,150));
    connect(pushButton10,&QPushButton::clicked,this,&MainWindow::meetingQueryByTime);

    //listAllMeetings
    pushButton11 = new QPushButton(tr("listAllMeetings"),this);
    pushButton11->setGeometry(QRect(1000,500,200,30));
    textEdit14 = new QTextEdit(tr("For example:sponsor's Name or Participator's Name"),this);
    textEdit14->setGeometry(QRect(1000,550,400,150));
    connect(pushButton11,&QPushButton::clicked,this,&MainWindow::listAllMeetings);

    //listAllSponsorMeetings
    pushButton12 = new QPushButton(tr("listAllSponsorMeetings"),this);
    pushButton12->setGeometry(QRect(1000,720,200,30));
    textEdit15 = new QTextEdit(tr("For example:sponsor's Name"),this);
    textEdit15->setGeometry(QRect(1000,770,400,150));
    connect(pushButton12,&QPushButton::clicked,this,&MainWindow::listAllSponsorMeetings);

    //listAllParticipateMeetings
    pushButton13 = new QPushButton(tr("listAllParticipateMeetings"),this);
    pushButton13->setGeometry(QRect(1000,720,200,30));
    textEdit16 = new QTextEdit(tr("For example:participator's Name"),this);
    textEdit16->setGeometry(QRect(1000,770,400,150));
    connect(pushButton13,&QPushButton::clicked,this,&MainWindow::listAllParticipateMeetings);

    //deleteMeeting
    pushButton14 = new QPushButton(tr("deleteMeeting"),this);
    pushButton14->setGeometry(QRect(1500,50,200,30));
    textEdit17 = new QTextEdit(tr("For example:sponsor's Name|Title"),this);
    textEdit17->setGeometry(QRect(1500,210,400,150));
    textEdit18 = new QTextEdit(tr("deleteMeeting Input:"),this);
    textEdit18->setGeometry(QRect(1500,130,200,30));
    connect(pushButton14,&QPushButton::clicked,this,&MainWindow::deleteMeeting);

    //deleteAllMeetings
    pushButton15 = new QPushButton(tr("deleteAllMeeting"),this);
    pushButton15->setGeometry(QRect(1500,570,200,30));
    textEdit19 = new QTextEdit(tr("For example:sponsor's Name"),this);
    textEdit19->setGeometry(QRect(1500,730,400,150));
    textEdit20 = new QTextEdit(tr("deleteAllMeeting Input:"),this);
    textEdit20->setGeometry(QRect(1500,650,200,30));
    connect(pushButton15,&QPushButton::clicked,this,&MainWindow::deleteAllMeetings);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::userRegister(){
    QString str = textEdit1->toPlainText();
    QList<QString> lis = str.split('|');
    vector<string> info;
    foreach (QString i, lis) {
        string Str = i.toStdString();
        info.push_back(Str);
    }
    if(info.size() == 4)
    agenda.userRegister(info[0],info[1],info[2],info[3]);
}


void MainWindow::listAllUsers(){
    list<User> us = agenda.listAllUsers();
    QString s;
    for(auto us1: us){
        s += QString::fromStdString(us1.getName());
        s += ' ';
        s += QString::fromStdString(us1.getPassword());
        s += ' ';
        s += QString::fromStdString(us1.getEmail());
        s += ' ';
        s += QString::fromStdString(us1.getPhone());
        s += '\n';
    }
    textEdit2->setPlainText(s);
}

void MainWindow::userLogIn(){
    QString str = textEdit4->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 2){
        textEdit3->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    if(agenda.userLogIn(info[0],info[1])){
        QString result2 = "Succeed!";
        textEdit3->setPlainText(result2);
        return;
    }
    textEdit3->setPlainText(result);
}

void MainWindow::deleteUser(){
    QString str = textEdit6->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 2){
        textEdit5->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    if(agenda.deleteUser(info[0],info[1])){
        QString result2 = "Succeed!";
        textEdit5->setPlainText(result2);
        return;
    }
    textEdit5->setPlainText(result);
}

void MainWindow::createMeeting(){
    QString str = textEdit7->toPlainText();
    QList<QString> lis = str.split('|');
    vector<string> info;
    foreach (QString i, lis) {
        string Str = i.toStdString();
        info.push_back(Str);
    }
    if(info.size() != 5)
        return;
    QList<QString> participators =  QString::fromStdString(info[4]).split('&');
    vector<string> participator;
    foreach (QString i, participators) {
        string Str = i.toStdString();
        participator.push_back(Str);
    }
    agenda.createMeeting(info[0],info[1],info[2],info[3],participator);
}

void MainWindow::addMeetingParticipator(){
    QString str = textEdit8->toPlainText();
    QList<QString> lis = str.split('|');
    vector<string> info;
    foreach (QString i, lis) {
        string Str = i.toStdString();
        info.push_back(Str);
    }
    if(info.size() != 3)
        return;
    agenda.addMeetingParticipator(info[0],info[1],info[2]);
}

void MainWindow::removeMeetingParticipator(){
    QString str = textEdit9->toPlainText();
    QList<QString> lis = str.split('|');
    vector<string> info;
    foreach (QString i, lis) {
        string Str = i.toStdString();
        info.push_back(Str);
    }
    if(info.size() != 3)
        return;
    agenda.removeMeetingParticipator(info[0],info[1],info[2]);
}

void MainWindow::quitMeeting(){
    QString str = textEdit11->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 2){
        textEdit10->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    if(agenda.quitMeeting(info[0],info[1])){
        QString result2 = "Succeed!";
        textEdit10->setPlainText(result2);
        return;
    }
    textEdit10->setPlainText(result);
}

void MainWindow::meetingQueryByTitle(){
    QString str = textEdit12->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 2){
        textEdit12->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    list<Meeting> mt = agenda.meetingQuery(info[0],info[1]);
    if(!mt.empty()){
        QString answer;
        foreach (auto i, mt) {
            answer += QString::fromStdString(i.getSponsor());
            answer += ' ';
            answer += QString::fromStdString(i.getTitle());
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getStartDate()));
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getEndDate()));
            answer += ' ';
            vector<string> participators = i.getParticipator();
            for(auto j:participators){
                answer += QString::fromStdString(j);
                if(j!=participators[participators.size()-1])
                answer += "&";
            }
            answer += '\n';
        }
        textEdit12->setPlainText(answer);
        return;
    }
    textEdit12->setPlainText(result);
}

void MainWindow::meetingQueryByTime(){
    QString str = textEdit13->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 3){
        textEdit13->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    list<Meeting> mt = agenda.meetingQuery(info[0],info[1],info[2]);
    if(!mt.empty()){
        QString answer;
        foreach (auto i, mt) {
            answer += QString::fromStdString(i.getSponsor());
            answer += ' ';
            answer += QString::fromStdString(i.getTitle());
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getStartDate()));
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getEndDate()));
            answer += ' ';
            vector<string> participators = i.getParticipator();
            for(auto j:participators){
                answer += QString::fromStdString(j);
                if(j!=participators[participators.size()-1])
                answer += "&";
            }
            answer += '\n';
        }
        textEdit13->setPlainText(answer);
        return;
    }
    textEdit13->setPlainText(result);
}

void MainWindow::listAllMeetings(){
    QString str = textEdit14->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 1){
        textEdit14->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    list<Meeting> mt = agenda.listAllMeetings(info[0]);
    if(!mt.empty()){
        QString answer;
        foreach (auto i, mt) {
            answer += QString::fromStdString(i.getSponsor());
            answer += ' ';
            answer += QString::fromStdString(i.getTitle());
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getStartDate()));
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getEndDate()));
            answer += ' ';
            vector<string> participators = i.getParticipator();
            for(auto j:participators){
                answer += QString::fromStdString(j);
                if(j!=participators[participators.size()-1])
                answer += "&";
            }
            answer += '\n';
        }
        textEdit14->setPlainText(answer);
        return;
    }
    textEdit14->setPlainText(result);
}

void MainWindow::listAllSponsorMeetings(){
    QString str = textEdit15->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 1){
        textEdit15->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    list<Meeting> mt = agenda.listAllSponsorMeetings(info[0]);
    if(!mt.empty()){
        QString answer;
        foreach (auto i, mt) {
            answer += QString::fromStdString(i.getSponsor());
            answer += ' ';
            answer += QString::fromStdString(i.getTitle());
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getStartDate()));
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getEndDate()));
            answer += ' ';
            vector<string> participators = i.getParticipator();
            for(auto j:participators){
                answer += QString::fromStdString(j);
                if(j!=participators[participators.size()-1])
                answer += "&";
            }
            answer += '\n';
        }
        textEdit15->setPlainText(answer);
        return;
    }
    textEdit15->setPlainText(result);
}

void MainWindow::listAllParticipateMeetings(){
    QString str = textEdit16->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 1){
        textEdit16->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    list<Meeting> mt = agenda.listAllParticipateMeetings(info[0]);
    if(!mt.empty()){
        QString answer;
        foreach (auto i, mt) {
            answer += QString::fromStdString(i.getSponsor());
            answer += ' ';
            answer += QString::fromStdString(i.getTitle());
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getStartDate()));
            answer += ' ';
            answer += QString::fromStdString(Date::dateToString(i.getEndDate()));
            answer += ' ';
            vector<string> participators = i.getParticipator();
            for(auto j:participators){
                answer += QString::fromStdString(j);
                if(j!=participators[participators.size()-1])
                answer += "&";
            }
            answer += '\n';
        }
        textEdit16->setPlainText(answer);
        return;
    }
    textEdit16->setPlainText(result);
}

void MainWindow::deleteMeeting(){
    QString str = textEdit18->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 2){
        textEdit17->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    if(agenda.deleteMeeting(info[0],info[1])){
        QString result2 = "Succeed!";
        textEdit17->setPlainText(result2);
        return;
    }
    textEdit17->setPlainText(result);
}

void MainWindow::deleteAllMeetings(){
    QString str = textEdit20->toPlainText();
    QList<QString> lis = str.split('|');
    QString result = "Failed!";
    if(lis.size() != 1){
        textEdit19->setPlainText(result);
        return;
    }
    vector<string> info;
    foreach(auto elem,lis){
        info.push_back(elem.toStdString());
    }
    if(agenda.deleteAllMeetings(info[0])){
        QString result2 = "Succeed!";
        textEdit19->setPlainText(result2);
        return;
    }
    textEdit19->setPlainText(result);
}
