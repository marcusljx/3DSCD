#include "util_pipeline.h"
#include "pxcmetadata.h"
#include "pxcprojection.h"
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
    
    PXCImage *rgbImage = utilPipeline.QueryImage(PXCImage::IMAGE_TYPE_COLOR);
 
    PXCImage::ImageData rgbImageData;
    rgbImage->AcquireAccess(PXCImage::ACCESS_READ,&rgbImageData);

	  
    //if(depthImageData.format != PXCImage::COLOR_FORMAT_DEPTH)
    //{
    //    mexErrMsgTxt("COLOR_FORMAT_DEPTH error"); 
    //}

	if(rgbImageData.type != PXCImage::SURFACE_TYPE_SYSTEM_MEMORY)
    {
        mexErrMsgTxt("SURFACE_TYPE_SYSTEM_MEMORY error"); 
    }

	
    PXCImage::ImageInfo rgbInfo;
    rgbImage->QueryInfo(&rgbInfo);
    printf("RGB Image :  Width %d, Height %d \r\n",rgbInfo.width,rgbInfo.height); 

    mwSize dimsRGB[3];
    dimsRGB[0]=3;
    dimsRGB[1]=rgbInfo.width;
    dimsRGB[2]=rgbInfo.height;

    unsigned char *Iout;
    plhs[0] = mxCreateNumericArray(3, dimsRGB, mxUINT8_CLASS, mxREAL);
    Iout = (unsigned char*)mxGetData(plhs[0]);
    memcpy (Iout,rgbImageData.planes[0],dimsRGB[0]*dimsRGB[1]*dimsRGB[2]);  
  
    rgbImage->ReleaseAccess(&rgbImageData);


	
    if(nlhs>1)
    {
		UtilCapture *capture = utilPipeline.QueryCapture();
		if(!capture)
		{
			 printf("No valid capture object\n");
			 return;
		}
		
		PXCCapture::Device *device = capture->QueryDevice();
		if(!device)
		{
			 printf("No valid device object\n");
			 return;
		}

		// Get Camera Projection Data
		PXCSession *session = utilPipeline.QuerySession();
		pxcUID pid;
		device->QueryPropertyAsUID(PXCCapture::Device::PROPERTY_PROJECTION_SERIALIZABLE,&pid);
		PXCSmartPtr<PXCProjection> projection;
		PXCMetadata *metadata = session->DynamicCast<PXCMetadata>();
		metadata->CreateSerializable<PXCProjection>( pid, &projection );
		if(!projection)
		{
			 printf("No valid projection data\n");
			 return;
		}

		pxcU32 npoints = (pxcU32) dimsRGB[1]*(pxcU32)dimsRGB[2];
		
		PXCPointF32 *posc = new PXCPointF32[npoints];
		PXCPointF32 *posd = new PXCPointF32[npoints];
				
		int i=0;
		for (int y=0;y< dimsRGB[2];y++)
		{
			for (int x=0;x< dimsRGB[1];x++)
			{
				posc[i].x=(pxcF32)x, 
				posc[i].y=(pxcF32)y;
				i++;
			}
		}

		projection->MapColorCoordinatesToDepth(npoints,posc,posd);

		//projection->Release();
	
		mwSize dimsM[3];
		dimsM[0]=2;
		dimsM[1]=dimsRGB[1];
		dimsM[2]=dimsRGB[2];
        plhs[1] = mxCreateNumericArray(3, dimsM, mxSINGLE_CLASS, mxREAL);
        float* Mout = (float*)mxGetData(plhs[1]);
        memcpy (Mout,posd,dimsM[0]*dimsM[1]*dimsM[2]*sizeof(float));  
        
        delete(posc);
        delete(posd);
    }
}

  

