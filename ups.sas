/* Generated Code (IMPORT) */
/* Source File: Fall 2024 Lab #3 Closing Prices.xlsx */
/* Source Path: /home/u63987812/sasuser.v94/Lab 3 */
/* Code generated on: 11/21/24, 9:18 PM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u63987812/sasuser.v94/Lab 3/Fall 2024 Lab #3 Closing Prices.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.ups;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.ups; RUN;


%web_open_table(WORK.IMPORT);

proc print data=ups; run;


/* EDA */
/* HISTOGRAMS */
/* 8 variables */	
/* (Howmet Aerospace (HWM) , RTX Corporation (RTX) , Cintas (CTAS) , Lockheed Martin (LMT) ,
3M (MMM) , Rockwell Automation (ROK) , Veralto (VLTO) , Verisk Analytics (VRSK)) */	
/* histogram Howmet Aerospace */
proc sgplot data=ups;
	histogram HWM;
	TITLE "Histogram of Howmet Aerospace";
	run;
	
/* histogram RTX Corporation */
proc sgplot data=ups;
	histogram RTX;
	TITLE "Histogram of RTX Corporation";
	run;

/* histogram Cintas */
proc sgplot data=ups;
	histogram CTAS;
	TITLE "Histogram of Cintas";
	run;

/* histogram Lockheed Martin */
proc sgplot data=ups;
	histogram LMT;
	TITLE "Histogram of Lockheed Martin";
	run;

/* histogram 3M */
proc sgplot data=ups;
	histogram MMM;
	TITLE "Histogram of 3M";
	run;

/* histogram Rockwell Automation */
proc sgplot data=ups;
	histogram ROK;
	TITLE "Histogram of Rockwell Automation";
	run;
	
/* histogram Veralto */
proc sgplot data=ups;
	histogram VLTO;
	TITLE "Histogram of Veralto";
	run;

/* histogram Verisk Analytics */
proc sgplot data=ups;
	histogram VRSK;
	TITLE "Histogram of Verisk Analytics";
	run;	
	
/* histogram United Parcel Service */
proc sgplot data=ups;
	histogram UPS;
	TITLE "Histogram of United Parcel Service";
	run;	
		

/* PROC CORR */
proc corr data=ups; 
var _numeric_; 
with ups;
	run;
	
/* variables most strongly associated ups based on correlation coefficients:
highest proc corr outputs:
Howmet Aerospace (HWM): -0.80339
RTX Corporation (RTX): -0.81707
Cintas (CTAS): -0.77796
Lockheed Martin (LMT): -0.75456
3M (MMM): -0.77309
Rockwell Automation (ROK): 0.79696
Veralto (VLTO): -0.78342
Verisk Analytics (VRSK): -0.75028
*/

/* PROC CORR */
/* scatterplots */
/* (Howmet Aerospace (HWM) , RTX Corporation (RTX) , Cintas (CTAS) , Lockheed Martin (LMT) ,
3M (MMM) , Rockwell Automation (ROK) , Veralto (VLTO) , Verisk Analytics (VRSK)) */

/* ups vs Howmet Aerospace scatterplot */
proc sgplot data=ups;
    scatter x=ups y=hwm;
    title "Scatter Plot of UPS vs. Howmet Aerospace";
    xaxis label="UPS";
    yaxis label="HWM";
	run;

/* ups vs RTX Corporation scatterplot */
proc sgplot data=ups;
    scatter x=ups y=rtx;
    title "Scatter Plot of UPS vs. RTX Corporation";
    xaxis label="UPS";
    yaxis label="RTX";
	run;

/* ups vs Cintas scatterplot */
proc sgplot data=ups;
    scatter x=ups y=ctas;
    title "Scatter Plot of UPS vs. Cintas";
    xaxis label="UPS";
    yaxis label="CTAS";
	run;

/* ups vs Lockheed Martin scatterplot */
proc sgplot data=ups;
    scatter x=ups y=lmt;
    title "Scatter Plot of UPS vs. Lockheed Martin";
    xaxis label="UPS";
    yaxis label="LMT";
	run;

/* ups vs 3M scatterplot */
proc sgplot data=ups;
    scatter x=ups y=mmm;
    title "Scatter Plot of UPS vs. 3M";
    xaxis label="UPS";
    yaxis label="MMM";
	run;

