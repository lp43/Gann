//+------------------------------------------------------------------+
//|                                                      HelloEA.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//#include <Transaction\HelloLibrary.mqh> //如果要放在Include資料夾用這個
#include "Transaction\MyTradeHelper.mqh"//如果要放在EA相同資源用這個

input int 追蹤步數 = 10;

MyTradeHelper tradeHelper;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(1000);
      
   return(INIT_SUCCEEDED);
  }
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   //EventKillTimer();
      
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
int Old_Time;
void OnTick()
  {

      
      if(IsTradeAllowed()){
         tradeHelper.TrailingStop(追蹤步數);
            
         int Cur_Year = Year();
         int Cur_DayOfYear = DayOfYear();
         int Cur_Hour=Hour();          // Server time in hours
         int Cur_Min =Minute();        // Server time in minutes
         int Cur_Sec =Seconds();       // Server time in seconds
         
         //D1=24*60＝1440
         //W1=7*24*60=10080
         //MN=30*24*60=43200
         //201607221131=2016*365*24*60+204*24*60+3*60+46＝1059609600+293760+180+46=1059904066
         
         int Cur_Time = Cur_Year*365*24*60*60 + Cur_DayOfYear*24*60*60 + Cur_Hour*60*60 + Cur_Min*60 + Cur_Sec; 
         int period = Period(); //Time Frame
          
         if(Old_Time==0)Old_Time=Cur_Time; 
         if(Cur_Time-Old_Time>=period)
         {
          //Alert("Cur_Time: "+IntegerToString(Cur_Time)+", Old_Time: "+IntegerToString(Old_Time)+", period: "+IntegerToString(period));
            Old_Time = Cur_Time;
          
           //Buy();
           //Sell();
           
           //Alert("new",IntegerToString(MyCalculator(1,2)));
           
           //tradeHelper.Hello();
         }  
            
      }
     
         
  }
  
  void Buy()
 {
    //double StopLoss=NormalizeDouble(Ask-0.00050, Digits);
    //double TakeProfit=NormalizeDouble(Ask+0.00100, Digits);
    double StopLoss=0;
    double TakeProfit=0;
    Print("StopLoss: "+ DoubleToString(StopLoss)+", TakeProfit: "+DoubleToString(TakeProfit));
    
      int ticket = OrderSend(Symbol(), OP_BUY, 0.01, Ask, 3, StopLoss, TakeProfit, "MyFirstOrder", 11111, 0, clrBlue);
      
      if(ticket<0)
      {
         Print("OrderSend failed with error #",GetLastError());
      }
      else
      {
         Print("OrderSend placed successfully");
      }

 }
 
  void Sell()
 {
    //double StopLoss=NormalizeDouble(Bid+0.00050, Digits);
    //double TakeProfit=NormalizeDouble(Bid-0.00100, Digits);
     double StopLoss=0;
    double TakeProfit=0;
    Print("StopLoss: "+ DoubleToString(StopLoss)+", TakeProfit: "+DoubleToString(TakeProfit));
    
      int ticket = OrderSend(Symbol(), OP_SELL, 0.01, Bid, 3, StopLoss, TakeProfit, "MyFirstOrder", 11111, 0, clrBlue);
      
      if(ticket<0)
      {
         Print("OrderSend failed with error #",GetLastError());
      }
      else
      {
         Print("OrderSend placed successfully");
      }

 }
 
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
