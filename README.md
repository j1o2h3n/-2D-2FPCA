# (2D)^2FPCA
Matlab realization of finger vein recognition algorithm based on (2D)^2FPCA

## About (2D)^2FPCA

Two-way Two-Dimensional Fisher Principal Component Analysis ((2D)^2FPCA) is an improved version of dimensionality reduction algorithm in machine learning.
By combining PCA and FLD algorithms, the purpose of dimensionality reduction is achieved.

<p align="center">
  <img width="447" height="173" src=./picture/pca-fld.png>
</p>

## Question

The (2D)^2FPCA algorithm is used to complete the dimensionality reduction of finger vein images, and to classify and recognize the images.

<p align="center">
  <img width="120" height="240" src=./picture/finger_vein.bmp>
</p>

## Algorithm

First use 2DPCA in the column direction for the picture, and then use 2DFLD in the row direction.

The following schematic diagram.

<p align="center">
  <img width="558" height="245" src=./picture/(2D)2FPCA.png>
</p>

The algorithm training process is as follows:

<p align="left">
  <img width="403" height="298" src=./picture/train.png>
</p>

The algorithm test process is as follows:

<p align="left">
  <img width="392" height="202" src=./picture/test.png>
</p>


## Algorithm implementation

The algorithm program is written in Matlab language and runs the (2D)^2FPCA.m file. 

Note: You need to modify the dataset reading position in the code.


## References

[1] 余成波, 秦华锋. 生物特征识别技术:手指静脉识别技术[M]. 清华大学出版社, 2009.

[2] Wang J, Li H, Wang G, et al. Vein recognition based on (2D)2FPCA[J]. International Journal of Signal Processing, Image Processing and Pattern Recognition, 2013, 6(4): 323-332.
