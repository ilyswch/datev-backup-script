@echo off
setlocal enabledelayedexpansion
goto startScript

:startScript
    pushd "%CD%"
    CD /D "%~dp0"
    mode con: cols=168 lines=10
    cls
    color 02
    echo 888888ba             dP                        888888ba             dP                              oo          dP                                                    
    echo 88    `8b            88                        88    `8b            88                                          88                                                    
    echo 88     88 .d8888b. d8888P .d8888b. dP   .dP    88     88 .d8888b. d8888P .d8888b. 88d888b. .d8888b. dP .d8888b. 88d888b. .d8888b. 88d888b. dP    dP 88d888b. .d8888b. 
    echo 88     88 88'  `88   88   88ooood8 88   d8'    88     88 88'  `88   88   88ooood8 88'  `88 Y8ooooo. 88 88'  `"" 88'  `88 88ooood8 88'  `88 88    88 88'  `88 88'  `88 
    echo 88    .8P 88.  .88   88   88.  ... 88 .88'     88    .8P 88.  .88   88   88.  ... 88    88       88 88 88.  ... 88    88 88.  ... 88       88.  .88 88    88 88.  .88 
    echo 8888888P  `88888P8   dP   `88888P' 8888P'      8888888P  `88888P8   dP   `88888P' dP    dP `88888P' dP `88888P' dP    dP `88888P' dP       `88888P' dP    dP `8888P88 
    echo                                                                                                                                                                   .88 
    echo                                                                                                                                                               d8888P  
    ping -n 4 127.0.0.1 >nu
    mode con: cols=120 lines=30
    cls
    color c
    echo Dieses Programm wird eine vollstaendige Sicherung aller relevanten DATEV-Dateien erstellen. 
    echo Vor dem Starten stellen Sie bitte sicher, dass alle DATEV-Programme geschlossen sind 
    echo und kein anderer Arbeitsplatz/Benutzer mehr in DATEV-Programmen arbeitet.
    echo. 
    echo Druecken Sie die Eingabetaste, um fortzufahren.
    pause >nul
    cls
    color 7
    echo Die Datensicherung laeuft, bitte warten...
    goto stopDB

:makeBackup
    set "datum=%date:/=-%_%time::=-%"
    set "windvsw1=C:\WINDVSW1\"
    set "datevpd=%DATEVDP%\DATEN\"
    set "folder=%USERPROFILE%\Desktop\DATEV-Backup-%date:/=_%\"
    set "folder2=%USERPROFILE%\Desktop\DATEV-Backup-%datum%"
    if not exist "!folder!" (
        mkdir "!folder!"
       xcopy /s /e /y "!windvsw1!" "!folder!\WINDVSW1\" > nul
       xcopy /s /e /y "!datevpd!" "!folder!\DATEVDP\DATEN\" > nul
    ) else (
       mkdir "!folder2!"
       xcopy /s /e /y "!windvsw1!" "!folder2!\WINDVSW1\" > nul
       xcopy /s /e /y "!datevpd!" "!folder2!\DATEVDP\DATEN\" > nul
    )
    goto startDB

:startDB 
    net start MSSQL$DATEV_DBENGINE
    ping -n 60 127.0.0.1 >nu
    goto sucess

:stopDB
    net stop MSSQL$DATEV_DBENGINE /Y
    ping -n 300 127.0.0.1 >nu
    goto makeBackup

:sucess
    mode con: cols=50 lines=30
    cls
    color 20  
    echo.                                                                                     
    echo                                     .'.         
    echo                                  .'""'           
    echo                                .`:I.             
    echo                              `:ll.               
    echo                             Ill,.                 
    echo                          `;ll;`                   
    echo                        .:lll,.                    
    echo                       `IllI`                      
    echo         .'^""`.      `lll;'                       
    echo          ',lllll,.  ,lll;.                        
    echo           .,llllI^:lll:.                         
    echo             .:lllllll:.                          
    echo               ,lllll;.                           
    echo                ,lll;.                            
    echo                 ^^`       
    echo.
    echo Die Datensicherung war erfolgreich!
    echo Sie koenne das Programm nun schliessen.
    pause >nul