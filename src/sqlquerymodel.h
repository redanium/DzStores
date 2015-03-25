#ifndef SQLQUERYMODEL_H
#define SQLQUERYMODEL_H


#include <QSqlQueryModel>

class SqlQueryModel : public QSqlQueryModel
{
    typedef QHash<int, QByteArray> myhash;
    Q_OBJECT

    void generateRoleNames();
    Q_PROPERTY(myhash roles READ roles NOTIFY rolesChanged)

public:
    explicit SqlQueryModel(QObject *parent = 0);
  QHash<int, QByteArray> roles() const;
   QHash<int, QByteArray> roleNames() const;
    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    void setQuery(const QSqlQuery &query);
    QVariant data(const QModelIndex &index, int role) const;

signals:
  void rolesChanged();
public slots:
//    void createAccount();
//    void login();
//    void createStore();
//    void addProduct();
private:
    QHash<int, QByteArray> m_roles;

};


#endif // SQLQUERYMODEL_H
