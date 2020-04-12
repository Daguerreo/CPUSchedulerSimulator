import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: root

    property int pid
    property int arrivalTime
    property int duration
    property int priority

    property bool removable: false

    property bool selected : false

    property alias pColor: colorRec.color

    signal colorClicked
    signal leftClicked
    signal deleteClicked

    height: selected ? 40 : 20

    color: "transparent"
    border.color:  "transparent"

    MouseArea{
        anchors.fill: parent
        onClicked: {
            leftClicked()
        }
    }


    Rectangle{
        id: deleteButton

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.border.width +1

        width: removable ? 15 : 0
        height: width

        visible: removable

        color: "transparent"

        Rectangle{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            height: 4
            color: "black"
        }

        MouseArea{
            anchors.fill: parent
            onClicked:
            {
                deleteClicked()
            }
        }
    }

    Rectangle{
        id: colorRec
        width: 5
        height: selected ? 30 : 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: deleteButton.right
        anchors.leftMargin: 3
        color: Qt.rgba(Math.random(), Math.random(), Math.random(),1);
        MouseArea{
            anchors.fill: parent
            onClicked: {
                leftClicked()
                colorClicked()
            }
        }
    }
    Column{
        anchors.left: colorRec.right
        anchors.leftMargin: 5
        spacing: 2
        Row{
            spacing: 10

            Label {
                text: qsTr("P" + pid)
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }
            Label {
                text: qsTr("Arrived: " + arrivalTime + "ms")
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row{
            spacing: 10
            opacity: selected
            Label {
                text: qsTr("Duration: " + duration + "ms")
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: qsTr("Pr: " + priority)
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }
            Behavior on opacity{ NumberAnimation{duration: selected ? 75 : 450; easing.type: Easing.InOutCubic}}
        }
    }

    DeepLine{
        anchors.bottom: parent.bottom
        width: parent.width
    }
    Behavior on height{ NumberAnimation {duration: 150; easing.type: Easing.InOutCubic} }

}
