//+------------------------------------------------------------------+
//|                                (T_S_R)-Daily Range Display#2.mq4 |
//|                      Copyright � 2006, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright � 2006, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
#property link      "Display by cja" 
// Thanks to the coders who supplied some of the code Daily_Open Indicator
// & Xdard777 for his MM labels code. 

#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Coral
#property indicator_width1 2

//---- indicator buffers

#define Daily "Daily"
#define Daily1 "Daily1"
#define Daily2 "Daily2"

extern color DailyColor =Maroon;//C'99,39,11'
extern color DailyColor1 =DarkGreen;//C'0,49,09'
extern color DailyColor2= C'0,44,09';

double TodayOpenBuffer[];
extern int TimeZoneOfData= 0;

//---- input parameters
int i2=0,WorkTime=0,Periods=0,CurPeriod=0,nTime=0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
{
  	SetIndexStyle(0,DRAW_LINE,STYLE_SOLID);
	SetIndexBuffer(0,TodayOpenBuffer);
	SetIndexLabel(0,"Open");
	SetIndexEmptyValue(0,0.0); 
   return(0);
}
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   ObjectsDeleteAll();
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+

int start()
 {
  int lastbar;
   int counted_bars= IndicatorCounted();
   
   if (counted_bars>0) counted_bars--;
   lastbar = Bars-counted_bars;	
   DailyOpen(0,lastbar);
   CreateHL();
   return(0);
}

