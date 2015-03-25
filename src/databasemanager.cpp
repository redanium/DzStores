#include "databasemanager.h"



#include<QSqlDatabase>
#include<QDebug>
#include <QtCore/QDir>
#include <QtCore/QString>
#include <QtCore/QStandardPaths>
#include <QSqlError>
#include <QSqlQuery>
#include<QSqlDatabase>
#include<QDebug>
#ifndef Q_OS_ANDROID
#include<QCoreApplication>
#endif

DatabaseManager* DatabaseManager::m_instance = 0;

DatabaseManager* DatabaseManager::instance()
{
    if (!m_instance)
        m_instance = new DatabaseManager;
    return m_instance;
}

void DatabaseManager::destroy()
{
    if (m_instance) {
        delete m_instance;
        m_instance = 0;
    }
}

DatabaseManager::DatabaseManager()
{
#ifdef Q_OS_ANDROID

    // add version checking
    if(QFileInfo(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/" + "mydatabase.sqlite").exists())

        //in our case we set the existing sqlite3 database file path
    {
        m_database.setDatabaseName(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/" + "mydatabase.sqlite");

        qDebug() << "Database file exits :" << QFileInfo(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/" + "mydatabase.sqlite").exists();


        qDebug() <<"Database Last Error :" << m_database.lastError().text() ;
        //        m_MyModel= new MyModel(m_database);
        //        p_pModel= new PresenceModel(m_database);
        //        f_Model = new fournituresModel(m_database);



        m_database.open();

    }

    else    {
        QFile::copy(QString(":/files/data/mydatabase.sqlite"),QString(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/" + "mydatabase.sqlite"));
        m_database.setDatabaseName(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/" + "mydatabase.sqlite");
        qDebug() <<"Database Last Error copy :" <<m_database.lastError().text() ;
        //        m_MyModel= new MyModel(m_database);
        //        p_pModel= new PresenceModel(m_database);
        //        f_Model = new fournituresModel(m_database);

        m_database.open();

    }


#else
    if(QFileInfo(QCoreApplication::applicationDirPath().append("/mydatabase.sqlite")).exists())

        //in our case we set the existing sqlite3 database file path

    {
        m_database.setDatabaseName(QCoreApplication::applicationDirPath().append("/mydatabase.sqlite"));

        qDebug() << "Database file exits :" << QFileInfo(QCoreApplication::applicationDirPath().append("/mydatabase.sqlite")).exists();

        qDebug() << "Database found." ;
        m_database.open();
        //        m_MyModel= new MyModel(m_database);
        //        p_pModel= new PresenceModel(m_database);
        //        f_Model = new fournituresModel(m_database);

        qDebug() << "Database table : "<<    m_database.tables();


    }

    else    {
        qDebug() <<"Database Last Error :" <<m_database.lastError().text() ;
    }
#endif // Q_OS_ANDROID


}

DatabaseManager::~DatabaseManager()
{

    //    delete m_MyModel;
    m_database.close();
}

bool DatabaseManager::initialize()
{
    if(m_database.isOpen()){
        qDebug()<< m_database.tables();
        qDebug()<<"Initialization ____ database is opened :"<< (m_database.isOpen());




        return true;
    }
    else {qDebug()<< "Database Error "<<m_database.lastError().text();
        return false;}
}

