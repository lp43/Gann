//+------------------------------------------------------------------+
//|                                                        江恩 V1.mq4 |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "..\Experts\Utils\Gann.mqh"

Gann gann;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   gann.DrawSquare(1,1,3, true);  //true 為順時針

   //double Angles[];
   //double beginValue = 20;
   //int angle = gann.RunAngle(RUN_HIGH, beginValue, Angles);
   //Alert(beginValue+"'s HIGH Angle is: "+angle);
   
   double Crosses[];
   double beginValue = 20;
   int cross = gann.RunCross(RUN_HIGH, beginValue, Crosses);
   Alert(beginValue+"'s HIGH Cross is: "+cross);
  }
//+------------------------------------------------------------------+
