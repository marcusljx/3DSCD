#include "util_pipeline.h"
#include "mex.h"

#ifdef WINDOWS
    typedef unsigned __int64 UInt64; 
#else
    typedef unsigned long long UInt64; 
#endif
    
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[] ) 
{
    // Create output array
    UInt64 *MXadress;
    mwSize Jdimsc[2]={1,1};
    plhs[0] = mxCreateNumericArray(2, Jdimsc, mxUINT64_CLASS, mxREAL);
    MXadress = (UInt64*)mxGetData(plhs[0]);

	UtilPipeline* utilPipelineP = new UtilPipeline();
    UtilPipeline& utilPipeline = utilPipelineP[0];
    
    int rgb_size[2]={640,480};
    if(nrhs>0)
    {
        if(mxGetNumberOfElements(prhs[0])==2)
        {
            double *rgb_sized = mxGetPr(prhs[0]);
            rgb_size[0]=(int)rgb_sized[0];
            rgb_size[1]=(int)rgb_sized[1];
        }
    }
    
    int depth_size[2]={320,240};
    if(nrhs>1)
    {


        if(mxGetNumberOfElements(prhs[1])==2)
        {
            double *depth_sized = mxGetPr(prhs[1]);
            depth_size[0]=(int)depth_sized[0];
            depth_size[1]=(int)depth_sized[1];
        }
    }
	
    // Set Depth smoothing on
    utilPipeline.QueryCapture()->SetFilter(PXCCapture::Device::PROPERTY_DEPTH_SMOOTHING,true);
	

    // Depth
    if(nrhs>1)
    {
        utilPipeline.EnableImage(PXCImage::COLOR_FORMAT_DEPTH,depth_size[0], depth_size[1]);
    }
    else
    {
        utilPipeline.EnableImage(PXCImage::COLOR_FORMAT_DEPTH);
    }
    
    // RGB
    if(nrhs>0)
    {
        utilPipeline.EnableImage(PXCImage::COLOR_FORMAT_RGB32,rgb_size[0], rgb_size[1]);
    }
    else
    {
        utilPipeline.EnableImage(PXCImage::COLOR_FORMAT_RGB32);
    }
    //void EnableGesture(pxcUID iuid=0);
    //void EnableGesture(pxcCHAR *name);


    // Init the Camera
    if (!utilPipeline.Init()) 
    {
		printf("Failed to initialize the pipeline with rgb and depth stream input \r\n");
        return;
	}
    else
    {
		printf("Succesfully initialized the pipeline with rgb and depth stream input \r\n");        
    }
    
    MXadress[0] = ( UInt64)&utilPipeline;
 
}

  

