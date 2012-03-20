#include "separator_p.h"
#include <QDebug>
#include <QPainter>

QTCOMMERCIALCHART_BEGIN_NAMESPACE

Separator::Separator(QGraphicsItem *parent)
    : QGraphicsItem(parent)
{
}

void Separator::setPos(qreal x, qreal y)
{
    mXpos = x;
    mYpos = y;
}

void Separator::setColor(QColor color)
{
    mColor = color;
}

void Separator::setSize(const QSizeF &size)
{
    mWidth = size.width();
    mHeight = size.height();
}

void Separator::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    Q_UNUSED(option)
    Q_UNUSED(widget)

    if (isVisible()) {
        QPen pen(mColor);
        painter->setPen(pen);
        painter->drawLine(mXpos,mYpos,mXpos,mHeight);
    }
}

QRectF Separator::boundingRect() const
{
    QRectF r(mXpos,mYpos,mWidth,mHeight);
    return r;
}


QTCOMMERCIALCHART_END_NAMESPACE
