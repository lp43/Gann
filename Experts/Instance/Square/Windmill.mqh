//+------------------------------------------------------------------+
//|                                                     Windmill.mqh |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "Gann.mqh"
#include "Square.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Windmill : public Gann
  {
private:
                     void InsertBladeDegree();
                     double mCompareNum, mBaseNum;
public:
                     Windmill();
                    ~Windmill();
                    void SetValues(double compare_num , double base_num);
                    virtual void Run(GannValue* &values[]);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double mCompareNum = 0;
double mBaseNum = 0;
Windmill::Windmill()
  {
  
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Windmill::~Windmill()
  {
  }

//+------------------------------------------------------------------+
void Windmill::SetValues(double compare_num,double base_num){
   mCompareNum = compare_num;
   mBaseNum = base_num;
}

void Windmill::Run(GannValue* &values[]){
     int BasePosition[2];
     cursor.GetPositionByValue(mBaseNum, BasePosition);
     int ComparePosition[2];
     cursor.GetPositionByValue(mCompareNum, ComparePosition);
     
     //int angledegree = IsWindmillAngleNum(compare_num, base_num);
     //int angledegree = MyAngle::GetAngleDegree(ComparePosition, BasePosition);
     //Alert("angledegree: "+angledegree);
     
    InsertBladeDegree();
    
}

 void Windmill::InsertBladeDegree(){
   CursorValue* crArray[];
   cursor.GetSquareArray(crArray);
   int size_crArray = ArraySize(crArray);
   //Alert("size_crArray: "+size_crArray);
   
   double CenterValue = cursor.GetValueByIdx(cursor.GetCenterIdx());
   Alert("CenterValue: "+CenterValue);
   
   // ============處理十字線============
   double CrossNums[];
   GetCrossNums(RUN_BOTH, CenterValue,CrossNums);
   //Debug::PrintArray("CenterValue "+CenterValue+"'s crossnums",CrossNums, 0);
   
   // ============處理角線============
   double AngleNums[];
   GetAngleNums(RUN_BOTH, CenterValue,AngleNums);
   //Debug::PrintArray("CenterValue "+CenterValue+"'s anglenums",AngleNums, 0);
   for(int i = 0 ; i <ArraySize(AngleNums);i++){
      double value = AngleNums[i];
      int circlenum = cursor.GetCircleNumByValue(value);
      int bladeRange = circlenum%2==0?(circlenum/2)-1:((circlenum+1)/2)-1;
      int BasePosition[2];
      cursor.GetPositionByIdx(cursor.GetCenterIdx(), BasePosition);
      //Debug::PrintPosition(cursor,BasePosition);
      int ComparePosition[2];
      cursor.GetPositionByValue(value, ComparePosition);
      //Debug::PrintPosition(cursor,ComparePosition);
      int degree = MyAngle::GetDegree(ComparePosition,BasePosition);
      CursorValue* crValue = cursor.GetCursorValueByValue(value);
      crValue.blade_degree = degree;
      //Alert(value+"'s circle num is: "+circlenum+", BladeRange is: "+bladeRange+", degree is: "+degree);
      switch(degree){
         case ANGLE_45:{
            //---往下處理X---
            cursor.SetCursorTo(ComparePosition);
            //Alert("set cursor to value: "+DoubleToStr(value, 0)+" ==>");
            //Debug::PrintPosition(cursor,ComparePosition);
            for(int i = 0; i < bladeRange;i++){
               cursor.Down();
               CursorValue* crValue = cursor.GetCursorValue();
               crValue.blade_degree = degree;
               //Alert("down value is: "+crValue.value);
            }
            //---往右處理Y---
            cursor.SetCursorTo(ComparePosition);
            //Alert("set cursor to value: "+DoubleToStr(value, 0)+" ==>");
            //Debug::PrintPosition(cursor,ComparePosition);
            for(int i = 0; i < bladeRange;i++){
               cursor.Right();
               CursorValue* crValue = cursor.GetCursorValue();
               crValue.blade_degree = degree;
               //Alert("Right value is: "+crValue.value);
            }
            break;
         }
         case ANGLE_135:{
         break;
         }
         case ANGLE_225:{
         break;
         }
         case ANGLE_315:{
         break;
         }
      }
    
    }
    Debug::PrintArray("Blade Info: ",cursor);
 }
