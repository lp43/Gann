//+------------------------------------------------------------------+
//|                                                      MyTrade.mqh |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MyTradeHelper
  {
private:
                     void AlertResult(bool res);
                     void PrintResult(bool res);
                     int SendOrder(string symbol, int cmd, double volume, double price, double stoploss, double takeprofit, int magicnumber);
                     
public:
                     MyTradeHelper();
                    ~MyTradeHelper();
                     void TrailingStop(int startTrailingStop, int trailingStop, int targetMagicNumber);
                     
                     int SendOrderSell(string symbol, int cmd, double volume, double marginpoint, double stoplosspoint, double takeprofitpoint, int magicnumber);
                     int SendOrderBuy(string symbol, int cmd, double volume, double marginpoint, double stoplosspoint, double takeprofitpoint, int magicnumber);
                     double ProfitNotify();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MyTradeHelper::MyTradeHelper()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MyTradeHelper::~MyTradeHelper()
  {
  }
//+------------------------------------------------------------------+
void MyTradeHelper::TrailingStop(int startTrailingStop, int trailingStop, int targetMagicNumber)
{
   Print("startTrailingStop: "+IntegerToString(startTrailingStop)+", TrailingStop: "+IntegerToString(trailingStop));

   for(int i = 0; i < OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false)
      break;
      
      //Alert("OrderMagicNumber(): " + OrderMagicNumber());
      //Alert("======");
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == targetMagicNumber){
         //Alert("symbol: "+Symbol()+", OrderSymbol: "+OrderSymbol());
         //Alert("進入單號: "+OrderTicket()+" ("+targetMagicNumber+")");
         
         if(OrderType()==OP_BUY)
         {
           
            double newTSSL = Bid - trailingStop*Point;
            
            bool startRule = Bid - OrderOpenPrice() > startTrailingStop*Point;
            bool modifyRule = false;
            if(newTSSL > OrderStopLoss())
            {
               modifyRule = true;
            }
            
            if( startRule && modifyRule )
            {
               bool res = OrderModify(OrderTicket(), OrderOpenPrice(), newTSSL, OrderTakeProfit(), 0, clrGreen);
               //Alert("into orderModify BUY::: "+IntegerToString(OrderTicket())+" "+(res?"success":"failed"));
               
               //AlertResult(res);
            }else{
               //Alert(IntegerToString(OrderTicket())+"::: "+"startRule: "+(startRule?"true":"false")+", modifyRule: "+(modifyRule?"true":"false"));
               //Print("BUY ELSE, Bid: "+DoubleToString(Bid)+", OrderOpenPrice: "+DoubleToString(OrderOpenPrice())+", Trailing: "+DoubleToString(trailingStop * Point));
            }
         }
         
      
         else if(OrderType()==OP_SELL)
         {
         
            double newTSSL = Ask + trailingStop*Point;
            
            bool startRule = OrderOpenPrice() - Ask > startTrailingStop*Point;
            bool modifyRule = false;
            if(OrderStopLoss()==0 || OrderStopLoss() > newTSSL)
            {
               modifyRule = true;
            }
          
            //bool modifyRule = OrderStopLoss() > Ask + trailingStop*Point;
            
            if( startRule && modifyRule )
            {
               
               bool res = OrderModify(OrderTicket(), OrderOpenPrice(), newTSSL, OrderTakeProfit(), 0, clrGreen);
               //Alert("into orderModify SELL::: "+IntegerToString(OrderTicket())+" "+(res?"success":"failed"));
               
               //AlertResult(res);
            }else{
               //Alert(IntegerToString(OrderTicket())+"::: "+"startRule: "+(startRule?"true":"false")+", modifyRule: "+(modifyRule?"true":"false"));
               //Print("BUY ELSE, Bid: "+DoubleToString(Bid)+", OrderOpenPrice: "+DoubleToString(OrderOpenPrice())+", Trailing: "+DoubleToString(trailingStop * Point));
            }
         }

      }
    
 
   }
      

}

void MyTradeHelper::AlertResult(bool res)
{
 if(!res)
      Alert("Error in OrderModify. Error code=",GetLastError());
    else
      Alert("Order modified successfully.");
}

void MyTradeHelper::PrintResult(bool res)
{
 if(!res)
      Print("Error in OrderModify. Error code=",GetLastError());
    else
      Print("Order modified successfully.");
}

int MyTradeHelper::SendOrderBuy(string symbol,int cmd,double volume,double marginpoint,double stoplosspoint,double takeprofitpoint,int magicnumber)
{   
    double NewPrice = Ask;
    if(cmd == OP_BUYSTOP){
      NewPrice = Ask + marginpoint*Point;
    }else if(cmd == OP_BUYLIMIT){
      NewPrice = Ask - marginpoint*Point;
    }
     
    double StopLoss=0;
    if(stoplosspoint!=0){
      StopLoss = NormalizeDouble(NewPrice-stoplosspoint*Point, Digits);
    }
    double TakeProfit = 0;
    if(takeprofitpoint!=0){
      TakeProfit=NormalizeDouble(NewPrice+takeprofitpoint*Point, Digits);
    }
   
    return SendOrder(symbol, cmd, volume, NewPrice, StopLoss, TakeProfit, magicnumber);
}

int MyTradeHelper::SendOrderSell(string symbol,int cmd,double volume,double marginpoint,double stoplosspoint,double takeprofitpoint,int magicnumber)
{
    double NewPrice = Bid;
    
     if(cmd == OP_SELLSTOP){
      NewPrice = Bid - marginpoint*Point;
    }else if(cmd == OP_SELLLIMIT){
      NewPrice = Bid + marginpoint*Point;
    }
    
    double StopLoss=0;
    if(stoplosspoint!=0){
      StopLoss = NormalizeDouble(NewPrice+stoplosspoint*Point, Digits);
    }
    double TakeProfit = 0;
    if(takeprofitpoint!=0){
      TakeProfit=NormalizeDouble(NewPrice-takeprofitpoint*Point, Digits);
    }
    
   return SendOrder(symbol, cmd, volume, NewPrice, StopLoss, TakeProfit, magicnumber);
}

int MyTradeHelper::SendOrder(string symbol, int cmd, double volume,double price,double stoploss,double takeprofit,int magicnumber)
 {
   int ticket = OrderSend(symbol, cmd, volume, price, 3, stoploss, takeprofit, "MyFirstOrder", magicnumber, 0, clrBlue);
   return ticket;
 }

double MyTradeHelper::ProfitNotify()
{
     double finalProfit = 0;
     
     int total = OrdersTotal();
     for(int i=total-1;i>=0;i--)
     {
       bool res = OrderSelect(i, SELECT_BY_POS);
       if(OrderSymbol() == Symbol())
       {
       
          double orderProfit = OrderProfit();
          finalProfit = NormalizeDouble(orderProfit, 5);
          
          //Alert("最終獲利價: "+finalProfit);
       }
       
     }
 
   return finalProfit;
}