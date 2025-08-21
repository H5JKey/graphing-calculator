from PySide6.QtCore import QObject, Property, Signal, Slot, QPointF
import sympy



class Function(QObject):
    def __init__(self, string="", color="#cc0000", show = True, parent=None):
        self._string = string
        super().__init__(parent)
        self._string = string
        self._color = color
        self._show = show
        self._pointsCount = 100
        self.string = string

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
            try:
                self._variable = sympy.symbols('x')
                self._expression = sympy.simplify(self._string)
                self._evaluatingFunction = sympy.lambdify(self._variable, self._expression)
            except:
                pass


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
        if self._string == "": return False
        return self._show
    

    @show.setter
    def show(self, value):
        if self._show != value:
            self._show = value
            self.showChanged.emit()


    def calculatePoints(self, xMin, xMax):
        points = []
        x = xMin
        dx = (xMax - xMin) / self._pointsCount
        while x<=xMax:
            points.append(QPointF(x, self._evaluatingFunction(x)))
            x+=dx
        return points