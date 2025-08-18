from PySide6.QtCore import QObject, Property, Signal



class Function(QObject):
    def __init__(self, string="", color="white", parent=None):
        super().__init__(parent)
        self._string = string
        self._color = color

    def getString(self):
        return self._string

    def setString(self, value):
        if self._string != value:
            self._string = value
            self.stringChanged.emit()

    stringChanged = Signal()
    string = Property(str, getString, setString, notify=stringChanged)

    def getColor(self):
        color_map = {
            "red": "#ef9a9a",
            "green": "#a5d6a7",
            "blue": "#90caf9",
            "white": "white"
        }
        return color_map.get(self._color.lower(), "white")

    def setColor(self, value):
        if self._color != value:
            self._color = value
            self.colorChanged.emit()

    colorChanged = Signal()
    color = Property(str, getColor, setColor, notify=colorChanged)