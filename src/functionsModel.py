from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, QObject, Slot
import function

class FunctionsModel(QAbstractListModel):
    StringRole = Qt.UserRole + 1
    ColorRole = Qt.UserRole + 2
    ShowRole = Qt.UserRole + 3

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._functions = [function.Function()]
    
    def data(self, index, role):
        if not index.isValid():
            return None
        if role == self.StringRole:
            return self._functions[index.row()].string
        elif role == self.ColorRole:
            return self._functions[index.row()].color
        elif role == self.ShowRole:
            return self._functions[index.row()].show
        return None
            

    def rowCount(self, index=None):
        return len(self._functions)
    
    def roleNames(self):
        roles = super().roleNames()
        roles[self.StringRole] = b"functionString"
        roles[self.ColorRole] = b"graphicColor"
        roles[self.ShowRole] = b"showGraphic"
        return roles
    
    @Slot(int)
    def insert(self, index):
        self.beginInsertRows(QModelIndex(), index, index)
        self._functions.insert(index, function.Function())
        self.endInsertRows()

    @Slot(int)
    def remove(self, index):
        self.beginRemoveRows(QModelIndex(), index, index)
        self._functions.pop(index)
        self.endRemoveRows()
        if not self._functions:
            self.insert(0)

    @Slot(int, str)
    def setString(self, index, value):
        index = self.createIndex(index,0)
        if not index.isValid():
            return False
            
        self._functions[index.row()].string = value
        if index.row() == len(self._functions)-1:
            self.insert(len(self._functions))

        self.dataChanged.emit(index, index)
        return True
    
    @Slot(int, str)
    def setColor(self, index, value):
        index = self.createIndex(index,0)
        if not index.isValid():
            return False
        
        self._functions[index.row()].color = value

        self.dataChanged.emit(index, index)
        return True
    

    @Slot(int, bool)
    def setShow(self, index, value):
        index = self.createIndex(index,0)
        if not index.isValid():
            return False
        
        self._functions[index.row()].show = value

        self.dataChanged.emit(index, index)
        return True