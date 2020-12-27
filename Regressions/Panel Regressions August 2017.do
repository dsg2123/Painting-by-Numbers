*Diana Greenwald, 26-Aug-2017
// France Panel Regression August 2017

clear all //Clear Stata memory
version 14 //set the version of Stata to use
set more off, perm //Stata will run through all of your results. Run is to execute "quietly"

cd //*CHANGE FILE PATH AS NEEDED*
use "Departmental Data August 2017.dta"




//NOTES//
*Remove pctag_int_scale to recreate regression without agricultural employment


//Generate Scaled Variables//

gen major_neigh = (major + neigh)

gen pct_rural = (rural_genre_location/Total)
gen pct_landscapes = (landscapes/Total)
gen touri_scale = (touri/10000)
gen colonies_scale = (colonies/10000)
gen major_neigh_scale = (major_neigh/10000)
gen pctag_int_scale = (pctag_int/10000)
gen labor_active_scale = (labor_active/10000)
gen avg_price_scale = (avg_paris_price_int/10000)

//Make Panel//

xtset dptid year 


//Remove Paris//

drop if department == "SEINE"

//LANDSCAPES SHARES//


//General Regression//
reg pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale
eststo r101

//General Regression plus Year Dummies//
reg pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r102

//Fixed-Effects Regression//
xtreg pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale, i(dptid) fe vce(robust)
eststo r103

//Fixed-Effects Regression with Year Dummies//
xtreg pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust)
eststo r104

estout r101 r102 r103 r104, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))


/*
//Run ALL Again with Lags//

//General Regression//
reg pct_landscapes l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale 
eststo r201

//General Regression plus Year Dummies//
reg pct_landscapes l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r202

//Fixed-Effects Regression//
xtreg pct_landscapes l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale, i(dptid) fe vce(robust)
eststo r203

//Fixed-Effects Regression with Year Dummies//
xtreg pct_landscapes l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust) 
eststo r204

estout r201 r202 r203 r204, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))


//RURAL 1831 - 1881 SHARES//

//General Regression//
reg pct_rural colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale 
eststo r301

//General Regression plus Year Dummies//
reg pct_rural colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r302

//Fixed-Effects Regression//
xtreg pct_rural colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale, i(dptid) fe vce(robust)
eststo r303

//Fixed-Effects Regression with Year Dummies//
xtreg pct_rural colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale  y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust) 
eststo r304


estout r301 r302 r303 r304, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))


//Rerun all with lags//

//General Regression//
reg pct_rural l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale 
eststo r401

//General Regression plus Year Dummies//
reg pct_rural l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r402

//Fixed-Effects Regression//
xtreg pct_rural l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale, i(dptid) fe vce(robust)
eststo r403

//Fixed-Effects Regression with Year Dummies//
xtreg pct_rural l2.colonies_scale l2.avg_price_scale l2.major_neigh_scale l2.touri_scale l2.labor_active_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust) 
eststo r404

estout r401 r402 r403 r404, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))


//LANDSCAPES ABSOLUTE NUMBER//


//General Regression//
reg landscapes colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings 
eststo r501

//General Regression plus Year Dummies//
reg landscapes colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r502

//Fixed-Effects Regression//
xtreg landscapes colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings, i(dptid) fe vce(robust)
eststo r503

//Fixed-Effects Regression with Year Dummies//
xtreg landscapes colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust) 
eststo r504

estout r501 r502 r503 r504, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))


//Run ALL Again with Lags//

//General Regression//
reg landscapes l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings
eststo r601

//General Regression plus Year Dummies//
reg landscapes l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r602

//Fixed-Effects Regression//
xtreg landscapes l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings, i(dptid) fe vce(robust)
eststo r603

//Fixed-Effects Regression with Year Dummies//
xtreg landscapes l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust) 
eststo r604

estout r601 r602 r603 r604, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))




//RURAL GENRE ABSOLUTE NUMBER//

//General Regression//
reg rural_genre_location colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings
eststo r701

//General Regression plus Year Dummies//
reg rural_genre_location colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r702

//Fixed-Effects Regression//
xtreg rural_genre_location colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings, i(dptid) fe vce(robust)
eststo r703

//Fixed-Effects Regression with Year Dummies//
xtreg rural_genre_location colonies avg_paris_price_int major_neigh touri labor_active pctag_int total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust) 
eststo r704

estout r701 r702 r703 r704, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))


//Run ALL Again with Lags//

//General Regression//
reg rural_genre_location l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings
eststo r801

//General Regression plus Year Dummies//
reg rural_genre_location l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r802

//Fixed-Effects Regression//
xtreg rural_genre_location l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings, i(dptid) fe vce(robust)
eststo r803

//Fixed-Effects Regression with Year Dummies//
xtreg rural_genre_location l2.colonies l2.avg_paris_price_int l2.major_neigh l2.touri l2.labor_active l2.pctag_int l2.total_paintings y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, i(dptid) fe vce(robust) 
eststo r804

estout r801 r802 r803 r804, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))

**********************************************************************************************
//Versions of xtregar but no vce robust//

//General Regression//
reg pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale
eststo r101

//General Regression plus Year Dummies//
reg pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44
eststo r102

//Fixed-Effects Regression//
xtregar pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale, fe
eststo r103

//Fixed-Effects Regression with Year Dummies//
xtregar pct_landscapes colonies_scale avg_price_scale major_neigh_scale touri_scale labor_active_scale pctag_int_scale y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14 y15 y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30 y31 y32 y33 y34 y35 y36 y37 y38 y39 y40 y41 y42 y43 y44, fe 
eststo r104

estout r101 r102 r103 r104, cells(b(star fmt(%9.3f)) t(par fmt(%9.2f)) ) style(fixed) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N r2 F, fmt(%9.0f %9.2f %9.2f))

