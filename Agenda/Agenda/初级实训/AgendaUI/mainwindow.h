#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTextEdit>
#include <AgendaService.h>
namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

    void userRegister();
    void listAllUsers();
    void userLogIn();
    void deleteUser();
    void createMeeting();
    void addMeetingParticipator();
    void removeMeetingParticipator();
    void quitMeeting();

    void meetingQueryByTitle();
    void meetingQueryByTime();
    void listAllMeetings();
    void listAllSponsorMeetings();
    void listAllParticipateMeetings();
    void deleteMeeting();
    void deleteAllMeetings();


private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
