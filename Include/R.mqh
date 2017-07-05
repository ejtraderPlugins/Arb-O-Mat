//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property strict 

#define MT4R_VERSION_MAJOR 1
#define MT4R_VERSION_MINOR 4

#define MT5R_VERSION_MAJOR 1
#define MT5R_VERSION_MINOR 4

#import "R64.dll"
int RGetDllVersion();
long RInit_(string commandline,int debuglevel);
void RDeinit(long rhandle);
bool RIsRunning(long rhandle);
bool RIsBusy(long rhandle);
void RExecuteAsync(long rhandle,string code);
void RExecute(long rhandle,string code);
void RAssignBool(long rhandle,string variable,bool value);
void RAssignInteger(long rhandle,string variable,int value);
void RAssignDouble(long rhandle,string variable,double value);
void RAssignString(long rhandle,string variable,string value);
void RAssignVector(long rhandle,string variable,double &vector[],int size);
void RAssignStringVector(long rhandle,string variable,string &vector[],int size);
void RAssignMatrix(long rhandle,string variable,double &matrix[],int rows,int cols);
void RAppendMatrixRow(long rhandle,string variable,double &vector[],int size);
bool RExists(long rhandle,string variable);
bool RGetBool(long rhandle,string expression);
int RGetInteger(long rhandle,string expression);
double RGetDouble(long rhandle,string expression);
int RGetVector(long rhandle,string expression,double &vector[],int size);
void RPrint(long rhandle,string expression);
//---
#import "R86.dll"
int RGetDllVersion();
long RInit_(string commandline,int debuglevel);
void RDeinit(long rhandle);
bool RIsRunning(long rhandle);
bool RIsBusy(long rhandle);
void RExecuteAsync(long rhandle,string code);
void RExecute(long rhandle,string code);
void RAssignBool(long rhandle,string variable,bool value);
void RAssignInteger(long rhandle,string variable,int value);
void RAssignDouble(long rhandle,string variable,double value);
void RAssignString(long rhandle,string variable,string value);
void RAssignVector(long rhandle,string variable,double &vector[],int size);
void RAssignStringVector(long rhandle,string variable,string &vector[],int size);
void RAssignMatrix(long rhandle,string variable,double &matrix[],int rows,int cols);
void RAppendMatrixRow(long rhandle,string variable,double &vector[],int size);
bool RExists(long rhandle,string variable);
bool RGetBool(long rhandle,string expression);
int RGetInteger(long rhandle,string expression);
double RGetDouble(long rhandle,string expression);
int RGetVector(long rhandle,string expression,double &vector[],int size);
void RPrint(long rhandle,string expression);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long RInit(string commandline,int debuglevel)
  {
   if(_IsX64)
     {
      int dll_version=R64::RGetDllVersion();
      if(dll_version==(MT5R_VERSION_MAJOR<<16)+MT5R_VERSION_MINOR)
        {
         return(R64::RInit_(commandline, debuglevel));
        }
      else
        {
         int dll_major = dll_version >> 16;
         int dll_minor = dll_version & 0xffff;
         PrintFormat("Version mismatch R64.dll: expected version %d.%d - found dll version %d.%d",MT5R_VERSION_MAJOR,MT5R_VERSION_MINOR,dll_major,dll_minor);
         return(0);
        }
     }
   else
     {
      int dll_version=R86::RGetDllVersion();
      if(dll_version==(MT4R_VERSION_MAJOR<<16)+MT4R_VERSION_MINOR)
        {
         return(R86::RInit_(commandline, debuglevel));
        }
      else
        {
         int dll_major = dll_version >> 16;
         int dll_minor = dll_version & 0xffff;
         PrintFormat("Version mismatch R86.dll: expected version %d.%d - found dll version %d.%d",MT5R_VERSION_MAJOR,MT5R_VERSION_MINOR,dll_major,dll_minor);
         return(0);
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int RGetDllVersion()
  {
   return(_IsX64?R64::RGetDllVersion():R86::RGetDllVersion());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long RInit_(string commandline,int debuglevel)
  {
   return(_IsX64?R64::RInit_(commandline,debuglevel):R86::RInit_(commandline,debuglevel));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RDeinit(long rhandle)
  {
   if(_IsX64)
      R64::RDeinit(rhandle);
   else
      R86::RDeinit(rhandle);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RIsRunning(long rhandle)
  {
   return(_IsX64?R64::RIsRunning(rhandle):R86::RIsRunning(rhandle));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RIsBusy(long rhandle)
  {
   return(_IsX64?R64::RIsBusy(rhandle):R86::RIsBusy(rhandle));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RExecuteAsync(long rhandle,string code)
  {
   if(_IsX64)
      R64::RExecuteAsync(rhandle,code);
   else
      R86::RExecuteAsync(rhandle,code);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RExecute(long rhandle,string code)
  {
   if(_IsX64)
      R64::RExecute(rhandle,code);
   else
      R86::RExecute(rhandle,code);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAssignBool(long rhandle,string variable,bool value)
  {
   if(_IsX64)
      R64::RAssignBool(rhandle,variable,value);
   else
      R86::RAssignBool(rhandle,variable,value);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAssignInteger(long rhandle,string variable,int value)
  {
   if(_IsX64)
      R64::RAssignInteger(rhandle,variable,value);
   else
      R86::RAssignInteger(rhandle,variable,value);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAssignDouble(long rhandle,string variable,double value)
  {
   if(_IsX64)
      R64::RAssignDouble(rhandle,variable,value);
   else
      R86::RAssignDouble(rhandle,variable,value);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAssignString(long rhandle,string variable,string value)
  {
   if(_IsX64)
      R64::RAssignString(rhandle,variable,value);
   else
      R86::RAssignString(rhandle,variable,value);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAssignVector(long rhandle,string variable,double &vector[],int size)
  {
   if(_IsX64)
      R64::RAssignVector(rhandle,variable,vector,size);
   else
      R86::RAssignVector(rhandle,variable,vector,size);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAssignStringVector(long rhandle,string variable,string &vector[],int size)
  {
   if(_IsX64)
      R64::RAssignStringVector(rhandle,variable,vector,size);
   else
      R86::RAssignStringVector(rhandle,variable,vector,size);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAssignMatrix(long rhandle,string variable,double &matrix[],int rows,int cols)
  {
   if(_IsX64)
      R64::RAssignMatrix(rhandle,variable,matrix,rows,cols);
   else
      R86::RAssignMatrix(rhandle,variable,matrix,rows,cols);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RAppendMatrixRow(long rhandle,string variable,double &vector[],int size)
  {
   if(_IsX64)
      R64::RAppendMatrixRow(rhandle,variable,vector,size);
   else
      R86::RAppendMatrixRow(rhandle,variable,vector,size);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RExists(long rhandle,string variable)
  {
   return(_IsX64?R64::RExists(rhandle,variable):R86::RExists(rhandle,variable));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RGetBool(long rhandle,string expression)
  {
   return(_IsX64?R64::RGetBool(rhandle,expression):R86::RGetBool(rhandle,expression));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int RGetInteger(long rhandle,string expression)
  {
   return(_IsX64?R64::RGetInteger(rhandle,expression):R86::RGetInteger(rhandle,expression));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RGetDouble(long rhandle,string expression)
  {
   return(_IsX64?R64::RGetDouble(rhandle,expression):R86::RGetDouble(rhandle,expression));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int RGetVector(long rhandle,string expression,double &vector[],int size)
  {
   return(_IsX64?R64::RGetVector(rhandle,expression,vector,size):R86::RGetVector(rhandle,expression,vector,size));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RPrint(long rhandle,string expression)
  {
   if(_IsX64)
      R64::RPrint(rhandle,expression);
   else
      R86::RPrint(rhandle,expression);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long StartR(string path,int debug=1)
  {
   return(::RInit(path,debug));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void StopR(long rhandle)
  {
   if(_IsX64)
      R64::RDeinit(rhandle);
   else
      R86::RDeinit(rhandle);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rx(long rhandle,string code)
  {
   ::RExecute(rhandle,code);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rs(long rhandle,string var,string s)
  {
   ::RAssignString(rhandle,var,s);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Ri(long rhandle,string var,int i)
  {
   ::RAssignInteger(rhandle,var,i);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rd(long rhandle,string var,double d)
  {
   ::RAssignDouble(rhandle,var,d);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rv(long rhandle,string var,double &v[])
  {
   ::RAssignVector(rhandle,var,v,ArraySize(v));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rf(long rhandle,string name,string &factor[])
  {
   ::RAssignStringVector(rhandle,name,factor,ArraySize(factor));
   ::Rx(rhandle,name+" <- as.factor("+name+")");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rm(long rhandle,string var,double &matrix[],int rows,int cols)
  {
   ::RAssignMatrix(rhandle,var,matrix,rows,cols);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Rgi(long rhandle,string var)
  {
   return(::RGetInteger(rhandle, var));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Rgd(long rhandle,string var)
  {
   return(::RGetDouble(rhandle, var));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rgv(long rhandle,string var,double &v[])
  {
   ::RGetVector(rhandle,var,v,ArraySize(v));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Rp(long rhandle,string expression)
  {
   ::RPrint(rhandle,expression);
  }
//+------------------------------------------------------------------+
