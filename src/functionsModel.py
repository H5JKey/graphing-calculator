from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, QObject, Slot
from function import *

class FunctionsModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.functions = [Function("", "")]
    
    def data(self, index, role):
        if not index.isValid():
            return None
        if role == Qt.DisplayRole:
            return self.functions[index.row()]
        return None
            

    def rowCount(self, index=None):
        return len(self.functions)
    
    def roleNames(self):
        return {
            Qt.DisplayRole: b"function"
        }
    
    @Slot(str) 
    def append(self, function = ""):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.functions.append(function)
        self.endInsertRows()