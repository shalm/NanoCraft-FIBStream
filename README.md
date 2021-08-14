# NanoCraft-FIBStream
Generate a stream file for milling nanostructures (e.g. rectangular and circular nanohole arrays, v-groove slots ) by using focused ion beam (e.g. FEI Nova 200).

# Abstract
Nanophotonics has experienced a tremendous growth in the past decade largely due to the development of nanofabrication techniques, such as electron-beam lithography (EBL), reactive ion etching (RIE), and focused ion beam (FIB) milling. Specifically this tool "NanoCraft-FIBstream" is designed to automate the FIB process. In brief FIB technique can be described in the following way: a tight beam of accelerated ions impinges on a sample surface and removes locally parts of the sample material, i.e. ion beam drills nanoscale holes with a typical diameter of 10-50 nm in the sample. Many nanostructures used in experiments can be viewed as a set of these holes with specific in-plane coordinates and depth. Therefore, in order to fabricate a particular nanostructure, it is sufficient to specify the set of holes to be milled together with their parameters. Instead of typing these parameters manually for each hole, the list of parameters for all the holes can be generated automatically given the final nanostructure geometry. We have developed a Matlab-based tool that can automatically generate a list of parameters, so-called STREAM file, which can be directly uploaded to the control software ($to be specified$) of the FIB setup (FEI Nova 200). Current capabilities of the tool include generation of STREAM files for arrays of circular nanoholes and sets of slot or v-groove shaped trenches.

# Powered by
The GUI of NanoCraft-FIBstream is developed using the Matlab GUIDE library. The main codes are written as Matlab scripts. The GUI and the scripts are then compiled.

# Credits
Ran Cui developed the Matlab code and GUI as well as tested the tool
Mikhail Shalaginov desinged and tested the tool
Alexander Kildishev supervised the project
