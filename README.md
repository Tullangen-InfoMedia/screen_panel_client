# Installation för Raspberry Pi
1. Välj Linux-mappen.
2. Döp om den .exe-fil som matchar din dators processor till ``panel.exe`` (32-bit är ARMv7, 64-bit är ARMv8 oftast).
3. Kör ``setup.sh`` via terminalen ``sudo bash setup.sh`` i mappen.
4. Sätt på autostart för den nu installerade tjänsten med: ``sudo systemctl enable screenpanel``
   
   Starta tjänsten med: ``sudo systemctl start screenpanel``
   
   Stoppa tjänsten med: ``sudo systemctl stop screenpanel``
   
   Se status för tjänsten med: ``sudo systemctl status screenpanel``
