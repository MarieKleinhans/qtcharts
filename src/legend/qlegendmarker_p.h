/****************************************************************************
**
** Copyright (C) 2012 Digia Plc
** All rights reserved.
** For any questions to Digia, please use contact form at http://qt.digia.com
**
** This file is part of the Qt Commercial Charts Add-on.
**
** $QT_BEGIN_LICENSE$
** Licensees holding valid Qt Commercial licenses may use this file in
** accordance with the Qt Commercial License Agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.
**
** If you have questions regarding the use of this file, please use
** contact form at http://qt.digia.com
** $QT_END_LICENSE$
**
****************************************************************************/

//  W A R N I N G
//  -------------
//
// This file is not part of the QtCommercial Chart API.  It exists purely as an
// implementation detail.  This header file may change from version to
// version without notice, or even be removed.
//
// We mean it.

#ifndef QLEGENDMARKERPRIVATE_H
#define QLEGENDMARKERPRIVATE_H

#include "qchartglobal.h"
#include <QGraphicsObject>
#include <QBrush>
#include <QPen>
#include <QGraphicsSimpleTextItem>
#include <QGraphicsLayoutItem>
#include <QDebug>

QTCOMMERCIALCHART_BEGIN_NAMESPACE

// TODO: check these
class QAbstractSeries;
class QAreaSeries;
class QXYSeries;
class QBarSet;
class QAbstractBarSeries;
class QPieSlice;
class QLegend;
class QPieSeries;

class QLegendMarker;
class LegendMarkerItem;

class QLegendMarkerPrivate : public QObject
{
    Q_OBJECT
public:
//    explicit QLegendMarkerPrivate(QAbstractSeries *series, QLegendMarker *q);
    explicit QLegendMarkerPrivate(QLegendMarker *q);
    virtual ~QLegendMarkerPrivate();
/*
    void setPen(const QPen &pen);
    QPen pen() const;

    void setBrush(const QBrush &brush);
    QBrush brush() const;

    void setFont(const QFont &font);
    QFont font() const;

    void setLabel(const QString label);
    QString label() const;

    void setLabelBrush(const QBrush &brush);
    QBrush labelBrush() const;
*/
    // Helper for now.
    LegendMarkerItem* item() const { return m_item; }

    // Item gets the event, logic for event is here
    void handleMousePressEvent(QGraphicsSceneEvent *event);

public Q_SLOTS:
    virtual void updated() {};

protected:
    LegendMarkerItem *m_item;

private:
    QLegendMarker *q_ptr;
/*
    QLegend* m_legend;
*/

// New legend marker properties
    QString m_label;
    QBrush m_labelBrush;
    QFont m_font;
    QPen m_pen;
    QBrush m_brush;
    bool m_visible;

    friend class QLegendPrivate; // TODO: Is this needed?
    Q_DECLARE_PUBLIC(QLegendMarker)
};

QTCOMMERCIALCHART_END_NAMESPACE

#endif // QLEGENDMARKERPRIVATE_H