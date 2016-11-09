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
                     void TrailingStop(int orderType, int startTrailingStop, int trailingStop, int targetMagicNumber);
                     
                     int SendOrderSell(string symbol, int cmd, double volume, double marginpoint, double stoplosspoint, double takeprofitpoint, int magicnumber);
                     int SendOrderBuy(string symbol, int cmd, double volume, double marginpoint, double stoplosspoint, double takeprofitpoint, int magicnumber);
                     void GetProfitData(string symbol, double ProfitPrice, double &ProfitData[]);
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
void MyTradeHelper::TrailingStop(int orderType, int startTrailingStop, int trailingStop, int targetMagicNumber)
{
   Print("startTrailingStop: "+IntegerToString(startTrailingStop)+", TrailingStop: "+IntegerToString(trailingStop));

   for(int i = 0; i < OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false)
      break;
      
      
      //if(OrderTicket() != 35474314)continue; //debug專用
      //Alert("OrderTicket: "+OrderTicket());
      //Alert("orderType: "+orderType+" ==> orderType(): " + OrderType());
      //Alert("OrderMagicNumber: "+OrderMagicNumber());
      if(OrderType()!=orderType){
         if(orderType!=2)continue;
      }
      //Alert("===into line 54===");
      if(OrderSymbol() != Symbol())continue;
      if(OrderMagicNumber() != targetMagicNumber)continue;
      
      string debug;
      //Alert("symbol: "+Symbol()+", OrderSymbol: "+OrderSymbol());
      Print("======");
      debug+="進入單號: "+OrderTicket()+" ("+targetMagicNumber+") ";
      
      // 計算已走了幾步
      double goPoint = NormalizeDouble(OrderProfit()/OrderLots(), 0);
      bool startRule = goPoint > startTrailingStop;
      Print("目前已走了 OrderProfit() "+DoubleToStr(OrderProfit(),2)+" / OrderLots() "+DoubleToStr(OrderLots(), 2)+" = "+goPoint+" 步");
      bool modifyRule = false;
       
      double newSL;
      if(OrderType()==OP_BUY)
      {
         debug+="OP_BUY::";
         newSL = Bid - trailingStop*Point; //BUY搭配Bid，勿動
         Print("newSL "+newSL+" = Bid("+Bid+") - trailingStop*Point("+DoubleToStr(trailingStop*Point, Digits)+")");
         
         if(newSL > OrderStopLoss())
         {
            modifyRule = true;
         }
      }
   
      else if(OrderType()==OP_SELL)
      {
         debug+="OP_SELL::";
         newSL = Ask + trailingStop*Point; //SELL搭配Ask，勿動
         Print("newSL "+newSL+" = Ask("+Ask+") - trailingStop*Point("+DoubleToStr(trailingStop*Point, Digits)+")");
         
         if(OrderStopLoss()==0 || OrderStopLoss() > newSL)
         {
            modifyRule = true;
         }
      }
      
      Print(debug);     
      
      if( startRule && modifyRule )
      {
         bool res = OrderModify(OrderTicket(), OrderOpenPrice(), newSL, OrderTakeProfit(), 0, clrGreen);
         Print("into orderModify::: "+IntegerToString(OrderTicket())+" "+(res?"success":"failed"));      
         //AlertResult(res);
      }else{
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

void MyTradeHelper::GetProfitData(string symbol, double ProfitPrice, double &ProfitData[])
{
 
     ProfitData[0]=-99999;
     ProfitData[1]=-99999;
     
     int total = OrdersTotal();
     for(int i=total-1;i>=0;i--)
     {
       bool res = OrderSelect(i, SELECT_BY_POS);
       if(symbol == "ALL" | symbol == OrderSymbol()){
       
          double orderProfit = OrderProfit();
          if(orderProfit>ProfitPrice){
             ProfitData[0]=NormalizeDouble(OrderTicket(),0);
             ProfitData[1] = NormalizeDouble(orderProfit, Digits);
             break;
          }
          //Alert(OrderSymbol()+" ["+OrderTicket()+"]獲利: "+finalProfit);
       }
       
     }
}