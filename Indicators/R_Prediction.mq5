//+------------------------------------------------------------------+
//|                                                 R_Prediction.mq5 |
//+------------------------------------------------------------------+
#property copyright ""
#property link      "http://www.forexfactory.com/showthread.php?t=260422&page=10"
#property version   "1.00"
#property strict

#include <R.mqh>

#property indicator_chart_window

#property indicator_buffers 1
#property indicator_plots 1

#property indicator_type1  DRAW_LINE
#property indicator_color1 clrRed
#property indicator_label1 "Prediction"
#property indicator_width1 2

input string InpCommand="d:\\R\\R-3.3.2\\bin\\x64\\Rterm.exe";//Path to Rterm.exe
input int InpOrder=200;//Order
input int InpBack=500;//Back
input int InpAhead=20;//Ahead

double PredictBuffer[];
long R;
bool recalc;
const bool dll_allowed=MQLInfoInteger(MQL_DLLS_ALLOWED);
double hist[];
double pred[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   
   //--- chart offset
   if(!ChartGetInteger(0,CHART_SHIFT))
     {
      ChartSetDouble(0,CHART_SHIFT_SIZE,20);
      ChartSetInteger(0,CHART_SHIFT,true);
     }
   
   //---
   SetIndexBuffer(0,PredictBuffer);
   ArraySetAsSeries(PredictBuffer,true);

#ifdef __MQL4__   
   SetIndexShift(0,InpAhead);
#endif

#ifdef __MQL5__   
   PlotIndexSetInteger(0,PLOT_SHIFT,InpAhead);
#endif   

   IndicatorSetInteger(INDICATOR_DIGITS,_Digits);

//---   
   if(dll_allowed)
     {
      R=RInit(InpCommand+" --no-save",2);
      if(R==0)
         Comment("\nInvalid path: ",InpCommand);
      else
         Comment(StringFormat("\nHistory: %d bars, method: OLS, order: %d",InpBack,InpOrder));
     }
   else
      Comment("\nDLL calls are not allowed. Please switch on this option.");
//---
   ArrayResize(pred,InpAhead);
   ArrayResize(hist,InpBack);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(dll_allowed)
      RDeinit(R);
   Comment("");
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
   ArraySetAsSeries(close,true);

//--- no data in the history, exit
   if(rates_total<=InpBack)
      return(0);

   if(prev_calculated==0 || 
      rates_total-prev_calculated>0)
     {
      ArrayInitialize(PredictBuffer,EMPTY_VALUE);

      //--- set 'recalc' flag - need to make a new prediction
      recalc=true;
     }

   if(!recalc)
      return(rates_total);

   if(!dll_allowed)
      return(0);

//--- last RExecuteAsync() is still not finished, do nothing.
   if(RIsBusy(R))
      return(0);
//---
   if(RGetInteger(R,"as.integer(exists('model'))")==1)
     {
      // there exists a model (the variable is set).
      // This means a previously started RExecuteAsync() has finished.
      // we can now predict from this model and plot it.
      RAssignInteger(R,"ahead",InpAhead);
      RExecuteAsync(R,"pred <- predict(model, n.ahead=ahead)$pred");
      RGetVector(R,"rev(pred)",pred,InpAhead);

      for(int i=0; i<InpAhead; i++)
         PredictBuffer[i]=pred[i];

      //--- clear flag
      recalc=false;
     }

// make a (new) prediction

   for(int i=0; i<InpBack; i++)
      hist[i]=close[i];

   RAssignVector(R,"hist",hist,ArraySize(hist));
   RExecute(R,"hist <- rev(hist)");
   RAssignInteger(R,"ord",InpOrder);
   RExecuteAsync(R,"model <- ar(hist, aic=FALSE, order=ord, method='ols')");

//---
   return(rates_total);
  }
//+------------------------------------------------------------------+
