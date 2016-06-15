#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QNetworkInterface>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QList<QHostAddress> list = QNetworkInterface::allAddresses();
    QStringList datalist;

    for(int nIter = 0; nIter < list.count(); nIter++) {
        qDebug() << list[ nIter ].toString();
        datalist.append(list[ nIter ].toString());
    }

    QList<QNetworkInterface> list1 = QNetworkInterface::allInterfaces();
    QStringList datalist1;

    for(int nIter = 0; nIter < list1.count(); nIter++) {
        qDebug() << list1[ nIter ].name();
        datalist1.append(list1[ nIter ].name());
    }

    QString interface = datalist1.join(", ");

    QQuickView view;
    QQmlContext *ctxt = view.rootContext();
    ctxt->setContextProperty("myModel", QVariant::fromValue(datalist));
    ctxt->setContextProperty("interfaceString", QVariant::fromValue(interface));
    view.setSource(QUrl(QStringLiteral("qrc:///Main.qml")));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();

    return app.exec();
}

