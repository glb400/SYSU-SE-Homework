#include "logwindow.h"
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
AgendaService agenda1;
logwindow::logwindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::logwindow)
{
    ui->setupUi(this);
    ui->lineEdit_2->setEchoMode(QLineEdit::Password);
    connect(ui->pushButton,&QPushButton::clicked,this,&logwindow::userRegister);
    connect(ui->pushButton_2,&QPushButton::clicked,this,&logwindow::userLogIn);
}

logwindow::~logwindow()
{
    delete ui;
}

void logwindow::userRegister(){
    QString str = ui->lineEdit->text();
    QList<QString> lis = str.split('|');
    vector<string> info;
    foreach (QString i, lis) {
        string Str = i.toStdString();
        info.push_back(Str);
    }
    if(info.size() == 4)
        if(agenda1.userRegister(info[0],info[1],info[2],info[3]))
            QMessageBox::information(NULL, "Succeed!", "Register Succeed!", QMessageBox::Yes, QMessageBox::Yes);
        else
            QMessageBox::critical(NULL, "Failed!", "Register Failed!", QMessageBox::Yes, QMessageBox::Yes);
}

void logwindow::userLogIn(){
    QString str = ui->lineEdit->text();
    QString str2 = ui->lineEdit_2->text();
    QList<QString> lis;
    lis.push_back(str);
    lis.push_back(str2);
    if(lis.size() == 2){
        vector<string> info;
        foreach(auto elem,lis)
            info.push_back(elem.toStdString());

        if(agenda1.userLogIn(info[0],info[1]))
            QMessageBox::information(NULL, "Succeed!", "LogIn Succeed!", QMessageBox::Yes, QMessageBox::Yes);
        else
            QMessageBox::critical(NULL, "Failed!", "LogIn Failed!", QMessageBox::Yes, QMessageBox::Yes);

        if(agenda1.userLogIn(info[0],info[1])){
            this->hide();
            window.show();
        }
    }
}
