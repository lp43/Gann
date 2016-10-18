//+------------------------------------------------------------------+
//|                                                   FourAngles.mqh |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include "Gann.mqh"

int mRunType;
double mBeginValue;
double mStep;
int mParts;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FourAngles : public Gann
  {
private:

public:
                     FourAngles();
                    ~FourAngles();
                    virtual void Run(GannValue* &values[]);
                    void SetDatas(int run_type, double begin_value, double step, double parts);
  
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
FourAngles::FourAngles()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
FourAngles::~FourAngles()
  {
  }
  

//+------------------------------------------------------------------+
void FourAngles::SetDatas(int run_type, double begin_value, double step, double parts){
   mRunType = run_type;
   mBeginValue = begin_value;
   mStep = step;
   mParts = parts;
}
void FourAngles::Run(GannValue* &values[]){
   GannValue* temp[];
   
   double Null[];
   double ComputeingValue = mBeginValue;
   for(int i =0; i < mParts; i++){
       int PartNow = i+1; // 第幾段
       
       // ========左側90度角========
       double angle = RunAngle(mRunType, ComputeingValue, Null); 
       int size_temp1 = ArraySize(temp);
       ArrayResize(temp, ++size_temp1);
       GannValue* cons1 = new GannValue();
       cons1.part = PartNow;
       cons1.value = angle;
       temp[size_temp1-1]=cons1;
       
       // ========右側180度角========
       int run_cross_type=NULL;
       if(mRunType==RUN_HIGH){
         run_cross_type = RUN_LOW;
       }else{
         run_cross_type = RUN_HIGH;
       }
       double cross = RunCross(run_cross_type, angle, mStep, Null);
       int size_temp2 = ArraySize(temp);
       ArrayResize(temp, ++size_temp2);
       GannValue* cons2 = new GannValue();
       cons2.part = PartNow;
       cons2.value = cross;
       temp[size_temp2-1]=cons2;
       
       ComputeingValue = angle;
   }
  
   Debug::PrintArray("FourAngles", temp);
   ArrayCopy(values, temp, 0, 0, WHOLE_ARRAY);
   ArrayFree(temp);
}