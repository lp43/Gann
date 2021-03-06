//+------------------------------------------------------------------+
//|                                                     MySymbol.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class GannScale
  {
private:

public:
                     GannScale();
                    ~GannScale();
                    static double ConvertToGannValue(string symbol, double value);
                    static double ConvertToValue(string symbol, double gann_value);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
GannScale::GannScale()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
GannScale::~GannScale()
  {
  }
//+------------------------------------------------------------------+
static double GannScale::ConvertToGannValue(string symbol,double value)
  {
     double gannValue = EMPTY_VALUE;
     if(symbol == "USDJPY"){
         //版本1
         //gannValue = NormalizeDouble(value*10, 0);
         //版本2
         gannValue = NormalizeDouble(value*1000/50, 0);
         //Alert("iLow: "+value+" , Gann Value => "+gannValue);
     }
     return gannValue;
  }
  
static double GannScale::ConvertToValue(string symbol,double gann_value)
  {
     double value = EMPTY_VALUE;
     if(symbol == "USDJPY"){
         //版本1
         //value = NormalizeDouble(gann_value/10, Digits);
         //版本2
         value = NormalizeDouble(gann_value*50/1000, Digits);
         //Alert("gann_value: "+gann_value+" , Value => "+DoubleToStr(value, Digits));
     }
     return value;
  }