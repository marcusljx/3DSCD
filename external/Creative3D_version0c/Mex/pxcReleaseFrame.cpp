#include "util_pipeline.h"
#include "mex.h"

#ifdef WINDOWS
    typedef unsigned __int64 UInt64; 
#else
    typedef unsigned long long UInt64; 
#endif

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] ) 
{
    UInt64 *MXadress;
    if(nrhs==0)
    {
        printf("Close failed: Give Pointer to intel camera as input\n");
        mexErrMsgTxt("Intel camera error"); 
    }
    MXadress = (UInt64*)mxGetData(prhs[0]);
    
    if(MXadress[0]==0)
    { 
        return;
    }
    
    UtilPipeline* utilPipelineP = (UtilPipeline*)MXadress[0];
    UtilPipeline& utilPipeline = utilPipelineP[0];
    
             
    utilPipeline.ReleaseFrame();
}

  

