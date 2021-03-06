//+------------------------------------------------------------------+
//|                                            close-all-orders.mq4  |
//|                                  Copyright ?2005, Matias Romeo. |
//|                                       Custom Metatrader Systems. |
//+------------------------------------------------------------------+

#property copyright "Copyright 2016, Simon Pan."
#property link      "mailto:lp43simonATgmail.com"
#property description "一口氣清除所有場上/預掛單。"
#property version "3.10"
#property show_inputs

input bool 刪除場上單 = true;
input bool 刪除預掛單 = true;
bool IsTerminate;
int start()
{
   
   if(IsTradeAllowed()==false){
      Alert("請先開啟EA交易再繼續!");
      return (INIT_FAILED);
   }
   
  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    if(IsTerminate)break;
    
    bool res = OrderSelect(i, SELECT_BY_POS);
    int type   = OrderType();

    bool result = false;
    
    switch(type)
    {
    
      //Close opened long positions
      case OP_BUY       : 
      {
         if(刪除場上單==true){
            result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
            
            if(result == false){
               AlertFailed();
            }
         }
          break;
      }
      //Close opened short positions
      case OP_SELL      : 
      {
         if(刪除場上單==true){
             result = OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );
             
             if(result == false){
               AlertFailed();
            }
         }
         break;
      }

  
      //Close pending orders
      case OP_BUYLIMIT  :
      case OP_BUYSTOP   :
      case OP_SELLLIMIT :
      case OP_SELLSTOP  : 
      {
          if(刪除預掛單==true){
            result = OrderDelete( OrderTicket() );
            
            if(result == false){
               AlertFailed();
            }
          }
         break;
      }
      

    }
    
  }
  Alert("真心平倉流程結束。");
  return(0);
}

void AlertFailed()
 {
     int ErrorCode = GetLastError();
     if(ErrorCode==ERR_MARKET_CLOSED)
     {   
         IsTerminate = TRUE;
         Alert("交易市場關閉。");
     }
     else
     {
         Alert("Order " , OrderTicket() , " failed to close. Error:" , ErrorCode);
     }
     //Sleep(3000);
 }


