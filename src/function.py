from PySide6.QtCore import QObject, Slot
from PySide6.QtQml import QmlElement

QML_IMPORT_NAME = "Function"

QML_IMPORT_MAJOR_VERSION = 1


@QmlElement
class Function(QObject):
    def __init__(self, string, color = None):
        self.string = string
        self.color = color
    
    @Slot(str, result=str)
    def getColor(self, s):
        if s.lower() == "red":
            return "#ef9a9a"
        if s.lower() == "green":
            return "#a5d6a7"
        if s.lower() == "blue":
            return "#90caf9"
        return "white"


    @Slot(str, result=str)
    def getString(self, s):
        return s.lower() == "italic"


    @Slot(str, result=bool)
    def getBold(self, s):
        return s.lower() == "bold"


    @Slot(str, result=bool)

    def getUnderline(self, s):

        return s.lower() == "underline