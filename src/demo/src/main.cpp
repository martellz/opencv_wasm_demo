#include <iostream>
#include <opencv2/core.hpp>
#include <emscripten/bind.h>


using namespace emscripten;

int main() {
    cv::Mat img1 = cv::Mat(4, 4, CV_8U, 100);
    cv::Mat img2 = cv::Mat(4, 4, CV_8U, 150);

    cv::Mat img3 = img2 - img1;
    for(int i = 0; i < 16; i++) {
        std::cout << int(img3.data[i]) << std::endl;
    }

    return 0;
}


EMSCRIPTEN_BINDINGS (c) {
    function("main", &main);
}
