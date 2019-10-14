I have implemented 3 types of clustering algorithm. The codes for all the 3 are types run forever. 
Since I have used while loops, it is required to stop the execution by pausing.

A. Mobile WSN using kmean clustering
   (i). Run the file wsn_kmean.m. It just gives a basic simulation without any power calculations.

B.Mobile/Stationary WSN clustering based on LEACH algorithm
   (i). For Stationary WSN run the file startstationary.m after setting the variable algr to 'leach' 
   (ii). For Mobile WSN run the file startmobile.m after setting the variable algr to 'leach'
	These include energy calculations as well.   

C.Mobile/Stationary WSN clustering based on Fuzzy logic
   (i). For Stationary WSN run the file startstationary.m after setting the variable algr to 'fuzzyeval' 
   (ii). For Mobile WSN run the file startmobile.m after setting the variable algr to 'fuzzyeval'
	These include energy calculations as well. 

Note:
For the implementation of the LEACH algorithm I have used the code from mathworks.com website(https://www.mathworks.com/matlabcentral/fileexchange/48162-leach-low-energy-adaptive-clustering-hierarchy-protocol).
It works only for stationary WSN (for B (i)). I have modified the code to work for mobile WSN.
Further created several files for the implementation of Fuzzy Logic algorithm accordingly, extending the support to current code. 