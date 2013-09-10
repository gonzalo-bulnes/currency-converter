Currency Converter
==================

**An [Ubuntu Touch tutorial][1] by David Planella (code by the SDK Team).**

  [1]: http://developer.ubuntu.com/resources/tutorials/getting-started/currency-converter-phone-app

Overview
--------

**From the tutorial documentation**: _Currency Converter_ performs currency conversion between two selected currencies. The rates are fetched using the European Central Bank’s API. Currencies can be changed by pressing the buttons and selecting the currency required from the list.

### Ubuntu SDK Installation

To install the Ubuntu SDK, please follow the instruction on the [developer documentation][sdk].

  [sdk]: http://developer.ubuntu.com/get-started#step-get-toolkit

### Application Preview

Previewing the application is easy using _QML Scene_:

```bash
cd currency-converter
qmlscene currency-converter.qml # QMLScene is part of the Ubuntu SDK

```
