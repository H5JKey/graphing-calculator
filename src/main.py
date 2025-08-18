# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
import functionsModel
import function

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType

#    ---->       path/to/venv/bin/python src/main.py


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    qmlRegisterType(function.Function, "Function", 1, 0, "Function")
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "../view/Main.qml"

    functionsModel = functionsModel.FunctionsModel()
    engine.rootContext().setContextProperty("functionsModel", functionsModel)
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
