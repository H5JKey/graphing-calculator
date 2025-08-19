from PySide6.QtCore import QObject, Property, Signal



class Function(QObject):
    def __init__(self, string="", color="#cc0000", show = True, parent=None):
        super().__init__(parent)
        self._string = string
        self._color = color
        self._show = show

    stringChanged = Signal()
    colorChanged = Signal()
    showChanged = Signal()

    @Property(str, notify = stringChanged)
    def string(self):
        return self._string


    @string.setter
    def string(self, value):
        if self._string != value:
            self._string = value
            self.stringChanged.emit()
    

    @Property(str, notify = colorChanged)
    def color(self):
        return self._color.lower()


    @color.setter
    def color(self, value):
        if self._color != value:
            self._color = value
            self.colorChanged.emit()

    @Property(str, notify = showChanged)
    def show(self):
        return self._show
    

    @show.setter
    def show(self, value):
        if self._show != value:
            self._show = value
            self.showChanged.emit()