/* ups vs Rockwell Automation scatterplot */
proc sgplot data=ups;
    scatter x=ups y=rok;
    title "Scatter Plot of UPS vs. Rockwell Automation";
    xaxis label="UPS";
    yaxis label="ROK";
	run;
	
/* ups vs Veralto scatterplot */
proc sgplot data=ups;
    scatter x=ups y=vlto;
    title "Scatter Plot of UPS vs. Veralto";
    xaxis label="UPS";
    yaxis label="VLTO";
	run;
	
/* ups vs Verisk Analytics scatterplot */
proc sgplot data=ups;
    scatter x=ups y=vrsk;
    title "Scatter Plot of UPS vs. Verisk Analytics";
    xaxis label="UPS";
    yaxis label="VRSK";
	run;

/* (Howmet Aerospace (HWM) , RTX Corporation (RTX) , Cintas (CTAS) , Lockheed Martin (LMT) ,
3M (MMM) , Rockwell Automation (ROK) , Veralto (VLTO) , Verisk Analytics (VRSK)) */	
	
/* stepwise */
proc reg data=ups;
	model ups = hwm rtx ctas lmt mmm rok vlto vrsk/selection = stepwise slentry = .05;
	run;

/* variables remaining after stepwise:
 1 RTX Corporation (RTX) 
 2 Rockwell Automation (ROK)
 3 Verisk Analytics (VRSK)
 4 Howmet Aerospace (HWM)
 5 Lockheed Martin (LMT)
 6 Veralto (VLTO)

variables removed: 3M (MMM) Cintas (CTAS) */	

/* RTX Corporation (RTX), Rockwell Automation (ROK), Verisk Analytics (VRSK), 
Howmet Aerospace (HWM), Lockheed Martin (LMT), Veralto (VLTO), 3M (MMM) */

/*other 4 selection criteria methods:
r-square,adjusted r-square,cp,press*/

/* r-square criterion */
proc reg data=ups;
model ups = rtx rok vrsk hwm lmt vlto mmm/ selection=rsquare start=3 best=2;
run;
/* starts looking at 3-var models; */
/* best gives best # var models; */

/* adjusted r-square criterion; */
proc reg data = ups;
model ups = rtx rok vrsk hwm lmt vlto mmm/ selection=adjrsq;
run;

/* cp criterion (lowest is best) ; */
proc reg data = ups;
model ups = rtx rok vrsk hwm lmt vlto mmm/ selection=cp;
run;

/* press criterion, also gives press statistici */
proc glmselect data=ups;
model ups = rtx rok vrsk hwm lmt vlto mmm/ selection=stepwise (choose=press) ;
run;

/* gives graphs, easiest way to compare models */
proc glmselect data=ups plots=criterionpanel;
model ups = rtx rok vrsk hwm lmt vlto mmm/ selection=stepwise stats=all;
run;

/* final model from stepwise:
6 variables: RTX, ROK, VRSK, HWM, LMT, VLTO */
proc reg data = ups;
	model ups = rtx rok vrsk hwm lmt vlto;
	run;


/* Test one interaction term and one quadratic term to determine if its significant in the model  */
/* interaction term model */
proc glm data=ups;
	model ups = rtx rok vrsk hwm lmt vlto vrsk*hwm / solution;
    store GLMMODEL;
run;

proc plm restore=GLMMODEL noinfo;
    effectplot slicefit(x=vrsk sliceby=hwm);
    title "Interaction Effect of VRSK and HWM on UPS";
run;

data ups2;
	set ups;
	vrsk_hwm=vrsk*hwm;
		
proc reg data=ups2;
	model ups = rtx rok vrsk hwm lmt vlto vrsk_hwm;
	run;


/* quadratic term model */
data ups3;
	set ups;
	rtx_2=rtx*rtx;
	
proc reg data=ups3;
	model ups = rtx rok vrsk hwm lmt vlto rtx_2;
	run;

	                                                                                                                                                                                                                                                                                                                                                                                                                  
/* Test for multicollinearity */
proc reg data = ups;
	model ups = rok vrsk lmt vlto / VIF;
	run;
/* Remove highest vif, HWM 37.23414.  */
/* Remove next highest, RTX 20.78550. */


/* The final independent variables should be regressed on the dependent variable */
/* best model: quadratic term model */
/* final proc reg */
proc reg data=ups3;
	model ups = rtx rok vrsk hwm lmt vlto rtx_2;
	run;
	





