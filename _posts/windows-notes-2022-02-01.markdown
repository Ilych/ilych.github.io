---
layout: post
title:  "Заметки про Windows"
date:   2022-02-01 18:00:00 +0300
categories: open info
---

Обои рабочего стола в Onedrive

  https://1drv.ms/u/s!Ai-lcrKZCi2olgcurjZTXNeeciOP?e=thQfos




Восстановление системного образа Windows

Get-ComputerInfo | select WindowsProductname,WindowsEditionID,WindowsVersion, OSDisplayVersion

Get-WindowsImage -ImagePath "E:\sources\install.wim"

ImageIndex       : 1
ImageName        : Windows Server 2016 SERVERSTANDARDCORE
ImageDescription : Windows Server 2016 SERVERSTANDARDCORE
ImageSize        : 9 481 916 907 bytes

ImageIndex       : 2
ImageName        : Windows Server 2016 SERVERSTANDARD
ImageDescription : Windows Server 2016 SERVERSTANDARD
ImageSize        : 15 560 241 110 bytes


dism /online /cleanup-image /restorehealth /source:WIM:E:\sources\install.wim:2 /limitaccess

sfc /scannow

dism /online /cleanup-image /analyzecomponentstore

Фактический размер хранилища компонентов : 17.06 GB

    Совместно с Windows : 6.76 GB
    Резервные копии и отключенные компоненты : 7.41 GB
    Кэш и временные данные : 2.88 GB

Число освобождаемых пакетов : 2
Рекомендуется очистка хранилища компонентов : Да

dism /online /cleanup-image /startcomponentcleanup

===================================

regedit
  CLASSES_ROOT/CLSID/{CLSID} - взять название Appname
               APPID/{APPID}
  Выставить полные разрешения для текущего пользователя

dcomcnfg
  Службы компонентов/.../Настройка DCOM/{Appname}
    Свойства - Безопасность - Разрешение на запуск и активацию
    
===================================
    