void CreateObj(string objName, double start, double end, color clr)
  {
   ObjectCreate(objName, OBJ_RECTANGLE, 0, iTime(NULL,1440,0), start, Time[0], end);
   ObjectSet(objName, OBJPROP_COLOR, clr);
   ObjectCreate(objName, OBJ_RECTANGLE, 0, iTime(NULL,1440,0), 0, Time[0],0);
   ObjectSet(objName, OBJPROP_COLOR, clr);
   }
   void DeleteObjects()
   {
   ObjectDelete(Daily);
   ObjectDelete(DailyColor);
   ObjectDelete(Daily1);
   ObjectDelete(DailyColor1);
   ObjectDelete(Daily2);
   ObjectDelete(DailyColor2);
   
   }
   void CreateHL()
   {
   DeleteObjects();
  double HI2 = iHigh(NULL,1440,0);
  double LOW2 = iLow(NULL,1440,0); 
  double HI3 = iHigh(NULL,1440,1);
  double LOW3 = iLow(NULL,1440,1);
  double HI4 = iHigh(NULL,1440,0);
  double LOW4 = iLow(NULL,1440,0);
  double HI5 = iHigh(NULL,1440,2);
  double LOW5 = iLow(NULL,1440,2);
  double HI6 = iHigh(NULL,1440,3);
  double LOW6 = iLow(NULL,1440,3);
  double HI7 = iHigh(NULL,1440,4);
  double LOW7 = iLow(NULL,1440,4);
  double HI8 = iHigh(NULL,1440,5);
  double LOW8 = iLow(NULL,1440,5);
  double HI9 = iHigh(NULL,1440,6);
  double LOW9 = iLow(NULL,1440,6);
  double HI10 = iHigh(NULL,1440,7);
  double LOW10 = iLow(NULL,1440,7);
  double HI11 = iHigh(NULL,1440,8);
  double LOW11 = iLow(NULL,1440,8);
  double HI12 = iHigh(NULL,1440,9);
  double LOW12 = iLow(NULL,1440,9);
  double HI13 = iHigh(NULL,1440,10);
  double LOW13 = iLow(NULL,1440,10);
  double HI14 = iHigh(NULL,1440,11);
  double LOW14 = iLow(NULL,1440,11);
  double HI15 = iHigh(NULL,1440,12);
  double LOW15 = iLow(NULL,1440,12);
  double HI16 = iHigh(NULL,1440,13);
  double LOW16 = iLow(NULL,1440,13);
  double HI17 = iHigh(NULL,1440,14);
  double LOW17 = iLow(NULL,1440,14);
  double HI18 = iHigh(NULL,1440,15);
  double LOW18 = iLow(NULL,1440,15);
  double HI19 = iHigh(NULL,1440,16);
  double LOW19 = iLow(NULL,1440,16);
  double HI20 = iHigh(NULL,1440,17);
  double LOW20 = iLow(NULL,1440,17);
  double HI21 = iHigh(NULL,1440,18);
  double LOW21 = iLow(NULL,1440,18);
  double HI22 = iHigh(NULL,1440,19);
  double LOW22 = iLow(NULL,1440,19);
  double HI23 = iHigh(NULL,1440,20);
  double LOW23 = iLow(NULL,1440,20);
  
  double OPEN = iOpen(NULL,1440,0);
  double CLOSE = iClose(NULL,1440,0);
  
  double ONE = (HI3-LOW3)/2;
  
  double FIVE = ((HI3-LOW3)+(HI5-LOW5)+(HI6-LOW6)+(HI7-LOW7)+(HI8-LOW8))/10;
                   
                
  double TEN = ((HI3-LOW3)+(HI5-LOW5)+(HI6-LOW6)+(HI7-LOW7)+(HI8-LOW8)+
                  (HI9-LOW9)+(HI10-LOW10)+(HI11-LOW11)+(HI12-LOW12)+(HI13-LOW13))/20;
                    
  double TWENTY = ((HI3-LOW3)+(HI5-LOW5)+(HI6-LOW6)+(HI7-LOW7)+(HI8-LOW8)+
               (HI9-LOW9)+(HI10-LOW10)+(HI11-LOW11)+(HI12-LOW12)+(HI13-LOW13)+
               (HI14-LOW14)+(HI15-LOW15)+(HI16-LOW16)+(HI17-LOW17)+(HI18-LOW18)+
               (HI19-LOW19)+(HI20-LOW20)+(HI21-LOW21)+(HI22-LOW22)+(HI23-LOW23))/40; 
                                              
  double AV = (ONE+FIVE+TEN+TWENTY)/4;// New SettingAV = (FIVE+TEN+TWENTY)/3;
  
  double HIDaily = iHigh(NULL,1440,0)-(AV);
  double LOWDaily = iLow(NULL,1440,0)+(AV);
  double HIDaily1 = iHigh(NULL,1440,0); 
  double LOWDaily1 =iLow(NULL,1440,0); 
  double HIDaily2 = iHigh(NULL,1440,0)-(AV)*2; 
  double LOWDaily2 =iLow(NULL,1440,0)+(AV)*2; 
  
    

//Short Average
 if(ObjectFind("HIDaily1") != 0)
{
ObjectCreate("HIDaily1", OBJ_TEXT, 0, Time[0], HIDaily);
ObjectSetText("HIDaily1", "                      空單進入", 9, "Verdana", Yellow);
}
else
{
ObjectMove("HIDaily1", 0, Time[0], HIDaily);
} 

//High Average
 if(ObjectFind("HIDaily2") != 0)
{
ObjectCreate("HIDaily2", OBJ_TEXT, 0, Time[0], LOWDaily);
ObjectSetText("HIDaily2", "                      多單進入", 9, "Verdana", Yellow);
}
else
{
ObjectMove("HIDaily2", 0, Time[0], LOWDaily);
}

//Today's High
 if(ObjectFind("HIDaily3") != 0)
{
ObjectCreate("HIDaily3", OBJ_TEXT, 0, Time[0], HI4);
ObjectSetText("HIDaily3", "            高 ", 9, "Verdana", YellowGreen);
}
else
{
ObjectMove("HIDaily3", 0, Time[0], HI4);
}

//Todays Low 
 if(ObjectFind("HIDaily4") != 0)
{
ObjectCreate("HIDaily4", OBJ_TEXT, 0, Time[0], LOW4);
ObjectSetText("HIDaily4", "           低 ", 9, "Verdana", YellowGreen);
}
else
{
ObjectMove("HIDaily4", 0, Time[0], LOW4);
}

//Open
 if(ObjectFind("HIDaily5") != 0)
{
ObjectCreate("HIDaily5", OBJ_TEXT, 0, Time[0], OPEN);
ObjectSetText("HIDaily5", "             開 ", 9, "Verdana",SandyBrown);
}
else
{
ObjectMove("HIDaily5", 0, Time[0], OPEN);
}

//Bottom of Daily Range
 if(ObjectFind("HIDaily6") != 0)
{
ObjectCreate("HIDaily6", OBJ_TEXT, 0, Time[8],HIDaily2);
ObjectSetText("HIDaily6", "每日波動下限", 9, "Verdana",SandyBrown);
}
else
{
ObjectMove("HIDaily6", 0, Time[8], HIDaily2);
}
//TOP of Daily Range
 if(ObjectFind("HIDaily7") != 0)
{
ObjectCreate("HIDaily7", OBJ_TEXT, 0, Time[7],LOWDaily2);
ObjectSetText("HIDaily7", "每日波動上限", 9, "Verdana",SandyBrown);
}
else
{
ObjectMove("HIDaily7", 0, Time[7], LOWDaily2);
}

   {
if( (WorkTime != Time[0]) || (Periods != Period()) ) {
CreateObj(Daily, HIDaily, LOWDaily, DailyColor);
CreateObj(Daily1, HIDaily1, LOWDaily1, DailyColor1);
CreateObj(Daily2, HIDaily2, LOWDaily2, DailyColor2);}


} 

Comment("\n",  "開盤: ",  OPEN,"\n","\n", "今日最高: ", HI2,"  最低: ", LOW2,"\n", "\n", "當前到開盤: ", (CLOSE-OPEN),"\n","\n",
                    "從高到低: ", (HI2-LOW2)/Point,"\n","\n","50%每日平均; ",AV,"\n","\n","空單進入; ",(HIDaily)
                    ,"\n","\n","多單進入; ",(LOWDaily),"\n","\n","每日波動上限; ",(LOWDaily2),"\n","\n","每日波動下限; ",(HIDaily2));
                    

   
   
  }
//+------------------------------------------------------------------+

int DailyOpen(int offset, int lastbar)
{
   int shift;
   int tzdiffsec= TimeZoneOfData * 3600;
   double barsper30= 1.0*PERIOD_M30/Period();
   bool ShowDailyOpenLevel= True;
   // lastbar+= barsperday+2;  // make sure we catch the daily open		 
   lastbar= MathMin(Bars-20*barsper30-1, lastbar);

	for(shift=lastbar;shift>=offset;shift--){
	  TodayOpenBuffer[shift]= 0;
     if (ShowDailyOpenLevel){
       if(TimeDayOfWeek(Time[shift]-tzdiffsec) != TimeDayOfWeek(Time[shift+1]-tzdiffsec)){      // day change
         TodayOpenBuffer[shift]= Open[shift];         
         TodayOpenBuffer[shift+1]= 0;                                                           // avoid stairs in the line
       }
       else{
         TodayOpenBuffer[shift]= TodayOpenBuffer[shift+1];
       }
	  }
   }
      return(0);
}