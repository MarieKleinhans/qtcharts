!include( ../test.pri ) {
 error( "Couldn't find the test.pri file!" )
}

TEMPLATE = subdirs
SUBDIRS += qchartview qchart qlineseries qbarset qbarseries qstackedbarseries qpercentbarseries qpieslice qpieseries

test_private:{
    SUBDIRS += chartdataset domain
} 
