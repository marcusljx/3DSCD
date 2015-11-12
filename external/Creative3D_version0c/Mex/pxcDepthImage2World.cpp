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
    if(nrhs<2)
    {
        printf("Close failed: Give Pointer to intel camera, and depth image as input\n");
        mexErrMsgTxt("Intel camera error"); 
    }
    MXadress = (UInt64*)mxGetData(prhs[0]);
    
    if(MXadress[0]==0)
    { 
        return;
    }

	unsigned short* D = (unsigned short*)mxGetData(prhs[1]);
	const mwSize *dims;
	dims = mxGetDimensions(prhs[1]);

    UtilPipeline* utilPipelineP = (UtilPipeline*)MXadress[0];
    UtilPipeline& utilPipeline = utilPipelineP[0];
  	
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
		
	pxcU32 npoints = (pxcU32)dims[0]*(pxcU32)dims[1];
	PXCPoint3DF32 *pos2d = new PXCPoint3DF32[npoints];
	PXCPoint3DF32 *pos3d = new PXCPoint3DF32[npoints];

	int i=0;
    for (int y=0;y<dims[1];y++)
    {
        for (int x=0;x<dims[0];x++)
        {
            pos2d[i].x=(pxcF32)x, 
            pos2d[i].y=(pxcF32)y;
            pos2d[i].z=(pxcF32)D[i];
            i++;
        }
    }

	projection->ProjectImageToRealWorld(npoints,pos2d,pos3d);
    
	//projection->Release();


    mwSize dimsF[3];
	dimsF[0]=3;
	dimsF[1]=dims[0];
    dimsF[2]=dims[1];
    
    plhs[0] = mxCreateNumericArray(3, dimsF, mxSINGLE_CLASS, mxREAL);
    float* Dout = (float*)mxGetData(plhs[0]);
    memcpy (Dout,pos3d, dimsF[0]*dimsF[1]*dimsF[2]*sizeof(float));  
	
	delete(pos2d);
	delete(pos3d);
}

  

