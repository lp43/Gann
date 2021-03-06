//+------------------------------------------------------------------+
//|                                                         趨勢轉向.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

#property indicator_color1 Blue // Long signal
#property indicator_color2 Red // Short signal
#property indicator_width1 1 // Long signal arrow
#property indicator_width2 1 // Short signal arrow

int margin = 50;

double         ExtUpArrowBuffer[]; 
double         ExtDownArrowBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
    //long chartId = ChartOpen("USDJPY", PERIOD_D1);
    //Alert("Chart First: "+ChartFirst());
    //ChartApplyTemplate(chartId,"PURE.tpl");
    
    //DrawLable("bars", "Bar Size: "+Bars,16, ANCHOR_RIGHT,10, 10, clrWhite);
    
    //---- 2 allocated indicator buffers
    SetIndexBuffer(0,ExtUpArrowBuffer); //0 向上箭頭
    SetIndexBuffer(1,ExtDownArrowBuffer); //1 向下箭頭
   
    //---- drawing parameters setting
    SetIndexStyle(0,DRAW_ARROW);
    SetIndexArrow(0,233); //0 向上箭頭
    SetIndexStyle(1,DRAW_ARROW);
    SetIndexArrow(1,234);//1 向下箭頭
//---
   return(INIT_SUCCEEDED);
  }
  
  int deinit()
  {
//----
   ObjectsDeleteAll();
   CloseAllCharts();
//----
   return(0);
  }
  
  int start()
   {
      
     int limit;
     int counted_bars=IndicatorCounted();
      //---- check for possible errors
     if(counted_bars<0) return(-1);
      //---- the last counted bar will be recounted
     if(counted_bars>0) {
         counted_bars--;
       //Alert("counted_bars: "+counted_bars);
     }
     limit=Bars-counted_bars;
   
     for(int i = 0; i<limit;i++){
         //Alert("i: "+i);
         if(isHighest(i))ExtDownArrowBuffer[i]=High[i] + (margin * Point);//向下趨勢
         if(isLowest(i))ExtUpArrowBuffer[i]= Low[i] -(margin * Point);//向上趨勢
     }
      
      return(0);
   }
//+------------------------------------------------------------------+
void DrawLable(string Name, string text, int size, int right_left, int x_distance, int y_distance, color clr)
{
   ObjectCreate(Name, OBJ_LABEL, 0, 0, 0);
   ObjectSet(Name, OBJPROP_CORNER, right_left);
   ObjectSet(Name, OBJPROP_XDISTANCE, x_distance);
   ObjectSet(Name, OBJPROP_YDISTANCE, y_distance);
   ObjectSet(Name, OBJPROP_ALIGN, ALIGN_RIGHT);

   ObjectSetText(Name,text,size,"Arial",clr);
}

  void CloseAllCharts()
{
  long curChart,prevChart=ChartFirst();
  int i=0,limit=100;//limit is the maximum numbrt that might open in the terminal.
  //Print("ChartFirst =",ChartSymbol(prevChart),"ChartPeriod=",ChartPeriod(prevChart)," ID =",prevChart);
  while(i<limit){
    curChart=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID
    if(curChart==-1)break;
    //Print("ChartCurrent =",ChartSymbol(curChart),"ChartPeriod=",ChartPeriod(curChart)," ID =",curChart);
    bool ret=ChartClose(prevChart);
    if(!ret){
      Alert("chart close failed, #",GetLastError());
      Print(i,ChartSymbol(curChart)," ID =",curChart);
    }
    else prevChart=curChart;// let's save the current chart ID for the ChartNext()
    i++;// Do not forget to increase the counter
  }
}

bool isHighest(int index){//是否為至高點
   bool returnValue = false;
   if(index>0 && index<Bars-1){
      if(High[index]>High[index+1] & High[index]>High[index-1]){
         returnValue = true;
      }
   }
   return returnValue;
}

bool isLowest(int index){ //是否為至低點
   bool returnValue = false;
   if(index>0 && index<Bars-1){
      if(Low[index]<Low[index+1] & Low[index]<Low[index-1]){
         returnValue = true;
      }
   }
   return returnValue;
}





//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
      

    //--- Get the number of bars available for the current symbol and chart period
   int bars=Bars(Symbol(),0);
   Print("Bars = ",bars,", rates_total = ",rates_total,",  prev_calculated = ",prev_calculated);
   Print("time[0] = ",time[0]," time[rates_total-1] = ",time[rates_total-1]);
   
   
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }