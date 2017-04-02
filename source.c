# include <at89x51.h>
# define LCDPort P2
sbit RS=P1^0;
sbit RW=P1^1;
sbit EN=P1^2;
sbit sensor=P3^2;

void delay(int t)
     {
	        int i;
		while(t>0)
		  {
		    i=1275;
			while(i>0) i--;
			t--;
		  }
	 }
  void LCDCommand(unsigned char Value)
     {
	        RS=0;
		RW=0;
		LCDPort=Value;
		EN=1;
		delay(2);
		EN=0;
		return;
	}

 void LCDData(unsigned char Value)
     {
	        RS=1;
		RW=0;
		LCDPort=Value;
		EN=1;
		delay(2);
		EN=0;
		return;
	}
 void LCDInit()
    {
	  LCDCommand(0x38);
	  LCDCommand(0x06);
	  LCDCommand(0x0c);
	  LCDCommand(0x01);
	}
 LCDPuts(char *s)
    {
	   int i;
	   for(i=0;s[i];i++) LCDData(s[i]);
	}




 void main()
    {
	  LCDInit();
	  LCDPuts("   Automatic");
		LCDCommand(0xc0);
		LCDPuts("Irrigation Sys.");
		delay(1000);
	  while(1)
	    {
		LCDCommand(0x01);
		delay(100);
		if(sensor == 1)
		{
		LCDCommand(0xc0);
		LCDPuts("Less Humidity");
		}
		else if(sensor == 0)
		{
		LCDCommand(0xc0);
		LCDPuts("Enough Humidity");
		}
		delay(100);
	    }
    }
