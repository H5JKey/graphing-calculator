from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, QObject, Slot
import function

class FunctionsModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._functions = [function.Function("", "")]
    
    def data(self, index, role):
        if not index.isValid():
            return None
        if role == Qt.DisplayRole:
            return self._functions[index.row()]
        return None
            

    def rowCount(self, index=None):
        return len(self._functions)
    
    def roleNames(self):
        return {
            Qt.DisplayRole: b"function"
        }
    
    @Slot(str) 
    def append(self, function = ""):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.functions.append(function)
        self.endInsertRows()

    @property
    def functions(self):
        return self._functions