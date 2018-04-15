#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include "articulomodel.h"

ArticuloModel::ArticuloModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

int ArticuloModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid() || m_items.empty())
        return 0;
    return m_items.count();
}

QVariant ArticuloModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > m_items.count())
        return QVariant();
    ArticuloItem articulo = m_items.at(index.row());
    switch (role) {
    case NombreRole:
        return QVariant(articulo.nombre);
        break;
    case PrecioRole:
        return QVariant(articulo.precio);
        break;
    case FotosRole:
        return QVariant(articulo.fotos);
    }
    return QVariant();
}

void ArticuloModel::addData(const QString &data)
{
    QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());
    QJsonArray array = jsonResponse.array();
    foreach (const QJsonValue &value, array) {
        QJsonObject jsonObj = value.toObject();
        ArticuloItem item;
        item.nombre = jsonObj["nombre"].toString();
        item.precio = jsonObj["precio"].toString();
        item.fotos = jsonObj["foto"].toVariant();
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_items.append(item);
        endInsertRows();
    }
}

QHash<int, QByteArray> ArticuloModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[NombreRole] = "nombre";
    names[PrecioRole] = "precio";
    names[FotosRole] = "fotos";
    return names;
}
