#ifndef ARTICULOMODEL_H
#define ARTICULOMODEL_H

#include <QAbstractListModel>
#include <QVector>

struct ArticuloItem
{
    QString nombre;
    QString precio;
    QVariant fotos;
};

class ArticuloModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit ArticuloModel(QObject *parent = nullptr);

    enum ArticuloRoles {
        NombreRole = Qt::UserRole + 1,
        PrecioRole,
        FotosRole
    };
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void addData(const QString &data);
private:
    QVector<ArticuloItem> m_items;
protected:
    QHash<int, QByteArray> roleNames() const;
};

#endif // ARTICULOMODEL_H
