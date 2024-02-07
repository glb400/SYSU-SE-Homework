/********************************************************************************
** Form generated from reading UI file 'logwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.8.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef LOGWINDOW_H
#define LOGWINDOW_H

#include "ui_logwindow.h"
#include "mainwindow.h"

class logwindow : public QMainWindow
{
    Q_OBJECT

public:
    logwindow(QWidget *parent = 0);
    ~logwindow();
    void userRegister();
    void userLogIn();

private:
    Ui_logwindow * ui;
    MainWindow window;

};

#endif // LOGWINDOW_H
