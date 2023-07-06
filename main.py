# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

#from PySide6 import *
from PySide6.QtCore import Signal, Slot, QObject
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

#import numpy as np

class Speaker(QObject):

    text_print_sig = Signal(str)

#    def __init__(self):



    # noinspection PyCallingNonCallable
    @Slot(str)
    def say(self, s):
        print(s)
        send_str = "pysig"
        self.text_print_sig.emit(send_str)



# slot define:
def text_print_slot(s):
    print(s)




if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)

    pyspeaker = Speaker()
    engine.rootContext().setContextProperty('speaker', pyspeaker)

    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)

    # 获取 root 对象.
    root = engine.rootObjects()[0]  # type: QObject
    # 找到目标对象. 由于我们的目标对象是 Window, 也就是 root 对象. 所以直接用.
    target_view = root
    # 绑定信号.
    target_view.test_pass_sig.connect(text_print_slot)  # 前一个 say 是 qml 的信号, 后一个是 Python 的
    # say() 方法.

    sys.exit(app.exec())
