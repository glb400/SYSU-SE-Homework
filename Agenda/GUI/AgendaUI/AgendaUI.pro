#-------------------------------------------------
#
# Project created by QtCreator 2018-10-31T09:19:08
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = AgendaUI
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += main.cpp\
        mainwindow.cpp \
    Date.cpp \
    Meeting.cpp \
    User.cpp \
    Storage.cpp \
    logwindow.cpp

HEADERS  += mainwindow.h \
    AgendaService.h \
    agendaservice_global.h \
    Date.h \
    Meeting.h \
    Path.h \
    Storage.h \
    User.h \
    logwindow.h \
    ui_logwindow.h

FORMS    += mainwindow.ui \
    logwindow.ui


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/./release/ -lagendaservice
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/./debug/ -lagendaservice
else:unix: LIBS += -L$$PWD/./ -lagendaservice

INCLUDEPATH += $$PWD/debug
DEPENDPATH += $$PWD/debug

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/./release/ -lagendaservice
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/./debug/ -lagendaservice
else:unix: LIBS += -L$$PWD/./ -lagendaservice

INCLUDEPATH += $$PWD/debug
DEPENDPATH += $$PWD/debug
