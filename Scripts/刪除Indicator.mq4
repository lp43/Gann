//+------------------------------------------------------------------+
//|                                                  刪除Indicator.mq4 |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   int window=ChartWindowFind();
   ChartIndicatorDelete(0, window, "WINDMILL");
  }
//+------------------------------------------------------------------+
