IISc Thesis Folder Structure:
1. Each section (Introduction, Experimental Details, etc..) are inside the "Chapters" folder.
2. Images are inside their corresponding folders (like Tensile Test, Texture, etc..). This structure is
   used to facilitate other users to go through the folder structure with ease.
3. The "Image" folder in each directory (like Tensile Test, Texture, etc..) consists only of images that go
   into the thesis or paper. The original images are kept in their respective folders.


Faster Rendering of LaTeX:
1. Use graphics extension after every image file added (or) use \DeclareGraphicsExtensions{.jpg,.eps,.png}. The first extension will be searched first.

Photos (Folder) Contains:
Photos of samples with a reference scale.
Photos of machines.

Microstructure (Folder) Contains:
Optical Micrscopy
SEM
TEM

Measure Compilation Time:
time pdflatex myfile.tex
