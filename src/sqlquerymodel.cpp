#include "sqlquerymodel.h"
#include <QSqlRecord>
#include <QSqlField>
#include <QDebug>

SqlQueryModel::SqlQueryModel(QObject *parent) :
    QSqlQueryModel(parent)
{

}

void SqlQueryModel::setQuery(const QString &query, const QSqlDatabase &db)
{
    QSqlQueryModel::setQuery(query,db);
    generateRoleNames();
}

void SqlQueryModel::setQuery(const QSqlQuery & query)
{
    QSqlQueryModel::setQuery(query);
    generateRoleNames();
}

void SqlQueryModel::generateRoleNames()
{

    for( int i = 0; i < record().count(); i++) {
        m_roles[Qt::UserRole + i + 1] = record().fieldName(i).toUtf8();
    }
 roleNames();

}
QHash<int, QByteArray> SqlQueryModel::roleNames() const
{
    return m_roles;
}
QHash<int, QByteArray> SqlQueryModel::roles() const
{
    return roleNames();
}
QVariant SqlQueryModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}
