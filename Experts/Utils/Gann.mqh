//+------------------------------------------------------------------+
//|                                                         Gann.mqh |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "Cursor.mqh"
#include "MyMath.mqh"
#include "Debug.mqh"

extern int RUN_BOTH = 0;
extern int RUN_HIGH = 1;
extern int RUN_LOW  = 2;

Cursor cursor;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Gann
  {
private:
                    int NowInsertIdx;
                    double OriValues[];
                    void GenerateValues(double &values[], double begin, double step, int size);
                    void InsertValues(double &values[], int size, bool isCW);
                    void InsertValueLeftToRight(double &values[]);
                    void InsertValueBottomToTop(double &values[]);
                    void InsertValueRightToLeft(double &values[]);
                    void InsertValueTopToBottom(double &values[]);
                    bool IsCursorOnCenter();
                    void GetAngleNums(int run_type, double value, double &values[]);
                    void GetCrossNums(int run_type, double value, double &values[]);
                    bool IsAngleNum(double base_num, double compare_num);
                    bool IsCrossNum(double base_num, double compare_num);
                    
public:
                     Gann();
                    ~Gann();
                    void DrawSquare(double begin, double step, int size, bool isCW); //CW 順時針
                    void RunCycle(int run_type, double begin_value, double &cycles[]);
                    void Run90(int run_type, double begin_value, double &values[]);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Gann::Gann()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Gann::~Gann()
  {
  }
//+------------------------------------------------------------------+
Gann::DrawSquare(double begin, double step, int size, bool isCW)
{
     
   GenerateValues(OriValues, begin, step, size);
   InsertValues(OriValues, size, isCW); // run clockwise順時針 / counterclockwise逆時針
   
  
}
void Gann::GenerateValues(double &values[], double begin, double step, int size)
{
   int length = MathPow(((1+size)+size),2);// 總數=(size+1)+(size)的平方
   ArrayResize(values, length);
   
   for(int i = 0;i<ArraySize(values);i++){
      if(i==0){
         values[i]=begin;
      }else{
         values[i] = values[i-1]+step;
      }
  
   }
}
void Gann::InsertValues(double &values[], int size, bool isCW)
{
   // 開出一個空白江恩矩形的矩陣
   cursor.InitSquareArray(size);
 
 //=========開始將產生出來的值塞入江恩矩陣================
   int position[2];
   // 先將指標移至最後一筆
   int last = cursor.GetLastIdxOnChart(isCW);
   cursor.SetCursorTo(last);
   NowInsertIdx = ArraySize(values)-1;
   cursor.SetValue(values[NowInsertIdx]);
   
   // 再用迴圈將江恩值由外圍向內圍塞完
   if(isCW){ // 順時針
      
      do{
         InsertValueLeftToRight(values);
         InsertValueBottomToTop(values);
         InsertValueRightToLeft(values);
         InsertValueTopToBottom(values);
      }
      while(IsCursorOnCenter() == FALSE);
   }else{  //逆時針
      do{
         InsertValueRightToLeft(values);
         InsertValueBottomToTop(values);
         InsertValueLeftToRight(values);
         InsertValueTopToBottom(values);
      }
      while(IsCursorOnCenter() == FALSE);
   }
 
   
   cursor.PrintSquare();

}

void Gann::InsertValueLeftToRight(double &values[])
{  

 //Alert("InsertValueLeftToRight, Start From InsertIdx: "+NowInsertIdx);
    while(cursor.GetCursorIdx()!=cursor.GetCenterIdx() && cursor.Right())
    {
         if(cursor.HasValue()==FALSE)
         {
            cursor.SetValue(values[--NowInsertIdx]); 
         
            int positions[2];
            cursor.GetCursorPosition(positions);
            Alert("NowCursorIdx: ["+positions[0]+","+positions[1]+"], value: "+cursor.GetValueByIdx(cursor.GetCursorIdx()));
         }else{
            if(IsCursorOnCenter() == FALSE){
               cursor.Left();//因為已填值，因此將指針移回前一位置
            }
            break;
            
         }
         
    }
}

void Gann::InsertValueBottomToTop(double &values[])
{  
      //Alert("InsertValueBottomToTop, Start From InsertIdx: "+NowInsertIdx);
   
    while(cursor.GetCursorIdx()!=cursor.GetCenterIdx() && cursor.Up())
    {
         if(cursor.HasValue()==FALSE)
         {
             cursor.SetValue(values[--NowInsertIdx]); 
         
             int positions[2];
             cursor.GetCursorPosition(positions);
             Alert("NowCursorIdx: ["+positions[0]+","+positions[1]+"], value: "+cursor.GetValueByIdx(cursor.GetCursorIdx()));
         }else{
               if(IsCursorOnCenter() == FALSE){
                  cursor.Down();//因為已填值，因此將指針移回前一位置
               }
               break;
         }
    }
}

void Gann::InsertValueRightToLeft(double &values[])
{  
      //Alert("InsertValueRightToLeft, Start From InsertIdx: "+NowInsertIdx);
      while(cursor.GetCursorIdx()!=cursor.GetCenterIdx() && cursor.Left())
       {
            if(cursor.HasValue()==FALSE)
            {
               cursor.SetValue(values[--NowInsertIdx]); 
            
               int positions[2];
               cursor.GetCursorPosition(positions);
               Alert("NowCursorIdx: ["+positions[0]+","+positions[1]+"], value: "+cursor.GetValueByIdx(cursor.GetCursorIdx()));     
            }else{
               if(IsCursorOnCenter() == FALSE){
                  cursor.Right();//因為已填值，因此將指針移回前一位置
               }
               break;
            }
            
       }
}

void Gann::InsertValueTopToBottom(double &values[])
{  
    //Alert("InsertValueTopToBottom, Start From InsertIdx: "+NowInsertIdx);
       while(cursor.GetCursorIdx()!=cursor.GetCenterIdx() && cursor.Down())
       {
            if(cursor.HasValue()==FALSE){
               cursor.SetValue(values[--NowInsertIdx]); 
            
               int positions[2];
               cursor.GetCursorPosition(positions);
               Alert("NowCursorIdx: ["+positions[0]+","+positions[1]+"], value: "+cursor.GetValueByIdx(cursor.GetCursorIdx()));  
            }else{
               if(IsCursorOnCenter() == FALSE){
                  cursor.Up();//因為已填值，因此將指針移回前一位置
               }
               break;
            }
         
       }
}

bool Gann::IsCursorOnCenter(void)
{
   return cursor.GetCursorIdx() == cursor.GetCenterIdx();
}
// 開始跑循環
void Gann::RunCycle(int run_type, double begin_value, double &cycles[])
{
   double found = MyMath::FindClosest(OriValues, begin_value);
   int found_idx = ArrayBsearch(OriValues, found, WHOLE_ARRAY, 0, MODE_ASCEND); 
   Alert("found value: "+found+", found_idx: "+found_idx);
   
   if(run_type == RUN_HIGH){
      ArrayCopy(cycles, OriValues, 0, found_idx, WHOLE_ARRAY);
   }else{
      
      double temp[];
      ArrayCopy(temp, OriValues, 0, 0, found_idx+1);
      MyMath::ReverseArray(temp, cycles);
      Debug::PrintArray(cycles);
   }

}

void Gann::GetAngleNums(int run_type, double value, double &values[])
{
   double BeginValue = MyMath::FindClosest(OriValues, value);
   int AnglePositions[];
   cursor.GetPositionByValue(BeginValue, AnglePositions);
}

void Gann::GetCrossNums(int run_type, double value, double &values[])
{

}                

bool Gann::IsAngleNum(double base_num, double compare_num)
{
   bool isAngleNum = false;
   int BasePosition[2];
   cursor.GetPositionByValue(base_num, BasePosition);
   int basepositionX = BasePosition[0];
   int basepositionY = BasePosition[1];
   Debug::PrintPosition(cursor, BasePosition);
   
   int ComparePosition[2];
   cursor.GetPositionByValue(compare_num, ComparePosition);
   int comparepositionX = ComparePosition[0];
   int comparepositionY = ComparePosition[1];
   
   int diffX = comparepositionX - basepositionX;
   int diffY = comparepositionY - basepositionY;
   
   if(diffX + diffY == 0 | diffX - diffY ==0)
   {
      isAngleNum = true;
   }
   return isAngleNum;
}

bool Gann::IsCrossNum(double base_num, double compare_num)
{
    bool isCrossNum = false;
   int BasePosition[2];
   cursor.GetPositionByValue(base_num, BasePosition);
   int basepositionX = BasePosition[0];
   int basepositionY = BasePosition[1];
   Debug::PrintPosition(cursor, BasePosition);
   
   int ComparePosition[2];
   cursor.GetPositionByValue(compare_num, ComparePosition);
   int comparepositionX = ComparePosition[0];
   int comparepositionY = ComparePosition[1];
   
   if(basepositionX == comparepositionX | basepositionY == comparepositionY)
   {
      isCrossNum = true;
   }
   return isCrossNum;
}
                    
void Gann::Run90(int run_type, double begin_value, double &values[])
{
   // 1.在整份圖表上，找出相近值當臨活基數
   double closestValue = MyMath::FindClosest(OriValues, begin_value);
   Alert("closestValue is: "+closestValue);
   // 2.將指針移到該臨時基數
   cursor.SetCursorByValue(closestValue);
   //Debug::PrintPosition(cursor,cursor.GetCursorIdx());
   
   double Cycles[];
   RunCycle(run_type, closestValue, Cycles);
   
  
   for(int i = 0 ;i < ArraySize(Cycles);i++){
       double compareValue = Cycles[i];
      bool isValue = IsCrossNum(closestValue, compareValue);
      Alert(compareValue+" is "+closestValue+"'s cross num ==> "+isValue);
   }
   
   //Debug::PrintArray(Cycles);
   
   
   ArrayCopy(values, Cycles, 0, 0, WHOLE_ARRAY);
}