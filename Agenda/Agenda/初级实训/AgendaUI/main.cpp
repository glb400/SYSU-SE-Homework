#include "mainwindow.h"
#include <QApplication>
#include <QLibrary>
#include <QDebug>
#include <QMessageBox>
#include <AgendaService.h>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}
