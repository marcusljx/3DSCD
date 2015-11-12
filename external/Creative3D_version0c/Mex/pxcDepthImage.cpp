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

    PXCImage *depthImage = utilPipeline.QueryImage(PXCImage::IMAGE_TYPE_DEPTH);
    
    PXCImage::ImageData depthImageData;
    depthImage->AcquireAccess(PXCImage::ACCESS_READ,&depthImageData);
    
    //if(depthImageData.format != PXCImage::COLOR_FORMAT_DEPTH)
    //{
    //    mexErrMsgTxt("COLOR_FORMAT_DEPTH error"); 
    //}

    if(depthImageData.type != PXCImage::SURFACE_TYPE_SYSTEM_MEMORY)
    {
        mexErrMsgTxt("SURFACE_TYPE_SYSTEM_MEMORY error"); 
    }

    PXCImage::ImageInfo depthInfo;
    depthImage->QueryInfo(&depthInfo);
    printf("Depth Image :  Width %d, Height %d \r\n",depthInfo.width,depthInfo.height); 

    mwSize dimsDepth[2];
    dimsDepth[0]=depthInfo.width;
    dimsDepth[1]=depthInfo.height;
    unsigned short *Iout;
    plhs[0] = mxCreateNumericArray(2, dimsDepth, mxUINT16_CLASS, mxREAL);
    Iout = (unsigned short*)mxGetData(plhs[0]);
    memcpy (Iout,depthImageData.planes[0],dimsDepth[0]*dimsDepth[1]*sizeof(unsigned short));  

    if(nlhs>1)
    {
        unsigned short *Cout;
        plhs[1] = mxCreateNumericArray(2, dimsDepth, mxUINT16_CLASS, mxREAL);
        Cout = (unsigned short*)mxGetData(plhs[1]);
        memcpy (Cout,depthImageData.planes[1],dimsDepth[0]*dimsDepth[1]*sizeof(unsigned short));  
    }
    	
    if(nlhs>2)
    {
		mwSize dimsF[3];
		dimsF[0]=2;
		dimsF[1]=depthInfo.width;
		dimsF[2]=depthInfo.height;
	
        float *Dout;
        plhs[2] = mxCreateNumericArray(3, dimsF, mxSINGLE_CLASS, mxREAL);
        Dout = (float*)mxGetData(plhs[2]);
        memcpy (Dout,depthImageData.planes[2],dimsF[0]*dimsF[1]*dimsF[2]*sizeof(float));  
    }
	
    depthImage->ReleaseAccess(&depthImageData);
}

  

