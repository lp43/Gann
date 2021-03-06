//+------------------------------------------------------------------+
//|                                                      MyTimer.mqh |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "MyString.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

class MyTimer
  {
                             
private:
                     unsigned long Old_Time;
                     unsigned long YearToSec(unsigned long time);
                     unsigned long DayOfYearToSec(unsigned long time);
                     unsigned long MinToSec(unsigned long time);
                     datetime ToTimeGMT(datetime time);
       
public:
                     MyTimer();
                    ~MyTimer();
             
                    bool IsTimeAfterSec(unsigned long period);
                    bool IsTimeMatch(datetime YYYY_MM_DD_HH_mm, bool isLocalTimeZone);
                    bool IsTimeMatch(datetime YYYY_MM_DD_HH_mm1, datetime YYYY_MM_DD_HH_mm2);
                    bool IsTimeGreaterThan(datetime YYYY_MM_DD_HH_mm, bool isLocalTimeZone);
                    bool IsTimeSmallThan(datetime YYYY_MM_DD_HH_mm, bool isLocalTimeZone);
   
 
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MyTimer::MyTimer()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MyTimer::~MyTimer()
  {
  }


unsigned long MyTimer::YearToSec(unsigned long time)
  {
      return time*365*24*60*60;
  }
  
unsigned long MyTimer::DayOfYearToSec(unsigned long time)
  {
      return time*24*60*60;
  }
  
unsigned long MyTimer::MinToSec(unsigned long time)
  {
      return time*60;
  }
  
    
bool MyTimer::IsTimeAfterSec(unsigned long period)
{
   unsigned long Cur_Year = Year();
   unsigned long Cur_DayOfYear = DayOfYear();
   unsigned long Cur_Hour=Hour();          // Server time in hours
   unsigned long Cur_Min =Minute();        // Server time in minutes
   unsigned long Cur_Sec =Seconds();       // Server time in seconds
   
   //D1=24*60＝1440
   //W1=7*24*60=10080
   //MN=30*24*60=43200
   //201607221131=2016*365*24*60+204*24*60+3*60+46＝1059609600+293760+180+46=1059904066
   
   unsigned long Cur_Time = YearToSec(Cur_Year) + DayOfYearToSec(Cur_Hour) + MinToSec(Cur_Min) + Cur_Sec; 
   PrintFormat("Cur_Time:%lu", Cur_Time);

   //if(Old_Time==0)Old_Time=Cur_Time; 
      if(Cur_Time-Old_Time>=period)
      {
         Old_Time = Cur_Time;
         Print("return true");
         return true;
      }else{
         Print("return false");
         return false;
      }
}

datetime MyTimer::ToTimeGMT(datetime time)
{
   return time+TimeGMTOffset();
}
bool MyTimer::IsTimeMatch(datetime YYYY_MM_DD_HH_mm, bool isLocalTimeZone)
   {
      //bool returnValue = true;
      datetime timetocompare = YYYY_MM_DD_HH_mm;
   
      if(isLocalTimeZone)
      {
         timetocompare = ToTimeGMT(YYYY_MM_DD_HH_mm);
         
      }

     return IsTimeMatch(timetocompare, TimeCurrent());
   }

bool MyTimer::IsTimeMatch(datetime YYYY_MM_DD_HH_mm1, datetime YYYY_MM_DD_HH_mm2)
   {
      bool returnValue = true;
      string strtime1 = TimeToString(YYYY_MM_DD_HH_mm1, TIME_DATE|TIME_MINUTES);
      string strtime2 = TimeToString(YYYY_MM_DD_HH_mm2, TIME_DATE|TIME_MINUTES);
         
     
      if(strtime1 == strtime2)
      {
         //Alert("is equal");
      }else{
         //Alert("is not equal");
      }

      return strtime1 == strtime2;
   }
   
bool MyTimer::IsTimeGreaterThan(datetime YYYY_MM_DD_HH_mm, bool isLocalTimeZone)
{
      bool returnValue = true;
      datetime timetocompare = YYYY_MM_DD_HH_mm;
      if(isLocalTimeZone)
      {
         timetocompare = ToTimeGMT(YYYY_MM_DD_HH_mm);
      }
      datetime timecurrent = TimeCurrent(); 
      
      //Alert("timetocompare: "+timetocompare+", timecurrent: "+timecurrent+", isgreater: "+IntegerToString(greatertime));
      //Alert("inttimetocompare: "+inttimetocompare+", inttimecurrent: "+inttimecurrent+", isgreater: "+IntegerToString(greatertime));
      
      if(timecurrent>=timetocompare)
      {
         //Alert("timecurrent: "+timecurrent+", timetocompare: "+timetocompare+", timecurrent>=timetocompare");
         returnValue = true;
      }else{
         //Alert("timecurrent: "+timecurrent+", timetocompare: "+timetocompare+", timecurrent<timetocompare");
         returnValue = false;
      }
      return returnValue;
}

bool MyTimer::IsTimeSmallThan(datetime YYYY_MM_DD_HH_mm, bool isLocalTimeZone)
{
      bool returnValue = true;
      datetime timetocompare = YYYY_MM_DD_HH_mm;
      if(isLocalTimeZone)
      {
         timetocompare = ToTimeGMT(YYYY_MM_DD_HH_mm);
      }
      datetime timecurrent = TimeCurrent(); 
      
      if(timecurrent<timetocompare)
      {
         //Alert("timecurrent: "+timecurrent+", timetocompare: "+timetocompare+", timecurrent<timetocompare");
         returnValue = true;
      }else{
         //Alert("timecurrent: "+timecurrent+", timetocompare: "+timetocompare+", timecurrent>timetocompare");
         returnValue = false;
      }
      return returnValue;
}
//+------------------------------------------------------------------+
