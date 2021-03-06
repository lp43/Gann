//+------------------------------------------------------------------+
//|                                                         Time.mqh |
//|                                                            Simon |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Simon"
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+

enum ENUM_YEAR
{
   YEAR_2016 = 2016,
   YEAR_2017 = 2017,
   YEAR_2018 = 2018
};

enum ENUM_MONTH
{
   MONTH_1 = 1,
   MONTH_2 = 2,
   MONTH_3 = 3,
   MONTH_4 = 4,
   MONTH_5 = 5,
   MONTH_6 = 6,
   MONTH_7 = 7,
   MONTH_8 = 8,
   MONTH_9 = 9,
   MONTH_10 = 10,
   MONTH_11 = 11,
   MONTH_12 = 12
};

enum ENUM_DAY
{
   DAY_1 = 1,
   DAY_2 = 2,
   DAY_3 = 3,
   DAY_4 = 4,
   DAY_5 = 5,
   DAY_6 = 6,
   DAY_7 = 7,
   DAY_8 = 8,
   DAY_9 = 9,
   DAY_10 = 10,
   DAY_11 = 11,
   DAY_12 = 12,
   DAY_13 = 13,
   DAY_14 = 14,
   DAY_15 = 15,
   DAY_16 = 16,
   DAY_17 = 17,
   DAY_18 = 18,
   DAY_19 = 19,
   DAY_20 = 20,
   DAY_21 = 21,
   DAY_22 = 22,
   DAY_23 = 23,
   DAY_24 = 24,
   DAY_25 = 25,
   DAY_26 = 26,
   DAY_27 = 27,
   DAY_28 = 28,
   DAY_29 = 29,
   DAY_30 = 30,
   DAY_31 = 31
};

enum ENUM_HOUR
{
   HOUR_0 = 0,
   HOUR_1 = 1,
   HOUR_2 = 2,
   HOUR_3 = 3,
   HOUR_4 = 4,
   HOUR_5 = 5,
   HOUR_6 = 6,
   HOUR_7 = 7,
   HOUR_8 = 8,
   HOUR_9 = 9,
   HOUR_10 = 10,
   HOUR_11 = 11,
   HOUR_12 = 12,
   HOUR_13 = 13,
   HOUR_14 = 14,
   HOUR_15 = 15,
   HOUR_16 = 16,
   HOUR_17 = 17,
   HOUR_18 = 18,
   HOUR_19 = 19,
   HOUR_20 = 20,
   HOUR_21 = 21,
   HOUR_22 = 22,
   HOUR_23 = 23
};

enum ENUM_MIN
{
   MIN_0 = 0,
   MIN_1 = 1,
   MIN_2 = 2,
   MIN_3 = 3,
   MIN_4 = 4,
   MIN_5 = 5,
   MIN_6 = 6,
   MIN_7 = 7,
   MIN_8 = 8,
   MIN_9 = 9,
   MIN_10 = 10,
   MIN_11 = 11,
   MIN_12 = 12,
   MIN_13 = 13,
   MIN_14 = 14,
   MIN_15 = 15,
   MIN_16 = 16,
   MIN_17 = 17,
   MIN_18 = 18,
   MIN_19 = 19,
   MIN_20 = 20,
   MIN_21 = 21,
   MIN_22 = 22,
   MIN_23 = 23,
   MIN_24 = 24,
   MIN_25 = 25,
   MIN_26 = 26,
   MIN_27 = 27,
   MIN_28 = 28,
   MIN_29 = 29,
   MIN_30 = 30,
   MIN_31 = 31,
   MIN_32 = 32,
   MIN_33 = 33,
   MIN_34 = 34,
   MIN_35 = 35,
   MIN_36 = 36,
   MIN_37 = 37,
   MIN_38 = 38,
   MIN_39 = 39,
   MIN_40 = 40,
   MIN_41 = 41,
   MIN_42 = 42,
   MIN_43 = 43,
   MIN_44 = 44,
   MIN_45 = 45,
   MIN_46 = 46,
   MIN_47 = 47,
   MIN_48 = 48,
   MIN_49 = 49,
   MIN_50 = 50,
   MIN_51 = 51,
   MIN_52 = 52,
   MIN_53 = 53,
   MIN_54 = 54,
   MIN_55 = 55,
   MIN_56 = 56,
   MIN_57 = 57,
   MIN_58 = 58,
   MIN_59 = 59
};