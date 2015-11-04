#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <stdio.h>
using namespace cv;
int main(int argc, char *argv[])
{
//    Mat img = imread("lena.jpg", CV_LOAD_IMAGE_COLOR);
//    if(img.empty())
//       return -1;
//    namedWindow( "lena", CV_WINDOW_AUTOSIZE );
//    imshow("lena", img);

CvCapture* cam = NULL;
IplImage* frame = NULL;
IplImage* result = NULL;
Mat image;
CvFont font;
double hscale = 0.5;
double vscale = 0.5;
int linewidth = 2;
int keypress = -1;
int imageNum = 1;
char imageName[13];
char onScreen[10];
cam = cvCreateCameraCapture(0);
if(cam)
{
    cvNamedWindow("Capture",CV_WINDOW_FULLSCREEN);
    cvSetCaptureProperty(cam,CV_CAP_PROP_FPS,30);
}
cvInitFont(&font, CV_FONT_HERSHEY_SIMPLEX, hscale, vscale, 0, linewidth);
while(1)
{
    frame=cvQueryFrame(cam);
    if(!frame)
        break;
    result = cvCloneImage(frame);
    sprintf(onScreen,"%02i/10",imageNum);
    cvPutText(result,onScreen,cvPoint(0,20), &font, cvScalar(0,0,0));
    cvShowImage("Capture",result);
    keypress = cvWaitKey(20);
    if(keypress == 'c')
    {
        sprintf(imageName,"image%03i.jpg",imageNum++);
        image = cvarrToMat(frame);
        imwrite(&(imageName[0]),image);
    }
    else if(keypress == 'q')
        break;
}
    waitKey(0);
    return 0;
}



