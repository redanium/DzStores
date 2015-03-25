#ifndef DatabaseManager_h
#define DatabaseManager_h

#include <QtCore/QScopedPointer>
#include <QtSql/QSqlDatabase>


//class MyModel;
//class PresenceModel;
//class fournituresModel;

class DatabaseManager {
public:
    static DatabaseManager* instance();
    static void destroy();
    bool initialize();


//    MyModel* MyDataBaseModel() const { return m_MyModel; }
// PresenceModel* pDataBaseModel() const { return p_pModel; }
// fournituresModel* fDatabaseModel() const {return f_Model;}
protected:


private:
    Q_DISABLE_COPY(DatabaseManager)

    DatabaseManager();
    ~DatabaseManager();

    static DatabaseManager* m_instance;
    QSqlDatabase m_database;
//    MyModel* m_MyModel;
//    PresenceModel* p_pModel;
//    fournituresModel* f_Model;
};

#endif
