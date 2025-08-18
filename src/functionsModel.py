from PySide6.QtCore import QAbstractListModel, Qt

class FunctionsModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.functions = ["f(x) = sin(x)"]
    
    def data(self, index, role):
        if not index.isValid():
            return None
        if role == Qt.DisplayRole:
            return self.functions[index.row()]
        return None
            

    def rowCount(self, index):
        return len(self.functions)
    
    def roleNames(self):
        return {
            Qt.DisplayRole: b"string"
        }
