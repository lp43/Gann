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
#include "Utils\MyTimer.mqh"

input int 開始追蹤止損步數 = 20;
input int 追蹤止損步數 = 15;
input int 止損步數 = 30;

input int 距離現價步數 = 0;
MyTradeHelper tradeHelper;

MyTimer timer1;
MyTimer timer2;

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

void OnTick()
  {

      
      if(IsTradeAllowed()){
      //---
      
         //if(timer1.IsAfterSec(5))
         //{
           // tradeHelper.TrailingStop(開始追蹤步數, 追蹤步數);

         //}
        

         //Time Frame   
         if(timer2.IsAfterSec(Period()*60)) 
         {
           //Buy();
           BuyStop();
           //BuyLimit();
           
           //Sell();
           SellStop();
           //SellLimit();
           
           //Alert("new",IntegerToString(MyCalculator(1,2)));
            //tradeHelper.Hello("Period()");
         }
        
           
            
      }
     
         
  }
  
  void Buy()
   {
      int ticket = tradeHelper.SendOrderBuy(Symbol(), OP_BUY, 0.01, 0, 止損步數, 0, 11111);
      if(ticket<0)
      {
         //Alert("OrderSend failed with error #",GetLastError());
      }
      else
      {
         //Alert("OrderSend placed successfully");
      }
 }
 
   void BuyStop()
   {
      int ticket = tradeHelper.SendOrderBuy(Symbol(), OP_BUYSTOP, 0.01, 距離現價步數, 0, 0, 11111);
      if(ticket<0)
      {
         //Alert("OrderSend failed with error #",GetLastError());
      }
      else
      {
         //Alert("OrderSend placed successfully");
      }
 }
 
   void BuyLimit()
   {
      int ticket = tradeHelper.SendOrderBuy(Symbol(), OP_BUYLIMIT, 0.01, 距離現價步數, 0, 0, 11111);
      if(ticket<0)
      {
         //Alert("OrderSend failed with error #",GetLastError());
      }
      else
      {
         //Alert("OrderSend placed successfully");
      }
 }
  void Sell()
 {
 
      int ticket = tradeHelper.SendOrderSell(Symbol(), OP_SELL, 0.01, 0, 止損步數, 0, 11111);
      if(ticket<0)
      {
         //Alert("OrderSend failed with error #",GetLastError());
      }
      else
      {
         //Alert("OrderSend placed successfully");
      }

 }
 
    void SellStop()
   {
      int ticket = tradeHelper.SendOrderSell(Symbol(), OP_SELLSTOP, 0.01, 距離現價步數, 0, 0, 11111);
      if(ticket<0)
      {
         //Alert("OrderSend failed with error #",GetLastError());
      }
      else
      {
         //Alert("OrderSend placed successfully");
      }
 }
 
   void SellLimit()
   {
      int ticket = tradeHelper.SendOrderSell(Symbol(), OP_SELLLIMIT, 0.01, 距離現價步數, 0, 0, 11111);
      if(ticket<0)
      {
         //Alert("OrderSend failed with error #",GetLastError());
      }
      else
      {
         //Alert("OrderSend placed successfully");
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
