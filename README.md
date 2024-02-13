# Installation för Raspberry Pi
Kom ihåg att RPI:n måste vara kopplad till nätverket via kabel för att nå servern.
1. Välj Linux-mappen.
2. Skriv nyckeln från servern i config-filen vid ``Key``.
3. Döp om den .exe-fil som matchar din dators processor till ``panel.exe`` (32-bit är ARMv7, 64-bit är ARMv8 oftast).
4. Kör ``setup.sh`` via terminalen ``sudo bash setup.sh`` i mappen.
5. Sätt på autostart för den nu installerade tjänsten med: ``sudo systemctl enable screenpanel``
   
   Starta tjänsten med: ``sudo systemctl start screenpanel``
   
   Stoppa tjänsten med: ``sudo systemctl stop screenpanel``
   
   Se status för tjänsten med: ``sudo systemctl status screenpanel``

6. För att stänga av skärmsläckaren (screen blanking) kör du ``sudo raspi-config`` i terminalen. Välj sedan Display Options -> Screen Blanking.
